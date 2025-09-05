package CodeMaze;

import java.io.IOException;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Scanner;
import org.json.JSONObject;

import static CodeMaze.DisplayQuestion.*;

public class ConnectionToAPI {

    public static String stdout;
    private final StringBuilder formattedOutput = new StringBuilder();

    public ConnectionToAPI() throws IOException {

        // Setup connection
        URL url = new URL("https://judge0-ce.p.rapidapi.com/submissions?base64_encoded=false&wait=true");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();

        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
      //  conn.setRequestProperty("X-RapidAPI-Key", "5dd371ec26mshb4e029d3ef5ccedp17c05djsn057a468432bc");
        conn.setRequestProperty("X-RapidAPI-Key", "e194997bbcmsh1bb06a7f3c17a8bp14bb7fjsn4de844570d68");
        conn.setRequestProperty("X-RapidAPI-Host", "judge0-ce.p.rapidapi.com");
        conn.setDoOutput(true);

        // ✅ prepare code
        String code = cleanedCode.replaceAll("\t+", " ");
        code = code.replaceAll("\t", "\n");  // escape newlines properly

        String jsonInputString = "{"
                + "\"language_id\": 62,"
                + "\"source_code\": " + "\"" + code.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n") + "\""
                + "}";

        try (OutputStream os = conn.getOutputStream()) {
            byte[] input = jsonInputString.getBytes("utf-8");
            os.write(input, 0, input.length);
        }

        // ✅ read response
        Scanner scanner = new Scanner(conn.getInputStream());
        StringBuilder response = new StringBuilder();
        while (scanner.hasNext()) {
            response.append(scanner.nextLine());
        }

        JSONObject json = new JSONObject(response.toString());


        // ✅ extract fields
        stdout = json.optString("stdout", ""); // update static stdout
        String status = json.getJSONObject("status").optString("description", "Unknown");
        String compileOutput = json.optString("compile_output", "");
        String stderr = json.optString("stderr", "");


        // ✅ build formatted output
        formattedOutput.append("Status: ").append(status).append("\n");

        if ("Compilation Error".equalsIgnoreCase(status)) {
            formattedOutput.append("Compilation Error:\n").append(compileOutput).append("\n");
        } else if ("Runtime Error".equalsIgnoreCase(status)) {
            formattedOutput.append("Runtime Error:\n").append(stderr).append("\n");
        } else if ("Accepted".equalsIgnoreCase(status)) {
            formattedOutput.append("Output:\n").append(stdout).append("\n");
        } else {
            formattedOutput.append("Other Info:\n").append(stdout).append("\n");
        }
    }


    // ✅ returns formatted result
    public String getFormattedOutput() {
        return formattedOutput.toString();
    }


    // ✅ submit wrapper
    public void submitOutput() {
        new AnswerValidation(stdout, timeTaken);
    }
}


    /*
    judge0api post format
    {
            "source_code": "#include <stdio.h>\nint main() { int a; scanf(\"%d\", &a); printf(\"%d\\n\", a*2); return 0; }",
            "language_id": 50,
            "stdin": "21",
            "expected_output": "42\n",
            "cpu_time_limit": "2",
            "memory_limit": "1024"
            }*/


    /*
    judge0api post format
    {
            "source_code": "#include <stdio.h>\nint main() { int a; scanf(\"%d\", &a); printf(\"%d\\n\", a*2); return 0; }",
            "language_id": 50,
            "stdin": "21",
            "expected_output": "42\n",
            "cpu_time_limit": "2",
            "memory_limit": "1024"
            }*/
/*// Setup connection
        URL url = new URL("https://judge0-ce.p.rapidapi.com/submissions?base64_encoded=false&wait=true");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();

        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setRequestProperty("X-RapidAPI-Key", "5dd371ec26mshb4e029d3ef5ccedp17c05djsn057a468432bc");
        conn.setRequestProperty("X-RapidAPI-Host", "judge0-ce.p.rapidapi.com");
        conn.setDoOutput(true);
         String jsonInputString = "{"
                + "\"language_id\": 62,"
                + "\"source_code\": " + "\"" + code.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n") + "\""
                + "}";
 */