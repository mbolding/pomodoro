#!/usr/bin/env ruby
# A simple command-line Pomodoro timer

def format_time(seconds)
  mins, secs = seconds.divmod(60)
  "%02d:%02d" % [mins, secs]
end

def countdown(duration_minutes, label)
  total_seconds = duration_minutes * 60
  puts "\n#{label} - #{duration_minutes} minutes"
  puts "-" * 30

  total_seconds.downto(1) do |remaining|
    print "\r  Time remaining: #{format_time(remaining)} "
    $stdout.flush
    sleep(1)
  end

  print "\r  Time remaining: 00:00 \n"
  puts "\n*** #{label} complete! ***\a"
  true
rescue Interrupt
  puts "\n\nTimer stopped."
  false
end

def pomodoro
  work_duration = 25
  short_break = 5
  long_break = 15
  pomodoros_before_long_break = 4

  puts "=" * 40
  puts "       POMODORO TIMER"
  puts "=" * 40
  puts "  Work session:  #{work_duration} min"
  puts "  Short break:   #{short_break} min"
  puts "  Long break:    #{long_break} min (every #{pomodoros_before_long_break} pomodoros)"
  puts "=" * 40
  puts "Press Ctrl+C to stop\n"

  pomodoro_count = 0

  loop do
    pomodoro_count += 1
    puts "\n[Pomodoro ##{pomodoro_count}]"

    break unless countdown(work_duration, "WORK")

    print "Press Enter to start break..."
    gets

    if (pomodoro_count % pomodoros_before_long_break).zero?
      break unless countdown(long_break, "LONG BREAK")
    else
      break unless countdown(short_break, "SHORT BREAK")
    end

    print "Press Enter to start next pomodoro..."
    gets
  end
rescue Interrupt
  puts "\n\nPomodoro session ended."
ensure
  puts "\nCompleted #{pomodoro_count} pomodoro(s). Great work!"
end

pomodoro if __FILE__ == $PROGRAM_NAME
