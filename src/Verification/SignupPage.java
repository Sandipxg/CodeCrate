package Verification;

import MailSenders.WelcomeMailSender;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import static CodeMaze.jdbcConnections.con;

public class SignupPage extends JPanel {
    private final CardLayout cardLayout;
    private final JPanel mainPanel;

    public SignupPage(CardLayout cardLayout, JPanel mainPanel) {
        this.cardLayout = cardLayout;
        this.mainPanel = mainPanel;
        setLayout(new BorderLayout(20, 20));
        setBackground(new Color(210, 180, 140)); // Cream background

        // 🔹 Title
        JPanel topPanel = new JPanel(new BorderLayout());
        topPanel.setOpaque(false);
        topPanel.setBorder(BorderFactory.createEmptyBorder(50, 0, 30, 0));

        JLabel title = new JLabel("REGISTER FOR CODECRATE", SwingConstants.CENTER);
        title.setFont(new Font("Segoe UI Black", Font.BOLD, 60));
        title.setForeground(new Color(101, 67, 33)); // Brown text
        topPanel.add(title, BorderLayout.CENTER);

        // 🔹 Form
        JPanel form = new JPanel(new GridBagLayout());
        form.setOpaque(false);
        GridBagConstraints gbc = new GridBagConstraints();
        gbc.insets = new Insets(15, 15, 15, 15);
        gbc.fill = GridBagConstraints.HORIZONTAL;

        JLabel usernameLabel = new JLabel("Username:");
        usernameLabel.setForeground(new Color(101, 67, 33));
        usernameLabel.setFont(new Font("Segoe UI", Font.PLAIN, 45));

        JTextField usernameField = new JTextField();
        usernameField.setFont(new Font("Segoe UI", Font.PLAIN, 40));
        usernameField.setPreferredSize(new Dimension(500, 65));
        usernameField.setBackground(new Color(245, 245, 220)); // Light cream
        usernameField.setForeground(new Color(60, 40, 20));   // Dark brown text

        JLabel emailLabel = new JLabel("Email:");
        emailLabel.setForeground(new Color(101, 67, 33));
        emailLabel.setFont(new Font("Segoe UI", Font.PLAIN, 45));

        JTextField emailField = new JTextField();
        emailField.setFont(new Font("Segoe UI", Font.PLAIN, 40));
        emailField.setPreferredSize(new Dimension(500, 65));
        emailField.setBackground(new Color(245, 245, 220));
        emailField.setForeground(new Color(60, 40, 20));

        JLabel passwordLabel = new JLabel("Password:");
        passwordLabel.setForeground(new Color(101, 67, 33));
        passwordLabel.setFont(new Font("Segoe UI", Font.PLAIN, 45));

        JPasswordField passwordField = new JPasswordField();
        passwordField.setFont(new Font("Segoe UI", Font.PLAIN, 40));
        passwordField.setPreferredSize(new Dimension(500, 65));
        passwordField.setBackground(new Color(245, 245, 220));
        passwordField.setForeground(new Color(60, 40, 20));

        JButton signupButton = new JButton("Register");
        signupButton.setBackground(new Color(101, 67, 33)); // Brown
        signupButton.setForeground(Color.WHITE);
        signupButton.setFont(new Font("Segoe UI Semibold", Font.BOLD, 45));
        signupButton.setPreferredSize(new Dimension(250, 90));

        JButton backButton = new JButton("Back");
        backButton.setBackground(new Color(160, 82, 45)); // SaddleBrown
        backButton.setForeground(Color.WHITE);
        backButton.setFont(new Font("Segoe UI Semibold", Font.BOLD, 45));
        backButton.setPreferredSize(new Dimension(250, 90));

        // Layout
        gbc.gridx = 0; gbc.gridy = 0; form.add(usernameLabel, gbc);
        gbc.gridx = 1; gbc.gridy = 0; form.add(usernameField, gbc);

        gbc.gridx = 0; gbc.gridy = 1; form.add(emailLabel, gbc);
        gbc.gridx = 1; gbc.gridy = 1; form.add(emailField, gbc);

        gbc.gridx = 0; gbc.gridy = 2; form.add(passwordLabel, gbc);
        gbc.gridx = 1; gbc.gridy = 2; form.add(passwordField, gbc);

        gbc.gridx = 0; gbc.gridy = 3; form.add(backButton, gbc);
        gbc.gridx = 1; gbc.gridy = 3; form.add(signupButton, gbc);

        add(topPanel, BorderLayout.NORTH);
        add(form, BorderLayout.CENTER);

        // 🔹 Actions (unchanged logic)
        signupButton.addActionListener((ActionEvent e) -> {
            String username = usernameField.getText().trim();
            String email = emailField.getText().trim();
            String password = new String(passwordField.getPassword());
            try {
                String query = "INSERT INTO user (user_name, email, password) VALUES (?, ?, ?)";
                PreparedStatement ps = con.prepareStatement(query);
                ps.setString(1, username);
                ps.setString(2, email);
                ps.setString(3, password);

                ps.executeUpdate();
                JOptionPane.showMessageDialog(null, "User registered successfully!");

            } catch (SQLException ex) {
                String errorMessage = ex.getMessage();
                if (errorMessage.contains("Invalid email address")) {
                    JOptionPane.showMessageDialog(null, "❌ Please enter a valid email address (must contain @).");
                } else if (errorMessage.contains("Username already exists")) {
                    JOptionPane.showMessageDialog(null, "⚠️ Username already exists. Try another one.");
                } else {
                    JOptionPane.showMessageDialog(null, "Database Error: " + errorMessage);
                }
                return;
            }

            if (username.isEmpty() || email.isEmpty() || password.isEmpty()) {
                JOptionPane.showMessageDialog(this, "Please fill in all fields.");
                return;
            }

            try (BufferedWriter bw = new BufferedWriter(new FileWriter("users.txt", true))) {
                bw.write(username + "," + email + "," + password + "\n");
            } catch (Exception ex) {
                JOptionPane.showMessageDialog(this, "Error saving user.");
                return;
            }

            try {
                WelcomeMailSender.sendWelcomeMail(email, username);
            } catch (Exception ex) {
                ex.printStackTrace();
            }

            JOptionPane.showMessageDialog(this, "Account created! You can now login.");
            cardLayout.show(mainPanel, "login");
        });

        backButton.addActionListener(e -> cardLayout.show(mainPanel, "welcome"));
    }

    public JPanel getPanel() {
        return this;
    }
}
