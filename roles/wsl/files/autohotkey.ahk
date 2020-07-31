;Run, *RunAs <path> to run as Administrator

; RoA means "RunOrActivate"
RoA(PIDName, Target) {
    Process, Exist, %PIDName%
	If Not ErrorLevel ; errorlevel will = 0 if process doesn't exist
	{
	    Run, %Target%
	}
	Else
	    WinActivate,% "ahk_pid  " ErrorLevel ; errorlevel will = Process ID (PID) if process exists
}
#t::RoA("WindowsTerminal.exe", "wt.exe")
#c::RoA("chrome.exe", "chrome.exe")
