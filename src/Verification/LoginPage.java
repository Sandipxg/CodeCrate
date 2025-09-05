package Verification;

import UserData.CurrentCreditionals;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.io.BufferedReader;
import java.io.FileReader;

public class LoginPage extends JPanel {
    private CardLayout cardLayout;
    private JPanel mainPanel;

    private JTextField emailField;
    private JPasswordField passwordField;

    public LoginPage(CardLayout cardLayout, JPanel mainPanel) {
        this.cardLayout = cardLayout;
        this.mainPanel = mainPanel;
        setLayout(new BorderLayout(20, 20));

        //  Cream background
        setBackground(new Color(245, 239, 230));

        //  Wrapper panel to center title between top & form
        JPanel topPanel = new JPanel(new BorderLayout());
        topPanel.setOpaque(false);
        topPanel.setBorder(BorderFactory.createEmptyBorder(50, 0, 30, 0));

        JLabel title = new JLabel("LOGIN TO CODECRATE", SwingConstants.CENTER);
        title.setFont(new Font("Segoe UI Black", Font.BOLD, 75));
        title.setForeground(new Color(92, 64, 51)); // coffee brown
        topPanel.add(title, BorderLayout.CENTER);

        // 🔹 Form panel
        JPanel form = new JPanel(new GridBagLayout());
        form.setOpaque(false);
        GridBagConstraints gbc = new GridBagConstraints();
        gbc.insets = new Insets(15, 15, 15, 15);
        gbc.fill = GridBagConstraints.HORIZONTAL;

        JLabel emailLabel = new JLabel("Email:");
        emailLabel.setForeground(new Color(80, 50, 20)); // dark brown
        emailLabel.setFont(new Font("Segoe UI", Font.PLAIN, 45));

        emailField = new JTextField();
        emailField.setFont(new Font("Segoe UI", Font.PLAIN, 40));
        emailField.setPreferredSize(new Dimension(500, 65));
        emailField.setBackground(Color.WHITE);
        emailField.setForeground(new Color(50, 30, 20));
        emailField.setBorder(BorderFactory.createLineBorder(new Color(160, 130, 100), 2));

        JLabel passwordLabel = new JLabel("Password:");
        passwordLabel.setForeground(new Color(80, 50, 20)); // dark brown
        passwordLabel.setFont(new Font("Segoe UI", Font.PLAIN, 45));

        passwordField = new JPasswordField();
        passwordField.setFont(new Font("Segoe UI", Font.PLAIN, 40));
        passwordField.setPreferredSize(new Dimension(500, 65));
        passwordField.setBackground(Color.WHITE);
        passwordField.setForeground(new Color(50, 30, 20));
        passwordField.setBorder(BorderFactory.createLineBorder(new Color(160, 130, 100), 2));

        JButton loginButton = new JButton("Login");
        Color loginNormal = new Color(150, 75, 0);   // chocolate brown
        Color loginHover = new Color(120, 60, 0);   // darker brown
        loginButton.setBackground(loginNormal);
        loginButton.setForeground(Color.WHITE);
        loginButton.setFont(new Font("Segoe UI Semibold", Font.BOLD, 45));
        loginButton.setPreferredSize(new Dimension(250, 90));



        JButton backButton = new JButton("Back");
        Color backNormal = new Color(210, 180, 140);  // tan
        Color backHover = new Color(180, 150, 110);   // darker tan
        backButton.setBackground(backNormal);
        backButton.setForeground(new Color(60, 40, 20));
        backButton.setFont(new Font("Segoe UI Semibold", Font.BOLD, 45));
        backButton.setPreferredSize(new Dimension(250, 90));



        gbc.gridx = 0; gbc.gridy = 0; form.add(emailLabel, gbc);
        gbc.gridx = 1; gbc.gridy = 0; form.add(emailField, gbc);

        gbc.gridx = 0; gbc.gridy = 1; form.add(passwordLabel, gbc);
        gbc.gridx = 1; gbc.gridy = 1; form.add(passwordField, gbc);

        gbc.gridx = 0; gbc.gridy = 2; form.add(backButton, gbc);
        gbc.gridx = 1; gbc.gridy = 2; form.add(loginButton, gbc);

        add(topPanel, BorderLayout.NORTH);
        add(form, BorderLayout.CENTER);

        loginButton.addActionListener((ActionEvent e) -> handleLogin());
        backButton.addActionListener(e -> cardLayout.show(mainPanel, "welcome"));
    }

    private void handleLogin() {
        String email = emailField.getText().trim();
        String password = new String(passwordField.getPassword());

        if (email.isEmpty() || password.isEmpty()) {
            JOptionPane.showMessageDialog(this, "Please fill in all fields.");
            return;
        }

        boolean success = false;
        String username = "";

        try (BufferedReader br = new BufferedReader(new FileReader("users.txt"))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 3 && parts[1].equals(email) && parts[2].equals(password)) {
                    username = parts[0];
                    success = true;
                    break;
                }
            }
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(this, "Error reading users.");
            return;
        }

        if (success) {
            JOptionPane.showMessageDialog(this, "Welcome back, " + username + "!");
            CurrentCreditionals.setCurrentUser(username, email);
            cardLayout.show(mainPanel, "Dashboard_files");
        } else {
            JOptionPane.showMessageDialog(this, "Invalid email or password.");
        }
    }

    public JPanel getPanel() {
        return this;
    }
}
