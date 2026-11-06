set helper to quoted form of POSIX path of (path to resource "toggle.sh")
set adminUser to short user name of (system info)
set statusLine to ""

repeat
	set isBlocked to (do shell script "grep -q '^# BEGIN youtube-switch$' /etc/hosts && echo yes || echo no") is "yes"
	if isBlocked then
		set msg to "YouTube is BLOCKED on this Mac."
		set act to "Allow YouTube"
		set mode to "allow"
	else
		set msg to "YouTube is ALLOWED on this Mac."
		set act to "Block YouTube"
		set mode to "block"
	end if

	set choice to button returned of (display dialog statusLine & msg buttons {"Quit", act} default button act cancel button "Quit" with title "YouTube Switch" with icon (path to resource "applet.icns"))

	try
		do shell script "/bin/sh " & helper & " " & mode & " " & quoted form of adminUser with administrator privileges
		if mode is "block" then
			set statusLine to "Done. Chrome was closed in other accounts." & return & return
		else
			set statusLine to "Done." & return & return
		end if
	on error errMsg number errNum
		if errNum is -128 then
			set statusLine to "Not changed (password cancelled)." & return & return
		else
			set statusLine to "Something went wrong: " & errMsg & return & return
		end if
	end try
end repeat
