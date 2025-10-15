# CodeCrate
**The Developers Kit**

CodeCrate is a comprehensive desktop application toolkit designed to enhance the productivity of developers, especially those practicing coding and managing reusable code snippets. Built entirely in Java, CodeCrate integrates various modules and utilities into one platform.

## ⚡️ Features

- 🗂 **Code Snippet Manager**
  - Store, add, edit, view, and manage your code snippets
  - Includes a Recycle Bin for deleted snippets

- 🎯 **CodeMaze**
  - Practice coding questions organized by chapters
  - Answer validation system for checking solutions
  - 🏆 Leaderboard to track user progress and performance
  - 🧠 Solve Later feature to bookmark unsolved problems

- 💻 **LeetCode Integration**
  - Access specialized panel for LeetCode-like exercises

- 🔒 **User Management**
  - User registration and authentication
  - Profile and data management

- ✉️ **Email Integration**
  - Built-in mail sender functionalities for notifications and communication

## 🛠️ Technologies Used

- **Programming Language:** Java (100%)
- **GUI Framework:** Java Swing (AWT)
- **Database:** MySQL (see `codecrate.sql` for schema)
- **Database Connectivity:** JDBC

## 📁 Project Structure

The codebase is organized as follows:

- `ApplicationStart/` – Entry point for the application
- `CodeMaze/` – Coding practice platform
- `CodeSnippet/` – Snippet management
- `Dashboard_files/` – Application dashboard panels
  - `MainDashboardPanel.java`, `CodeSnippetDashboardPanel.java`, `LeetcodePanel.java`
- `MailSenders/` – Email functionalities
- `UserData/` – User management and profile storage
