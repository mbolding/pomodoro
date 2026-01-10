/* A simple command-line Pomodoro timer in C */

#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <unistd.h>

#define WORK_DURATION 25
#define SHORT_BREAK 5
#define LONG_BREAK 15
#define POMODOROS_BEFORE_LONG_BREAK 4

static int pomodoro_count = 0;
static volatile int is_running = 1;

void format_time(int seconds, char *buffer) {
    int mins = seconds / 60;
    int secs = seconds % 60;
    sprintf(buffer, "%02d:%02d", mins, secs);
}

void cleanup(int sig) {
    (void)sig;
    printf("\n\nPomodoro session ended.\n");
    printf("Completed %d pomodoro(s). Great work!\n", pomodoro_count);
    exit(0);
}

int countdown(int duration_minutes, const char *label) {
    int total_seconds = duration_minutes * 60;
    char time_str[6];

    printf("\n%s - %d minutes\n", label, duration_minutes);
    printf("------------------------------\n");

    for (int remaining = total_seconds; remaining > 0 && is_running; remaining--) {
        format_time(remaining, time_str);
        printf("\r  Time remaining: %s ", time_str);
        fflush(stdout);
        sleep(1);
    }

    printf("\r  Time remaining: 00:00 \n");
    printf("\n*** %s complete! ***\a\n", label);
    return is_running;
}

void wait_for_enter(const char *message) {
    printf("%s", message);
    fflush(stdout);
    while (getchar() != '\n');
}

int main(void) {
    signal(SIGINT, cleanup);

    printf("========================================\n");
    printf("       POMODORO TIMER\n");
    printf("========================================\n");
    printf("  Work session:  %d min\n", WORK_DURATION);
    printf("  Short break:   %d min\n", SHORT_BREAK);
    printf("  Long break:    %d min (every %d pomodoros)\n",
           LONG_BREAK, POMODOROS_BEFORE_LONG_BREAK);
    printf("========================================\n");
    printf("Press Ctrl+C to stop\n\n");

    while (is_running) {
        pomodoro_count++;
        printf("\n[Pomodoro #%d]\n", pomodoro_count);

        if (!countdown(WORK_DURATION, "WORK")) break;

        wait_for_enter("Press Enter to start break...");

        int break_duration;
        const char *break_label;

        if (pomodoro_count % POMODOROS_BEFORE_LONG_BREAK == 0) {
            break_duration = LONG_BREAK;
            break_label = "LONG BREAK";
        } else {
            break_duration = SHORT_BREAK;
            break_label = "SHORT BREAK";
        }

        if (!countdown(break_duration, break_label)) break;

        wait_for_enter("Press Enter to start next pomodoro...");
    }

    cleanup(0);
    return 0;
}
