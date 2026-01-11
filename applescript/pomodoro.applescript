-- A simple command-line Pomodoro timer in AppleScript

property workDuration : 25
property shortBreak : 5
property longBreak : 15
property pomodorosBeforeLongBreak : 4

on formatTime(totalSeconds)
	set mins to totalSeconds div 60
	set secs to totalSeconds mod 60
	set minsStr to text -2 thru -1 of ("0" & mins)
	set secsStr to text -2 thru -1 of ("0" & secs)
	return minsStr & ":" & secsStr
end formatTime

on countdown(durationMinutes, labelText)
	set totalSeconds to durationMinutes * 60

	log ""
	log labelText & " - " & durationMinutes & " minutes"
	log "------------------------------"

	repeat with remaining from totalSeconds to 1 by -1
		do shell script "printf '\\r  Time remaining: " & formatTime(remaining) & " '"
		delay 1
	end repeat

	do shell script "printf '\\r  Time remaining: 00:00 \\n'"
	log ""
	log "*** " & labelText & " complete! ***"
	beep

	return true
end countdown

on promptUser(message)
	do shell script "printf '" & message & "'"
	display dialog message buttons {"Continue"} default button "Continue" giving up after 300
end promptUser

on run
	log "========================================"
	log "       POMODORO TIMER"
	log "========================================"
	log "  Work session:  " & workDuration & " min"
	log "  Short break:   " & shortBreak & " min"
	log "  Long break:    " & longBreak & " min (every " & pomodorosBeforeLongBreak & " pomodoros)"
	log "========================================"
	log "Close dialog or Cmd+. to stop"
	log ""

	set pomodoroCount to 0

	repeat
		set pomodoroCount to pomodoroCount + 1
		log ""
		log "[Pomodoro #" & pomodoroCount & "]"

		countdown(workDuration, "WORK")

		display notification "Work session complete!" with title "Pomodoro Timer" sound name "Glass"
		promptUser("Press Continue to start break...")

		if pomodoroCount mod pomodorosBeforeLongBreak = 0 then
			countdown(longBreak, "LONG BREAK")
		else
			countdown(shortBreak, "SHORT BREAK")
		end if

		display notification "Break complete!" with title "Pomodoro Timer" sound name "Glass"
		promptUser("Press Continue to start next pomodoro...")
	end repeat
end run
