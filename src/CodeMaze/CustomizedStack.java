package CodeMaze;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

import static UserData.CurrentCreditionals.getUsername;

public class CustomizedStack {

    private List<String> stack; // Format: chapterId.questionId.reminderTime.status

    public CustomizedStack() {
        stack = new ArrayList<>();
    }

    public void push(String task) {
        if (task != null && !task.trim().isEmpty()) {
            stack.add(task);
            saveStackToFile();
        }
    }

    public String pop() {
        if (!isEmpty()) {
            String item = stack.remove(stack.size() - 1);
            saveStackToFile();
            return item;
        }
        return null;
    }

    public List<String> getAllTasks() {
        return new ArrayList<>(stack);
    }

    public boolean isEmpty() {
        return stack.isEmpty();
    }

    public void markCompleted(int index) {
        if (index < 0 || index >= stack.size()) return;
        String task = stack.get(index);
        String[] parts = task.split("\\.");
        if (parts.length != 4) return;
        parts[3] = "Completed";
        stack.set(index, String.join(".", parts));
        saveStackToFile();
    }

    public void removeTask(int index) {
        if (index < 0 || index >= stack.size()) return;
        stack.remove(index);
        saveStackToFile();
    }

    public void saveStackToFile() {
        File f = new File(getUsername() + "SolveLater.txt");
        try (FileWriter fw = new FileWriter(f, false)) { // overwrite
            for (String task : stack) {
                fw.write(task + "\n");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void loadFromFile() {
        File f = new File(getUsername() + "SolveLater.txt");
        if (!f.exists()) return;
        try (BufferedReader br = new BufferedReader(new FileReader(f))) {
            String line;
            while ((line = br.readLine()) != null) {
                stack.add(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
