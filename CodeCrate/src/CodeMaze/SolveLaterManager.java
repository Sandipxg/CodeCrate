package CodeMaze;

import javax.swing.*;
import java.util.HashMap;
import java.util.Map;

import static CodeMaze.DisplayQuestion.stack;

public class SolveLaterManager {


    private final Map<Integer, Timer> reminderTimers;

    public SolveLaterManager(CustomizedStack stack) {

        this.reminderTimers = new HashMap<>();
    }

    // Add task with reminder
    public void addTask(int chapterId, int questionId) {
        try {
            String input = JOptionPane.showInputDialog(
                    null,
                    "Enter reminder time in seconds for Chapter " + chapterId + " Q" + questionId + ":",
                    "Set Reminder",
                    JOptionPane.QUESTION_MESSAGE
            );
            if (input == null || input.trim().isEmpty()) return;
            int reminderTime = Integer.parseInt(input.trim());
            if (reminderTime <= 0) return;


            String task = chapterId + "." + questionId + "." + reminderTime + ".Pending";
            stack.push(task);

            int taskIndex = stack.getAllTasks().size() - 1;

            Timer timer = new Timer(reminderTime * 1000, e -> {
                JOptionPane.showMessageDialog(null,
                        "⏰ Reminder: Chapter " + chapterId + " | Question " + questionId + " is pending!",
                        "Solve Later Reminder",
                        JOptionPane.INFORMATION_MESSAGE);
            });
            timer.setRepeats(true);
            timer.start();

            reminderTimers.put(taskIndex, timer);

        } catch (NumberFormatException e) {
            JOptionPane.showMessageDialog(null, "⚠ Invalid number entered!", "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

    // Stop reminder for a task
    public void stopReminder(int index) {
        Timer t = reminderTimers.get(index);
        if (t != null) t.stop();
        reminderTimers.remove(index);
    }
}
