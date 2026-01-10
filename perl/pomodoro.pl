#!/usr/bin/env perl
# A simple command-line Pomodoro timer

use strict;
use warnings;
use POSIX qw(floor);

$| = 1;  # Disable output buffering

my $WORK_DURATION = 25;
my $SHORT_BREAK = 5;
my $LONG_BREAK = 15;
my $POMODOROS_BEFORE_LONG_BREAK = 4;

my $pomodoro_count = 0;

sub format_time {
    my ($seconds) = @_;
    my $mins = floor($seconds / 60);
    my $secs = $seconds % 60;
    return sprintf("%02d:%02d", $mins, $secs);
}

sub countdown {
    my ($duration_minutes, $label) = @_;
    my $total_seconds = $duration_minutes * 60;

    print "\n$label - $duration_minutes minutes\n";
    print "-" x 30 . "\n";

    for (my $remaining = $total_seconds; $remaining > 0; $remaining--) {
        print "\r  Time remaining: " . format_time($remaining) . " ";
        sleep(1);
    }

    print "\r  Time remaining: 00:00 \n";
    print "\n*** $label complete! ***\a\n";
    return 1;
}

sub cleanup {
    print "\n\nPomodoro session ended.\n";
    print "Completed $pomodoro_count pomodoro(s). Great work!\n";
    exit(0);
}

$SIG{INT} = \&cleanup;

print "=" x 40 . "\n";
print "       POMODORO TIMER\n";
print "=" x 40 . "\n";
print "  Work session:  $WORK_DURATION min\n";
print "  Short break:   $SHORT_BREAK min\n";
print "  Long break:    $LONG_BREAK min (every $POMODOROS_BEFORE_LONG_BREAK pomodoros)\n";
print "=" x 40 . "\n";
print "Press Ctrl+C to stop\n\n";

while (1) {
    $pomodoro_count++;
    print "\n[Pomodoro #$pomodoro_count]\n";

    countdown($WORK_DURATION, "WORK");

    print "Press Enter to start break...";
    <STDIN>;

    if ($pomodoro_count % $POMODOROS_BEFORE_LONG_BREAK == 0) {
        countdown($LONG_BREAK, "LONG BREAK");
    } else {
        countdown($SHORT_BREAK, "SHORT BREAK");
    }

    print "Press Enter to start next pomodoro...";
    <STDIN>;
}
