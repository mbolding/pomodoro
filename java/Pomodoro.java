/**
 * A simple command-line Pomodoro timer in Java.
 */
public class Pomodoro {
    private static final int WORK_DURATION = 25;
    private static final int SHORT_BREAK = 5;
    private static final int LONG_BREAK = 15;
    private static final int POMODOROS_BEFORE_LONG_BREAK = 4;

    private static int pomodoroCount = 0;
    private static volatile boolean isRunning = true;

    public static void main(String[] args) {
        // Setup shutdown hook for Ctrl+C
        Runtime.getRuntime().addShutdownHook(new Thread(() -> {
            if (!isRunning) {
                System.out.println("\n\nPomodoro session ended.");
                System.out.printf("Completed %d pomodoro(s). Great work!\n", pomodoroCount);
            }
        }));

        System.out.println("========================================");
        System.out.println("       POMODORO TIMER");
        System.out.println("========================================");
        System.out.printf("  Work session:  %d min\n", WORK_DURATION);
        System.out.printf("  Short break:   %d min\n", SHORT_BREAK);
        System.out.printf("  Long break:    %d min (every %d pomodoros)\n",
                LONG_BREAK, POMODOROS_BEFORE_LONG_BREAK);
        System.out.println("========================================");
        System.out.println("Press Ctrl+C to stop\n");

        try {
            while (isRunning) {
                pomodoroCount++;
                System.out.printf("\n[Pomodoro #%d]\n", pomodoroCount);

                if (!countdown(WORK_DURATION, "WORK")) break;

                waitForEnter("Press Enter to start break...");

                if (pomodoroCount % POMODOROS_BEFORE_LONG_BREAK == 0) {
                    if (!countdown(LONG_BREAK, "LONG BREAK")) break;
                } else {
                    if (!countdown(SHORT_BREAK, "SHORT BREAK")) break;
                }

                waitForEnter("Press Enter to start next pomodoro...");
            }
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        } finally {
            isRunning = false;
        }

        System.out.println("\n\nPomodoro session ended.");
        System.out.printf("Completed %d pomodoro(s). Great work!\n", pomodoroCount);
    }

    private static String formatTime(int seconds) {
        int mins = seconds / 60;
        int secs = seconds % 60;
        return String.format("%02d:%02d", mins, secs);
    }

    private static boolean countdown(int durationMinutes, String label) throws InterruptedException {
        int totalSeconds = durationMinutes * 60;

        System.out.printf("\n%s - %d minutes\n", label, durationMinutes);
        System.out.println("------------------------------");

        for (int remaining = totalSeconds; remaining > 0 && isRunning; remaining--) {
            System.out.printf("\r  Time remaining: %s ", formatTime(remaining));
            System.out.flush();
            Thread.sleep(1000);
        }

        System.out.print("\r  Time remaining: 00:00 \n");
        System.out.printf("\n*** %s complete! ***\u0007\n", label);
        return isRunning;
    }

    private static void waitForEnter(String message) {
        System.out.print(message);
        System.out.flush();
        try {
            System.in.read();
            // Clear remaining input
            while (System.in.available() > 0) {
                System.in.read();
            }
        } catch (Exception e) {
            // Ignore
        }
    }
}
