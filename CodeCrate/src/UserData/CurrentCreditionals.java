package UserData;

public class CurrentCreditionals {
    private static String currentUsername;
    private static String currentEmail;

    public static void setCurrentUser(String username, String email) {
        currentUsername = username;
        currentEmail = email;
    }

    public static String getUsername() {
        return currentUsername;
    }

    public static String getEmail() {
        return currentEmail;
    }

}
