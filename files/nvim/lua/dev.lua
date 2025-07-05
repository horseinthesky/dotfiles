local nmap = require "config.utils".nmap

-- Treesitter utils
local function find_node_ancestor(node, type)
  if not node then
    return nil
  end

  if node:type() == type then
    return node
  end

  return find_node_ancestor(node:parent(), type)
end

local function find_child_by_type(node, type)
  if not node then return nil end

  for child in node:iter_children() do
    if child:type() == type then
      return child
    end
  end

  return nil
end

-- Go add tags
local function add_tags(tags)
  -- Define tag format we are going to generate
  local formats = { "json" }
  if tags ~= "" then
    formats = vim.split(tags, ",")
  end

  local current_node = vim.treesitter.get_node()

  -- Find type_declaration ansector node
  local type_declaration_node = find_node_ancestor(current_node, "type_declaration")
  if not type_declaration_node then
    vim.notify("type_declaration not found", vim.log.levels.WARN)
    return
  end

  -- Find type_spec node inside type_declaration node
  local type_spec_node = find_child_by_type(type_declaration_node, "type_spec")
  if not type_spec_node then
    vim.notify("type_spec not found", vim.log.levels.WARN)
    return
  end

  -- Find struct_type node inside type_spec node
  local struct_type_node = find_child_by_type(type_spec_node, "struct_type")
  if not struct_type_node then
    vim.notify("struct_type not found", vim.log.levels.WARN)
    return
  end

  -- Find field_declaration_list node inside struct_type node
  local field_list_node = find_child_by_type(struct_type_node, "field_declaration_list")
  if not field_list_node then
    vim.notify("field_declaration_list not found", vim.log.levels.WARN)
    return
  end

  -- First pass: collect field data and find max length
  local all_fields_params = {}
  local max_length = 0

  local bufnr = vim.api.nvim_get_current_buf()

  for child in field_list_node:iter_children() do
    if child:type() ~= "field_declaration" then goto continue end

    local field_name
    for field in child:iter_children() do
      if field:type() == "field_identifier" then
        field_name = vim.treesitter.get_node_text(field, bufnr)
        break
      end
    end

    -- Skip anonymous fields
    if not field_name then goto continue end

    -- Get field position
    local start_row, start_col, end_row, end_col = child:range()

    -- Get current field text
    local lines = vim.api.nvim_buf_get_lines(bufnr, start_row, end_row + 1, false)
    local existing_field_text = table.concat(lines, "\n")

    -- Remove existing tags
    local cleaned_field_text = existing_field_text
        :gsub('`[^`]*`', '') -- Remove all tags
        :gsub('%s+$', '')    -- Remove trailing whitespaces

    -- Calculate length of cleaned field text
    local field_length = #cleaned_field_text
    if field_length > max_length then
      max_length = field_length
    end

    -- Save field data
    table.insert(all_fields_params, {
      name = field_name,
      text = cleaned_field_text,
      start_row = start_row,
      end_row = end_row,
      length = field_length
    })

    ::continue::
  end

  -- Second pass: generate aligned tags
  local changes = {}

  for _, field in ipairs(all_fields_params) do
    -- Convert field name to snake_case
    local snake_case = field.name
        :gsub("%u", "_%1") -- Add underline before capital letters
        :lower()           -- Lowercase everything
        :gsub("^_", "")    -- Remove leading underscore if any

    -- Generate tags
    local field_tags = {}
    for _, arg in ipairs(formats) do
      table.insert(field_tags, string.format('%s:"%s"', arg, snake_case))
    end

    -- Create tag string
    local tag_string = " `" .. table.concat(field_tags, " ") .. "`"

    -- Calculate padding
    local padding_length = max_length - field.length
    local padding = string.rep(" ", padding_length)

    -- Build new field text with aligned tags
    local text_with_tags = field.text .. padding .. tag_string

    -- Save changes
    table.insert(changes, {
      start_row = field.start_row,
      end_row = field.end_row + 1,
      text = { text_with_tags }
    })
  end

  -- Apply new tags
  for _, change in ipairs(changes) do
    vim.api.nvim_buf_set_lines(
      bufnr,
      change.start_row,
      change.end_row,
      false,
      change.text
    )
  end
end

vim.api.nvim_create_user_command("GoTags", function(opts) add_tags(opts.args) end, { nargs = "*" })
nmap("<leader>ct", function() add_tags("") end, { desc = "Tags" })
