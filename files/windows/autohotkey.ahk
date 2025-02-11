; RoA means "RunOrActivate"
RoA(PIDName, Target := "") {
    if (Target == "")
        Target := PIDName

    if (pid := ProcessExist(PIDName)) {
        WinActivate("ahk_pid " . pid)
        return
    }

    Run(Target)
}

#t::RoA("WindowsTerminal.exe", "wt.exe")
#c::RoA("chrome.exe")
#g::RoA("Telegram.exe")
#v::RoA("vlc.exe")
#n::RoA("ONENOTE.EXE")
#f::RoA("firefox.exe")
#q::RoA("SecureCRT.exe")
#o::RoA("notepad++.exe")
