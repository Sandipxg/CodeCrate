-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 28, 2025 at 07:10 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `codecrate`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `addUser` (IN `userName` VARCHAR(50), IN `userMail` VARCHAR(100), IN `inpassword` VARCHAR(20))   insert into user(user_name , email , password , created_at) values (userName,userMail,inpassword,CURRENT_TIMESTAMP)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updatepoints` (IN `in_username` VARCHAR(50), IN `in_pointsearned` INT, IN `in_level` VARCHAR(30))   BEGIN
    IF in_level = 'beginner_questions' THEN
        UPDATE user_data 
        SET beginner_points = beginner_points + in_pointsearned
        WHERE user_name = in_username;
    ELSEIF in_level = 'intermediate_questions' THEN
        UPDATE user_data 
        SET intermediate_points = intermediate_points + in_pointsearned
        WHERE user_name = in_username;
    ELSEIF in_level = 'expert_questions' THEN
        UPDATE user_data 
        SET expert_points = expert_points + in_pointsearned
        WHERE user_name = in_username;
    END IF;
UPDATE user_data 
        SET total_points = total_points + in_pointsearned
        WHERE user_name = in_username;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `chapterinfo`
--

CREATE TABLE `chapterinfo` (
  `chapterId` int(11) NOT NULL,
  `chapterName` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chapterinfo`
--

INSERT INTO `chapterinfo` (`chapterId`, `chapterName`) VALUES
(5, 'Arrays & Strings'),
(10, 'Collections Framework (ArrayList, HashMap, etc.)'),
(3, 'Control Statements (if, switch, loops)'),
(8, 'Exception Handling'),
(9, 'File Handling'),
(7, 'Inheritance & Polymorphism'),
(1, 'Introduction to Java & IDE Setup'),
(4, 'Methods & Recursion'),
(6, 'Object-Oriented Programming Basics (Classes & Objects)'),
(2, 'Variables, Data Types, and Operators');

-- --------------------------------------------------------

--
-- Table structure for table `chapter_index`
--

CREATE TABLE `chapter_index` (
  `chapter_id` int(11) NOT NULL,
  `chapter_name` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chapter_index`
--

INSERT INTO `chapter_index` (`chapter_id`, `chapter_name`) VALUES
(1, 'Basic Syntax & Data Types'),
(2, 'Operators & Expressions'),
(3, 'Conditional Statements'),
(4, 'Loops & Iteration'),
(5, 'Arrays & Strings'),
(6, 'Methods & Recursion'),
(7, 'Object-Oriented Programming (OOP Basics)'),
(8, 'Inheritance & Polymorphism'),
(9, 'Interfaces & Abstract Classes'),
(10, 'Exception Handling'),
(11, 'Custom Data Structures');

-- --------------------------------------------------------

--
-- Table structure for table `practicequestion`
--

CREATE TABLE `practicequestion` (
  `chapterId` int(11) NOT NULL,
  `questionId` int(11) NOT NULL,
  `question` text NOT NULL,
  `answer` text DEFAULT NULL,
  `marks` int(11) NOT NULL,
  `averageTime` int(11) NOT NULL,
  `questionLevel` enum('easy','medium','hard') NOT NULL,
  `solution` text DEFAULT NULL,
  `bonusMarks` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `practicequestion`
--

INSERT INTO `practicequestion` (`chapterId`, `questionId`, `question`, `answer`, `marks`, `averageTime`, `questionLevel`, `solution`, `bonusMarks`) VALUES
(1, 1, 'Print \"Hello, World!\" (Q1)', 'Hello, World!', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"Hello, World!\");\n    }\n}', 1),
(1, 2, 'Print your name and roll number on separate lines (Q2)', 'Name: Alice\nRoll: 101', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"Name: Alice\"); System.out.println(\"Roll: 101\");\n    }\n}', 1),
(1, 3, 'Print the Java version using System property (placeholder) (Q3)', 'java-version-placeholder', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(System.getProperty(\"java.version\"));\n    }\n}', 1),
(1, 4, 'Print the sum of two constants 7 and 8 (Q4)', '15', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(7+8);\n    }\n}', 1),
(1, 5, 'Print a formatted greeting using variables (Q5)', 'Hello, Alice!', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        String name=\"Alice\"; System.out.println(\"Hello, \"+name+\"!\");\n    }\n}', 1),
(1, 6, 'Demonstrate single-line comment and print (Q6)', 'Comments demo', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"Comments demo\");\n    }\n}', 1),
(1, 7, 'Demonstrate multi-line comment removal and print (Q7)', 'Multiline comment demo', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"Multiline comment demo\");\n    }\n}', 1),
(1, 8, 'Show how to run a loop that prints numbers 1 to 3 (Q8)', '1\n2\n3', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        for(int i=1;i<=3;i++) System.out.println(i);\n    }\n}', 1),
(1, 9, 'Show printing a boolean value (Q9)', 'true', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        boolean b=true; System.out.println(b);\n    }\n}', 1),
(1, 10, 'Print escape sequences: newline and tab (Q10)', 'Line1\n	Tabbed', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"Line1\n	Tabbed\");\n    }\n}', 1),
(1, 11, 'Create and print a String array of size 3 (Q11)', 'x y z ', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        String[] a={\"x\",\"y\",\"z\"}; for(String s:a) System.out.print(s+\" \");\n    }\n}', 3),
(1, 12, 'Demonstrate reading a system property (os.name) and printing (placeholder) (Q12)', 'os-name-placeholder', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(System.getProperty(\"os.name\"));\n    }\n}', 3),
(1, 13, 'Show concatenation of strings and integers (Q13)', 'A12', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"A\"+1+2);\n    }\n}', 3),
(1, 14, 'Demonstrate basic formatted output using printf (Q14)', 'Pi approx 3.14', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.printf(\"Pi approx %.2f\",3.14159);\n    }\n}', 3),
(1, 15, 'Show usage of Math.abs and print (Q15)', '5', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(Math.abs(-5));\n    }\n}', 3),
(1, 16, 'Demonstrate simple conditional printing using ?: operator (Q16)', 'big', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        int x=5; System.out.println(x>3? \"big\":\"small\");\n    }\n}', 3),
(1, 17, 'Create a char variable and print its ASCII code (Q17)', '65', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        char c=\'A\'; System.out.println((int)c);\n    }\n}', 3),
(1, 18, 'Show string length and charAt usage (Q18)', '4,j', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        String s=\"java\"; System.out.println(s.length()+\",\"+s.charAt(0));\n    }\n}', 3),
(1, 19, 'Demonstrate simple casting double to int (Q19)', '3', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        double d=3.9; System.out.println((int)d);\n    }\n}', 3),
(1, 20, 'Print current date using java.time.LocalDate (placeholder) (Q20)', 'current-date-placeholder', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(java.time.LocalDate.now());\n    }\n}', 3),
(1, 21, 'Explain how to compile and run via command-line (print sample) (Q21)', 'javac Main.java && java Main', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"javac Main.java && java Main\");\n    }\n}', 5),
(1, 22, 'Show how to set CLASSPATH (print example) (Q22)', 'export CLASSPATH=.:/path/to/lib', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"export CLASSPATH=.:/path/to/lib\");\n    }\n}', 5),
(1, 23, 'Explain IDE run command (print sample) (Q23)', 'Use Run > Run Main', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"Use Run > Run Main\");\n    }\n}', 5),
(1, 24, 'Demonstrate a simple multi-class compile example (print note) (Q24)', 'Compile all .java files: javac *.java', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"Compile all .java files: javac *.java\");\n    }\n}', 5),
(1, 25, 'Show basic JVM memory flags example (print) (Q25)', '-Xmx512m -Xms256m', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"-Xmx512m -Xms256m\");\n    }\n}', 5),
(1, 26, 'Explain package declaration (print example) (Q26)', 'package com.example;', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"package com.example;\");\n    }\n}', 5),
(1, 27, 'Print sample manifest main-class entry (Q27)', 'Main-Class: Main', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"Main-Class: Main\");\n    }\n}', 5),
(1, 28, 'Show basic jar creation command (print) (Q28)', 'jar cfm app.jar manifest.txt *.class', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"jar cfm app.jar manifest.txt *.class\");\n    }\n}', 5),
(1, 29, 'Print a note about debugging in IDE (Q29)', 'Use breakpoints and debug mode', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"Use breakpoints and debug mode\");\n    }\n}', 5),
(1, 30, 'Print final advice for beginners (Q30)', 'Practice regularly and read docs', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"Practice regularly and read docs\");\n    }\n}', 5),
(2, 1, 'Declare variables of different types and print them (Q1)', '10 3.5 A', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        int i=10; double d=3.5; char c=\'A\'; System.out.println(i+\" \"+d+\" \"+c);\n    }\n}', 1),
(2, 2, 'Add two integer variables and print result (Q2)', '20', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        int a=12,b=8; System.out.println(a+b);\n    }\n}', 1),
(2, 3, 'Demonstrate float vs double printing (Q3)', '3.2 3.2', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        float f=3.2f; double d=3.2; System.out.println(f+\" \"+d);\n    }\n}', 1),
(2, 4, 'Show integer division vs double division (Q4)', '2\n2.5', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(5/2); System.out.println(5.0/2.0);\n    }\n}', 1),
(2, 5, 'Use modulo operator to find remainder of 17%5 (Q5)', '2', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(17%5);\n    }\n}', 1),
(2, 6, 'Demonstrate pre and post increment behavior (Q6)', '5\n7', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        int x=5; System.out.println(x++); System.out.println(++x);\n    }\n}', 1),
(2, 7, 'Swap two variables using temp variable and print (Q7)', '7 3', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        int a=3,b=7; int t=a; a=b; b=t; System.out.println(a+\" \"+b);\n    }\n}', 1),
(2, 8, 'Swap two variables without temp (using arithmetic) and print (Q8)', '7 3', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        int a=3,b=7; a=a+b; b=a-b; a=a-b; System.out.println(a+\" \"+b);\n    }\n}', 1),
(2, 9, 'Show boolean logic AND/OR print results (Q9)', 'false\ntrue', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(true&&false); System.out.println(true||false);\n    }\n}', 1),
(2, 10, 'Demonstrate ternary operator to choose larger of two numbers (Q10)', '15', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        int a=10,b=15; System.out.println(a>b? a:b);\n    }\n}', 1),
(2, 11, 'Parse string to integer and add 5 (Q11)', '25', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        int n=Integer.parseInt(\"20\"); System.out.println(n+5);\n    }\n}', 3),
(2, 12, 'Convert int to string and concatenate (Q12)', '7 apples', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        int n=7; System.out.println(String.valueOf(n)+\" apples\");\n    }\n}', 3),
(2, 13, 'Demonstrate Math.pow and print 2^5 (Q13)', '32', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println((int)Math.pow(2,5));\n    }\n}', 3),
(2, 14, 'Use Math.sqrt to print sqrt(49) (Q14)', '7', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println((int)Math.sqrt(49));\n    }\n}', 3),
(2, 15, 'Show casting double to int after division (Q15)', '3', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        double r=7.0/2.0; System.out.println((int)r);\n    }\n}', 3),
(2, 16, 'Format a double to 2 decimal places (Q16)', '3.14', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.printf(\"%.2f\",3.14159);\n    }\n}', 3),
(2, 17, 'Show overflow behavior for byte (example) (Q17)', '-128', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        byte b=127; b++; System.out.println(b);\n    }\n}', 3),
(2, 18, 'Use Long and print large value (Q18)', '10000000000', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        long L=10000000000L; System.out.println(L);\n    }\n}', 3),
(2, 19, 'Demonstrate bitwise AND of 6 & 3 (Q19)', '2', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(6 & 3);\n    }\n}', 3),
(2, 20, 'Show left shift 1<<3 (Q20)', '8', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(1<<3);\n    }\n}', 3),
(2, 21, 'Demonstrate BigInteger addition for very large numbers (Q21)', '123456789012345687', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(new java.math.BigInteger(\"123456789012345678\").add(new java.math.BigInteger(\"9\")));\n    }\n}', 5),
(2, 22, 'Use formatted string with String.format and print (Q22)', 'ID-100', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(String.format(\"%s-%d\",\"ID\",100));\n    }\n}', 5),
(2, 23, 'Show unsigned right shift >>> on negative number (Q23)', '2147483647', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(-1 >>> 1);\n    }\n}', 5),
(2, 24, 'Explain difference between == and equals for Strings (print example) (Q24)', 'false\ntrue', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        String a=\"hi\"; String b=new String(\"hi\"); System.out.println(a==b); System.out.println(a.equals(b));\n    }\n}', 5),
(2, 25, 'Demonstrate wrapper class autoboxing/unboxing (Q25)', '5 5', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        Integer x=5; int y=x; System.out.println(x+\" \"+y);\n    }\n}', 5),
(2, 26, 'Show NaN behavior in floating point (Q26)', 'NaN', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(0.0/0.0);\n    }\n}', 5),
(2, 27, 'Demonstrate remainder with negative numbers (Q27)', '2', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(-7%3);\n    }\n}', 5),
(2, 28, 'Compute average of array of ints using double division (Q28)', '3.3333333333333335', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        int[] a={2,3,5}; double s=0; for(int v:a) s+=v; System.out.println(s/a.length);\n    }\n}', 5),
(2, 29, 'Print hashCode of a String (placeholder) (Q29)', 'abc-hash-placeholder', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"abc\".hashCode());\n    }\n}', 5),
(2, 30, 'Show Math.max and Math.min usage (Q30)', '9 5', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(Math.max(5,9)+\" \"+Math.min(5,9));\n    }\n}', 5),
(3, 1, 'Check if a number is even or odd using if-else (Q1)', 'Even', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        int n=14; if(n%2==0) System.out.println(\"Even\"); else System.out.println(\"Odd\");\n    }\n}', 1),
(3, 2, 'Use switch to print day name for 3 (Wed) (Q2)', 'Wed', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        int d=3; switch(d){case 1:System.out.println(\"Mon\");break;case 2:System.out.println(\"Tue\");break;case 3:System.out.println(\"Wed\");break;}\n    }\n}', 1),
(3, 3, 'Print numbers from 1 to 10 using for loop (Q3)', '1\n2\n3\n4\n5\n6\n7\n8\n9\n10', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        for(int i=1;i<=10;i++) System.out.println(i);\n    }\n}', 1),
(3, 4, 'Find factorial using for loop for n=6 (Q4)', '720', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        int n=6; long f=1; for(int i=1;i<=n;i++) f*=i; System.out.println(f);\n    }\n}', 1),
(3, 5, 'Find sum of first N natural numbers (N=100) using loop (Q5)', '5050', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        int N=100; int s=0; for(int i=1;i<=N;i++) s+=i; System.out.println(s);\n    }\n}', 1),
(3, 6, 'Use while loop to print powers of 2 upto 5 (Q6)', '1\n2\n4\n8\n16', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        int i=1, p=1; while(i<=5){ System.out.println(p); p*=2; i++; }\n    }\n}', 1),
(3, 7, 'Use do-while to prompt once (print message) (Q7)', 'Run once', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        int x=0; do{ System.out.println(\"Run once\"); } while(x==1);\n    }\n}', 1),
(3, 8, 'Nested loops: print 3x3 matrix of \'*\' (Q8)', '***\n***\n***\n', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        for(int i=0;i<3;i++){ for(int j=0;j<3;j++) System.out.print(\"*\"); System.out.println(); }\n    }\n}', 1),
(3, 9, 'Use break to exit loop when i==5 (Q9)', '1 2 3 4 ', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        for(int i=1;i<=10;i++){ if(i==5) break; System.out.print(i+\" \"); }\n    }\n}', 1),
(3, 10, 'Use continue to skip even numbers (Q10)', '1 3 5 7 9 ', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        for(int i=1;i<=10;i++){ if(i%2==0) continue; System.out.print(i+\" \"); }\n    }\n}', 1),
(3, 11, 'Use switch with strings to map \"red\" to code 1 (Q11)', '1', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        String c=\"red\"; switch(c){case \"red\": System.out.println(1); break; default: System.out.println(0);}\n    }\n}', 3),
(3, 12, 'Find prime check using for loop for n=29 (Q12)', 'Prime', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        int n=29; boolean p=true; for(int i=2;i<=Math.sqrt(n);i++) if(n%i==0) p=false; System.out.println(p?\"Prime\":\"Not Prime\");\n    }\n}', 3),
(3, 13, 'Use nested loops to compute multiplication table 1..3 (Q13)', '1x1=1\n1x2=2\n1x3=3\n2x1=2\n2x2=4\n2x3=6\n3x1=3\n3x2=6\n3x3=9\n', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        for(int i=1;i<=3;i++){ for(int j=1;j<=3;j++) System.out.println(i+\"x\"+j+\"=\"+i*j); }\n    }\n}', 3),
(3, 14, 'Count vowels in a string using loop (Q14)', '2', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        String s=\"hello\"; int c=0; for(char ch:s.toCharArray()) if(\"aeiou\".indexOf(ch)>=0) c++; System.out.println(c);\n    }\n}', 3),
(3, 15, 'Sum digits until single digit (digital root) using loop (Q15)', '9', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        int n=99; while(n>=10){ int s=0; while(n>0){s+=n%10;n/=10;} n=s;} System.out.println(n);\n    }\n}', 3),
(3, 16, 'Use labeled break in nested loops (print notice) (Q16)', 'Exited', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        outer: for(int i=0;i<3;i++){ for(int j=0;j<3;j++){ if(i==1&&j==1) break outer; } } System.out.println(\"Exited\");\n    }\n}', 3),
(3, 17, 'Demonstrate for-each loop over array (Q17)', '1 2 3 ', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        int[] a={1,2,3}; for(int v:a) System.out.print(v+\" \");\n    }\n}', 3),
(3, 18, 'Use switch fall-through to print sequence (Q18)', '1 2 ', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        int k=1; switch(k){case 1: System.out.print(1+\" \"); case 2: System.out.print(2+\" \");}\n    }\n}', 3),
(3, 19, 'Check Armstrong number using loops for 153 (Q19)', 'Armstrong', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        int n=153,sum=0,t=n; while(t>0){int d=t%10;sum+=d*d*d; t/=10;} System.out.println(sum==n?\"Armstrong\":\"Not Armstrong\");\n    }\n}', 3),
(3, 20, 'Use loop to reverse string \'abcde\' (Q20)', 'edcba', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        String s=\"abcde\",r=\"\"; for(int i=s.length()-1;i>=0;i--) r+=s.charAt(i); System.out.println(r);\n    }\n}', 3),
(3, 21, 'Implement simple Sieve of Eratosthenes up to 30 (print primes) (Q21)', '2 3 5 7 11 13 17 19 23 29 ', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        boolean[] a=new boolean[31]; for(int i=2;i*i<=30;i++) if(!a[i]) for(int j=i*i;j<=30;j+=i) a[j]=true; for(int i=2;i<=30;i++) if(!a[i]) System.out.print(i+\" \");\n    }\n}', 5),
(3, 22, 'Evaluate nested conditional expressions (complex) and print result (Q22)', '3', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        int a=5,b=10,c=3; System.out.println(a>b? a:c>b? c:b);\n    }\n}', 5),
(3, 23, 'Use switch expression like behavior (simulate) to compute value (Q23)', '4', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        int day=4; int val = (day==1)?1:(day==2)?2:(day==3)?3:4; System.out.println(val);\n    }\n}', 5),
(3, 24, 'Detect loop invariants with counters (print count of iterations) (Q24)', '6', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        int cnt=0; for(int i=0;i<100;i++){ if(i%17==0) cnt++; } System.out.println(cnt);\n    }\n}', 5),
(3, 25, 'Implement bubble sort and print sorted array for [4,3,2,1] (Q25)', '1 2 3 4 ', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        int[] a={4,3,2,1}; for(int i=0;i<a.length-1;i++) for(int j=0;j<a.length-1-i;j++) if(a[j]>a[j+1]){int t=a[j];a[j]=a[j+1];a[j+1]=t;} for(int x:a) System.out.print(x+\" \");\n    }\n}', 5),
(3, 26, 'Build and print Pascal triangle first 5 rows using loops (Q26)', '1 \n1 1 \n1 2 1 \n1 3 3 1 \n1 4 6 4 1 \n', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        int rows=5; for(int i=0;i<rows;i++){ int c=1; for(int j=0;j<=i;j++){ System.out.print(c+\" \"); c=c*(i-j)/(j+1);} System.out.println(); }\n    }\n}', 5),
(3, 27, 'Generate first 10 Fibonacci numbers using while loop and print (Q27)', '0 1 1 2 3 5 8 13 21 34 ', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        int a=0,b=1; int i=0; while(i<10){ System.out.print(a+\" \"); int c=a+b; a=b; b=c; i++; }\n    }\n}', 5),
(3, 28, 'Use continue with labels in nested loops (print a marker) (Q28)', '00 02 10 12 20 22 ', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        for(int i=0;i<3;i++){ for(int j=0;j<3;j++){ if(j==1) continue; System.out.print(i+\"\"+j+\" \"); } }\n    }\n}', 5),
(3, 29, 'Use loop unrolling concept (manual) to print 8 numbers (Q29)', '1 2 3 4 5 6 7 8 ', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        int[]a={1,2,3,4,5,6,7,8}; for(int i=0;i<a.length;i+=2){ System.out.print(a[i]+\" \"); if(i+1<a.length) System.out.print(a[i+1]+\" \"); }\n    }\n}', 5),
(3, 30, 'Check if a number is even or odd using if-else (Q30)', 'Even', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        int n=14; if(n%2==0) System.out.println(\"Even\"); else System.out.println(\"Odd\");\n    }\n}', 5),
(4, 1, 'Write a method add(int,int) and call it from main (Q1)', '5', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(add(2,3));\n    }\n\npublic static int add(int x,int y){return x+y;}\npublic static long fact(int n){return n<=1?1:n*fact(n-1);}\npublic static int max(int a,int b,int c){return Math.max(a,Math.max(b,c));}\npublic static int sum(int[] a){int s=0; for(int v:a) s+=v; return s;}\npublic static int fib(int n){ if(n<=1) return n; int a=0,b=1; for(int i=2;i<=n;i++){int c=a+b;a=b;b=c;} return b; }\npublic static boolean isPal(String s){ return new StringBuilder(s).reverse().toString().equals(s);}\npublic static int sumAll(int... nums){int s=0; for(int v:nums) s+=v; return s;}\npublic static long factTail(int n,long acc){ return n<=1?acc:factTail(n-1,acc*n); }\npublic static void swap(int[]a,int i,int j){ int t=a[i]; a[i]=a[j]; a[j]=t; }\npublic static long pow(int a,int n){ long r=1; while(n>0){ if((n&1)==1) r*=a; a*=a; n>>=1;} return r; }\npublic static String reverse(String s){ if(s.isEmpty()) return s; return reverse(s.substring(1))+s.charAt(0);}\npublic static int gcd(int a,int b){ return b==0?a:gcd(b,a%b); }\npublic static int sumDigits(int n){ if(n==0) return 0; return n%10 + sumDigits(n/10); }\npublic static boolean isPalNum(int n){ String s=String.valueOf(n); return new StringBuilder(s).reverse().toString().equals(s);}\npublic static long factIter(int n){ long f=1; for(int i=1;i<=n;i++) f*=i; return f; }\npublic static int depth(int n){ return n; }\n\n}\n', 1),
(4, 2, 'Write a recursive method to compute factorial(5) and print (Q2)', '120', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(fact(5));\n    }\n\npublic static int add(int x,int y){return x+y;}\npublic static long fact(int n){return n<=1?1:n*fact(n-1);}\npublic static int max(int a,int b,int c){return Math.max(a,Math.max(b,c));}\npublic static int sum(int[] a){int s=0; for(int v:a) s+=v; return s;}\npublic static int fib(int n){ if(n<=1) return n; int a=0,b=1; for(int i=2;i<=n;i++){int c=a+b;a=b;b=c;} return b; }\npublic static boolean isPal(String s){ return new StringBuilder(s).reverse().toString().equals(s);}\npublic static int sumAll(int... nums){int s=0; for(int v:nums) s+=v; return s;}\npublic static long factTail(int n,long acc){ return n<=1?acc:factTail(n-1,acc*n); }\npublic static void swap(int[]a,int i,int j){ int t=a[i]; a[i]=a[j]; a[j]=t; }\npublic static long pow(int a,int n){ long r=1; while(n>0){ if((n&1)==1) r*=a; a*=a; n>>=1;} return r; }\npublic static String reverse(String s){ if(s.isEmpty()) return s; return reverse(s.substring(1))+s.charAt(0);}\npublic static int gcd(int a,int b){ return b==0?a:gcd(b,a%b); }\npublic static int sumDigits(int n){ if(n==0) return 0; return n%10 + sumDigits(n/10); }\npublic static boolean isPalNum(int n){ String s=String.valueOf(n); return new StringBuilder(s).reverse().toString().equals(s);}\npublic static long factIter(int n){ long f=1; for(int i=1;i<=n;i++) f*=i; return f; }\npublic static int depth(int n){ return n; }\n\n}\n', 1),
(4, 3, 'Overload greet(): greet() and greet(\"Alice\") and print both (Q3)', 'Hello\nHello, Alice', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        greet(); greet(\"Alice\");\n    }\n\npublic static int add(int x,int y){return x+y;}\npublic static long fact(int n){return n<=1?1:n*fact(n-1);}\npublic static int max(int a,int b,int c){return Math.max(a,Math.max(b,c));}\npublic static int sum(int[] a){int s=0; for(int v:a) s+=v; return s;}\npublic static int fib(int n){ if(n<=1) return n; int a=0,b=1; for(int i=2;i<=n;i++){int c=a+b;a=b;b=c;} return b; }\npublic static boolean isPal(String s){ return new StringBuilder(s).reverse().toString().equals(s);}\npublic static int sumAll(int... nums){int s=0; for(int v:nums) s+=v; return s;}\npublic static long factTail(int n,long acc){ return n<=1?acc:factTail(n-1,acc*n); }\npublic static void swap(int[]a,int i,int j){ int t=a[i]; a[i]=a[j]; a[j]=t; }\npublic static long pow(int a,int n){ long r=1; while(n>0){ if((n&1)==1) r*=a; a*=a; n>>=1;} return r; }\npublic static String reverse(String s){ if(s.isEmpty()) return s; return reverse(s.substring(1))+s.charAt(0);}\npublic static int gcd(int a,int b){ return b==0?a:gcd(b,a%b); }\npublic static int sumDigits(int n){ if(n==0) return 0; return n%10 + sumDigits(n/10); }\npublic static boolean isPalNum(int n){ String s=String.valueOf(n); return new StringBuilder(s).reverse().toString().equals(s);}\npublic static long factIter(int n){ long f=1; for(int i=1;i<=n;i++) f*=i; return f; }\npublic static int depth(int n){ return n; }\n\n}\n', 1),
(4, 4, 'Method to return max of three numbers and print (Q4)', '7', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(max(3,7,5));\n    }\n\npublic static int add(int x,int y){return x+y;}\npublic static long fact(int n){return n<=1?1:n*fact(n-1);}\npublic static int max(int a,int b,int c){return Math.max(a,Math.max(b,c));}\npublic static int sum(int[] a){int s=0; for(int v:a) s+=v; return s;}\npublic static int fib(int n){ if(n<=1) return n; int a=0,b=1; for(int i=2;i<=n;i++){int c=a+b;a=b;b=c;} return b; }\npublic static boolean isPal(String s){ return new StringBuilder(s).reverse().toString().equals(s);}\npublic static int sumAll(int... nums){int s=0; for(int v:nums) s+=v; return s;}\npublic static long factTail(int n,long acc){ return n<=1?acc:factTail(n-1,acc*n); }\npublic static void swap(int[]a,int i,int j){ int t=a[i]; a[i]=a[j]; a[j]=t; }\npublic static long pow(int a,int n){ long r=1; while(n>0){ if((n&1)==1) r*=a; a*=a; n>>=1;} return r; }\npublic static String reverse(String s){ if(s.isEmpty()) return s; return reverse(s.substring(1))+s.charAt(0);}\npublic static int gcd(int a,int b){ return b==0?a:gcd(b,a%b); }\npublic static int sumDigits(int n){ if(n==0) return 0; return n%10 + sumDigits(n/10); }\npublic static boolean isPalNum(int n){ String s=String.valueOf(n); return new StringBuilder(s).reverse().toString().equals(s);}\npublic static long factIter(int n){ long f=1; for(int i=1;i<=n;i++) f*=i; return f; }\npublic static int depth(int n){ return n; }\n\n}\n', 1),
(4, 5, 'Method to sum array elements and print result (Q5)', '6', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        int[]a={1,2,3}; System.out.println(sum(a));\n    }\n\npublic static int add(int x,int y){return x+y;}\npublic static long fact(int n){return n<=1?1:n*fact(n-1);}\npublic static int max(int a,int b,int c){return Math.max(a,Math.max(b,c));}\npublic static int sum(int[] a){int s=0; for(int v:a) s+=v; return s;}\npublic static int fib(int n){ if(n<=1) return n; int a=0,b=1; for(int i=2;i<=n;i++){int c=a+b;a=b;b=c;} return b; }\npublic static boolean isPal(String s){ return new StringBuilder(s).reverse().toString().equals(s);}\npublic static int sumAll(int... nums){int s=0; for(int v:nums) s+=v; return s;}\npublic static long factTail(int n,long acc){ return n<=1?acc:factTail(n-1,acc*n); }\npublic static void swap(int[]a,int i,int j){ int t=a[i]; a[i]=a[j]; a[j]=t; }\npublic static long pow(int a,int n){ long r=1; while(n>0){ if((n&1)==1) r*=a; a*=a; n>>=1;} return r; }\npublic static String reverse(String s){ if(s.isEmpty()) return s; return reverse(s.substring(1))+s.charAt(0);}\npublic static int gcd(int a,int b){ return b==0?a:gcd(b,a%b); }\npublic static int sumDigits(int n){ if(n==0) return 0; return n%10 + sumDigits(n/10); }\npublic static boolean isPalNum(int n){ String s=String.valueOf(n); return new StringBuilder(s).reverse().toString().equals(s);}\npublic static long factIter(int n){ long f=1; for(int i=1;i<=n;i++) f*=i; return f; }\npublic static int depth(int n){ return n; }\n\n}\n', 1),
(4, 6, 'Recursive Fibonacci for n=7 and print (Q6)', '13', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(fib(7));\n    }\n\npublic static int add(int x,int y){return x+y;}\npublic static long fact(int n){return n<=1?1:n*fact(n-1);}\npublic static int max(int a,int b,int c){return Math.max(a,Math.max(b,c));}\npublic static int sum(int[] a){int s=0; for(int v:a) s+=v; return s;}\npublic static int fib(int n){ if(n<=1) return n; int a=0,b=1; for(int i=2;i<=n;i++){int c=a+b;a=b;b=c;} return b; }\npublic static boolean isPal(String s){ return new StringBuilder(s).reverse().toString().equals(s);}\npublic static int sumAll(int... nums){int s=0; for(int v:nums) s+=v; return s;}\npublic static long factTail(int n,long acc){ return n<=1?acc:factTail(n-1,acc*n); }\npublic static void swap(int[]a,int i,int j){ int t=a[i]; a[i]=a[j]; a[j]=t; }\npublic static long pow(int a,int n){ long r=1; while(n>0){ if((n&1)==1) r*=a; a*=a; n>>=1;} return r; }\npublic static String reverse(String s){ if(s.isEmpty()) return s; return reverse(s.substring(1))+s.charAt(0);}\npublic static int gcd(int a,int b){ return b==0?a:gcd(b,a%b); }\npublic static int sumDigits(int n){ if(n==0) return 0; return n%10 + sumDigits(n/10); }\npublic static boolean isPalNum(int n){ String s=String.valueOf(n); return new StringBuilder(s).reverse().toString().equals(s);}\npublic static long factIter(int n){ long f=1; for(int i=1;i<=n;i++) f*=i; return f; }\npublic static int depth(int n){ return n; }\n\n}\n', 1),
(4, 7, 'Method isPal for \'level\' and print (Q7)', 'Palindrome', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(isPal(\"level\")?\"Palindrome\":\"Not\");\n    }\n\npublic static int add(int x,int y){return x+y;}\npublic static long fact(int n){return n<=1?1:n*fact(n-1);}\npublic static int max(int a,int b,int c){return Math.max(a,Math.max(b,c));}\npublic static int sum(int[] a){int s=0; for(int v:a) s+=v; return s;}\npublic static int fib(int n){ if(n<=1) return n; int a=0,b=1; for(int i=2;i<=n;i++){int c=a+b;a=b;b=c;} return b; }\npublic static boolean isPal(String s){ return new StringBuilder(s).reverse().toString().equals(s);}\npublic static int sumAll(int... nums){int s=0; for(int v:nums) s+=v; return s;}\npublic static long factTail(int n,long acc){ return n<=1?acc:factTail(n-1,acc*n); }\npublic static void swap(int[]a,int i,int j){ int t=a[i]; a[i]=a[j]; a[j]=t; }\npublic static long pow(int a,int n){ long r=1; while(n>0){ if((n&1)==1) r*=a; a*=a; n>>=1;} return r; }\npublic static String reverse(String s){ if(s.isEmpty()) return s; return reverse(s.substring(1))+s.charAt(0);}\npublic static int gcd(int a,int b){ return b==0?a:gcd(b,a%b); }\npublic static int sumDigits(int n){ if(n==0) return 0; return n%10 + sumDigits(n/10); }\npublic static boolean isPalNum(int n){ String s=String.valueOf(n); return new StringBuilder(s).reverse().toString().equals(s);}\npublic static long factIter(int n){ long f=1; for(int i=1;i<=n;i++) f*=i; return f; }\npublic static int depth(int n){ return n; }\n\n}\n', 1),
(4, 8, 'Varargs sumAll(1,2,3,4) and print (Q8)', '10', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(sumAll(1,2,3,4));\n    }\n\npublic static int add(int x,int y){return x+y;}\npublic static long fact(int n){return n<=1?1:n*fact(n-1);}\npublic static int max(int a,int b,int c){return Math.max(a,Math.max(b,c));}\npublic static int sum(int[] a){int s=0; for(int v:a) s+=v; return s;}\npublic static int fib(int n){ if(n<=1) return n; int a=0,b=1; for(int i=2;i<=n;i++){int c=a+b;a=b;b=c;} return b; }\npublic static boolean isPal(String s){ return new StringBuilder(s).reverse().toString().equals(s);}\npublic static int sumAll(int... nums){int s=0; for(int v:nums) s+=v; return s;}\npublic static long factTail(int n,long acc){ return n<=1?acc:factTail(n-1,acc*n); }\npublic static void swap(int[]a,int i,int j){ int t=a[i]; a[i]=a[j]; a[j]=t; }\npublic static long pow(int a,int n){ long r=1; while(n>0){ if((n&1)==1) r*=a; a*=a; n>>=1;} return r; }\npublic static String reverse(String s){ if(s.isEmpty()) return s; return reverse(s.substring(1))+s.charAt(0);}\npublic static int gcd(int a,int b){ return b==0?a:gcd(b,a%b); }\npublic static int sumDigits(int n){ if(n==0) return 0; return n%10 + sumDigits(n/10); }\npublic static boolean isPalNum(int n){ String s=String.valueOf(n); return new StringBuilder(s).reverse().toString().equals(s);}\npublic static long factIter(int n){ long f=1; for(int i=1;i<=n;i++) f*=i; return f; }\npublic static int depth(int n){ return n; }\n\n}\n', 1),
(4, 9, 'Tail recursion simulate factTail(5,1) and print (Q9)', '120', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(factTail(5,1));\n    }\n\npublic static int add(int x,int y){return x+y;}\npublic static long fact(int n){return n<=1?1:n*fact(n-1);}\npublic static int max(int a,int b,int c){return Math.max(a,Math.max(b,c));}\npublic static int sum(int[] a){int s=0; for(int v:a) s+=v; return s;}\npublic static int fib(int n){ if(n<=1) return n; int a=0,b=1; for(int i=2;i<=n;i++){int c=a+b;a=b;b=c;} return b; }\npublic static boolean isPal(String s){ return new StringBuilder(s).reverse().toString().equals(s);}\npublic static int sumAll(int... nums){int s=0; for(int v:nums) s+=v; return s;}\npublic static long factTail(int n,long acc){ return n<=1?acc:factTail(n-1,acc*n); }\npublic static void swap(int[]a,int i,int j){ int t=a[i]; a[i]=a[j]; a[j]=t; }\npublic static long pow(int a,int n){ long r=1; while(n>0){ if((n&1)==1) r*=a; a*=a; n>>=1;} return r; }\npublic static String reverse(String s){ if(s.isEmpty()) return s; return reverse(s.substring(1))+s.charAt(0);}\npublic static int gcd(int a,int b){ return b==0?a:gcd(b,a%b); }\npublic static int sumDigits(int n){ if(n==0) return 0; return n%10 + sumDigits(n/10); }\npublic static boolean isPalNum(int n){ String s=String.valueOf(n); return new StringBuilder(s).reverse().toString().equals(s);}\npublic static long factIter(int n){ long f=1; for(int i=1;i<=n;i++) f*=i; return f; }\npublic static int depth(int n){ return n; }\n\n}\n', 1),
(4, 10, 'Swap two elements in array and show effect (Q10)', '2 1', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        int[]a={1,2}; swap(a,0,1); System.out.println(a[0]+\" \"+a[1]);\n    }\n\npublic static int add(int x,int y){return x+y;}\npublic static long fact(int n){return n<=1?1:n*fact(n-1);}\npublic static int max(int a,int b,int c){return Math.max(a,Math.max(b,c));}\npublic static int sum(int[] a){int s=0; for(int v:a) s+=v; return s;}\npublic static int fib(int n){ if(n<=1) return n; int a=0,b=1; for(int i=2;i<=n;i++){int c=a+b;a=b;b=c;} return b; }\npublic static boolean isPal(String s){ return new StringBuilder(s).reverse().toString().equals(s);}\npublic static int sumAll(int... nums){int s=0; for(int v:nums) s+=v; return s;}\npublic static long factTail(int n,long acc){ return n<=1?acc:factTail(n-1,acc*n); }\npublic static void swap(int[]a,int i,int j){ int t=a[i]; a[i]=a[j]; a[j]=t; }\npublic static long pow(int a,int n){ long r=1; while(n>0){ if((n&1)==1) r*=a; a*=a; n>>=1;} return r; }\npublic static String reverse(String s){ if(s.isEmpty()) return s; return reverse(s.substring(1))+s.charAt(0);}\npublic static int gcd(int a,int b){ return b==0?a:gcd(b,a%b); }\npublic static int sumDigits(int n){ if(n==0) return 0; return n%10 + sumDigits(n/10); }\npublic static boolean isPalNum(int n){ String s=String.valueOf(n); return new StringBuilder(s).reverse().toString().equals(s);}\npublic static long factIter(int n){ long f=1; for(int i=1;i<=n;i++) f*=i; return f; }\npublic static int depth(int n){ return n; }\n\n}\n', 1),
(4, 11, 'Binary exponentiation pow(2,10) and print (Q11)', '1024', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(pow(2,10));\n    }\n\npublic static int add(int x,int y){return x+y;}\npublic static long fact(int n){return n<=1?1:n*fact(n-1);}\npublic static int max(int a,int b,int c){return Math.max(a,Math.max(b,c));}\npublic static int sum(int[] a){int s=0; for(int v:a) s+=v; return s;}\npublic static int fib(int n){ if(n<=1) return n; int a=0,b=1; for(int i=2;i<=n;i++){int c=a+b;a=b;b=c;} return b; }\npublic static boolean isPal(String s){ return new StringBuilder(s).reverse().toString().equals(s);}\npublic static int sumAll(int... nums){int s=0; for(int v:nums) s+=v; return s;}\npublic static long factTail(int n,long acc){ return n<=1?acc:factTail(n-1,acc*n); }\npublic static void swap(int[]a,int i,int j){ int t=a[i]; a[i]=a[j]; a[j]=t; }\npublic static long pow(int a,int n){ long r=1; while(n>0){ if((n&1)==1) r*=a; a*=a; n>>=1;} return r; }\npublic static String reverse(String s){ if(s.isEmpty()) return s; return reverse(s.substring(1))+s.charAt(0);}\npublic static int gcd(int a,int b){ return b==0?a:gcd(b,a%b); }\npublic static int sumDigits(int n){ if(n==0) return 0; return n%10 + sumDigits(n/10); }\npublic static boolean isPalNum(int n){ String s=String.valueOf(n); return new StringBuilder(s).reverse().toString().equals(s);}\npublic static long factIter(int n){ long f=1; for(int i=1;i<=n;i++) f*=i; return f; }\npublic static int depth(int n){ return n; }\n\n}\n', 3),
(4, 12, 'Memoized Fibonacci iterative fib(20) and print (Q12)', '6765', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        int[]memo=new int[21]; memo[0]=0; memo[1]=1; for(int i=2;i<=20;i++) memo[i]=memo[i-1]+memo[i-2]; System.out.println(memo[20]);\n    }\n\npublic static int add(int x,int y){return x+y;}\npublic static long fact(int n){return n<=1?1:n*fact(n-1);}\npublic static int max(int a,int b,int c){return Math.max(a,Math.max(b,c));}\npublic static int sum(int[] a){int s=0; for(int v:a) s+=v; return s;}\npublic static int fib(int n){ if(n<=1) return n; int a=0,b=1; for(int i=2;i<=n;i++){int c=a+b;a=b;b=c;} return b; }\npublic static boolean isPal(String s){ return new StringBuilder(s).reverse().toString().equals(s);}\npublic static int sumAll(int... nums){int s=0; for(int v:nums) s+=v; return s;}\npublic static long factTail(int n,long acc){ return n<=1?acc:factTail(n-1,acc*n); }\npublic static void swap(int[]a,int i,int j){ int t=a[i]; a[i]=a[j]; a[j]=t; }\npublic static long pow(int a,int n){ long r=1; while(n>0){ if((n&1)==1) r*=a; a*=a; n>>=1;} return r; }\npublic static String reverse(String s){ if(s.isEmpty()) return s; return reverse(s.substring(1))+s.charAt(0);}\npublic static int gcd(int a,int b){ return b==0?a:gcd(b,a%b); }\npublic static int sumDigits(int n){ if(n==0) return 0; return n%10 + sumDigits(n/10); }\npublic static boolean isPalNum(int n){ String s=String.valueOf(n); return new StringBuilder(s).reverse().toString().equals(s);}\npublic static long factIter(int n){ long f=1; for(int i=1;i<=n;i++) f*=i; return f; }\npublic static int depth(int n){ return n; }\n\n}\n', 3),
(4, 13, 'Reverse string using recursion for \'abc\' and print (Q13)', 'cba', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(reverse(\"abc\"));\n    }\n\npublic static int add(int x,int y){return x+y;}\npublic static long fact(int n){return n<=1?1:n*fact(n-1);}\npublic static int max(int a,int b,int c){return Math.max(a,Math.max(b,c));}\npublic static int sum(int[] a){int s=0; for(int v:a) s+=v; return s;}\npublic static int fib(int n){ if(n<=1) return n; int a=0,b=1; for(int i=2;i<=n;i++){int c=a+b;a=b;b=c;} return b; }\npublic static boolean isPal(String s){ return new StringBuilder(s).reverse().toString().equals(s);}\npublic static int sumAll(int... nums){int s=0; for(int v:nums) s+=v; return s;}\npublic static long factTail(int n,long acc){ return n<=1?acc:factTail(n-1,acc*n); }\npublic static void swap(int[]a,int i,int j){ int t=a[i]; a[i]=a[j]; a[j]=t; }\npublic static long pow(int a,int n){ long r=1; while(n>0){ if((n&1)==1) r*=a; a*=a; n>>=1;} return r; }\npublic static String reverse(String s){ if(s.isEmpty()) return s; return reverse(s.substring(1))+s.charAt(0);}\npublic static int gcd(int a,int b){ return b==0?a:gcd(b,a%b); }\npublic static int sumDigits(int n){ if(n==0) return 0; return n%10 + sumDigits(n/10); }\npublic static boolean isPalNum(int n){ String s=String.valueOf(n); return new StringBuilder(s).reverse().toString().equals(s);}\npublic static long factIter(int n){ long f=1; for(int i=1;i<=n;i++) f*=i; return f; }\npublic static int depth(int n){ return n; }\n\n}\n', 3),
(4, 14, 'GCD using recursion gcd(48,18) and print (Q14)', '6', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(gcd(48,18));\n    }\n\npublic static int add(int x,int y){return x+y;}\npublic static long fact(int n){return n<=1?1:n*fact(n-1);}\npublic static int max(int a,int b,int c){return Math.max(a,Math.max(b,c));}\npublic static int sum(int[] a){int s=0; for(int v:a) s+=v; return s;}\npublic static int fib(int n){ if(n<=1) return n; int a=0,b=1; for(int i=2;i<=n;i++){int c=a+b;a=b;b=c;} return b; }\npublic static boolean isPal(String s){ return new StringBuilder(s).reverse().toString().equals(s);}\npublic static int sumAll(int... nums){int s=0; for(int v:nums) s+=v; return s;}\npublic static long factTail(int n,long acc){ return n<=1?acc:factTail(n-1,acc*n); }\npublic static void swap(int[]a,int i,int j){ int t=a[i]; a[i]=a[j]; a[j]=t; }\npublic static long pow(int a,int n){ long r=1; while(n>0){ if((n&1)==1) r*=a; a*=a; n>>=1;} return r; }\npublic static String reverse(String s){ if(s.isEmpty()) return s; return reverse(s.substring(1))+s.charAt(0);}\npublic static int gcd(int a,int b){ return b==0?a:gcd(b,a%b); }\npublic static int sumDigits(int n){ if(n==0) return 0; return n%10 + sumDigits(n/10); }\npublic static boolean isPalNum(int n){ String s=String.valueOf(n); return new StringBuilder(s).reverse().toString().equals(s);}\npublic static long factIter(int n){ long f=1; for(int i=1;i<=n;i++) f*=i; return f; }\npublic static int depth(int n){ return n; }\n\n}\n', 3),
(4, 15, 'Sum digits recursively of 12345 and print (Q15)', '15', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(sumDigits(12345));\n    }\n\npublic static int add(int x,int y){return x+y;}\npublic static long fact(int n){return n<=1?1:n*fact(n-1);}\npublic static int max(int a,int b,int c){return Math.max(a,Math.max(b,c));}\npublic static int sum(int[] a){int s=0; for(int v:a) s+=v; return s;}\npublic static int fib(int n){ if(n<=1) return n; int a=0,b=1; for(int i=2;i<=n;i++){int c=a+b;a=b;b=c;} return b; }\npublic static boolean isPal(String s){ return new StringBuilder(s).reverse().toString().equals(s);}\npublic static int sumAll(int... nums){int s=0; for(int v:nums) s+=v; return s;}\npublic static long factTail(int n,long acc){ return n<=1?acc:factTail(n-1,acc*n); }\npublic static void swap(int[]a,int i,int j){ int t=a[i]; a[i]=a[j]; a[j]=t; }\npublic static long pow(int a,int n){ long r=1; while(n>0){ if((n&1)==1) r*=a; a*=a; n>>=1;} return r; }\npublic static String reverse(String s){ if(s.isEmpty()) return s; return reverse(s.substring(1))+s.charAt(0);}\npublic static int gcd(int a,int b){ return b==0?a:gcd(b,a%b); }\npublic static int sumDigits(int n){ if(n==0) return 0; return n%10 + sumDigits(n/10); }\npublic static boolean isPalNum(int n){ String s=String.valueOf(n); return new StringBuilder(s).reverse().toString().equals(s);}\npublic static long factIter(int n){ long f=1; for(int i=1;i<=n;i++) f*=i; return f; }\npublic static int depth(int n){ return n; }\n\n}\n', 3),
(4, 16, 'Recursive palindrome integer check for 1221 and print Yes/No (Q16)', 'Yes', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(isPalNum(1221)?\"Yes\":\"No\");\n    }\n\npublic static int add(int x,int y){return x+y;}\npublic static long fact(int n){return n<=1?1:n*fact(n-1);}\npublic static int max(int a,int b,int c){return Math.max(a,Math.max(b,c));}\npublic static int sum(int[] a){int s=0; for(int v:a) s+=v; return s;}\npublic static int fib(int n){ if(n<=1) return n; int a=0,b=1; for(int i=2;i<=n;i++){int c=a+b;a=b;b=c;} return b; }\npublic static boolean isPal(String s){ return new StringBuilder(s).reverse().toString().equals(s);}\npublic static int sumAll(int... nums){int s=0; for(int v:nums) s+=v; return s;}\npublic static long factTail(int n,long acc){ return n<=1?acc:factTail(n-1,acc*n); }\npublic static void swap(int[]a,int i,int j){ int t=a[i]; a[i]=a[j]; a[j]=t; }\npublic static long pow(int a,int n){ long r=1; while(n>0){ if((n&1)==1) r*=a; a*=a; n>>=1;} return r; }\npublic static String reverse(String s){ if(s.isEmpty()) return s; return reverse(s.substring(1))+s.charAt(0);}\npublic static int gcd(int a,int b){ return b==0?a:gcd(b,a%b); }\npublic static int sumDigits(int n){ if(n==0) return 0; return n%10 + sumDigits(n/10); }\npublic static boolean isPalNum(int n){ String s=String.valueOf(n); return new StringBuilder(s).reverse().toString().equals(s);}\npublic static long factIter(int n){ long f=1; for(int i=1;i<=n;i++) f*=i; return f; }\npublic static int depth(int n){ return n; }\n\n}\n', 3),
(4, 17, 'Flatten nested arrays (placeholder) and print (Q17)', 'Flatten done', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"Flatten done\");\n    }\n\npublic static int add(int x,int y){return x+y;}\npublic static long fact(int n){return n<=1?1:n*fact(n-1);}\npublic static int max(int a,int b,int c){return Math.max(a,Math.max(b,c));}\npublic static int sum(int[] a){int s=0; for(int v:a) s+=v; return s;}\npublic static int fib(int n){ if(n<=1) return n; int a=0,b=1; for(int i=2;i<=n;i++){int c=a+b;a=b;b=c;} return b; }\npublic static boolean isPal(String s){ return new StringBuilder(s).reverse().toString().equals(s);}\npublic static int sumAll(int... nums){int s=0; for(int v:nums) s+=v; return s;}\npublic static long factTail(int n,long acc){ return n<=1?acc:factTail(n-1,acc*n); }\npublic static void swap(int[]a,int i,int j){ int t=a[i]; a[i]=a[j]; a[j]=t; }\npublic static long pow(int a,int n){ long r=1; while(n>0){ if((n&1)==1) r*=a; a*=a; n>>=1;} return r; }\npublic static String reverse(String s){ if(s.isEmpty()) return s; return reverse(s.substring(1))+s.charAt(0);}\npublic static int gcd(int a,int b){ return b==0?a:gcd(b,a%b); }\npublic static int sumDigits(int n){ if(n==0) return 0; return n%10 + sumDigits(n/10); }\npublic static boolean isPalNum(int n){ String s=String.valueOf(n); return new StringBuilder(s).reverse().toString().equals(s);}\npublic static long factIter(int n){ long f=1; for(int i=1;i<=n;i++) f*=i; return f; }\npublic static int depth(int n){ return n; }\n\n}\n', 3);
INSERT INTO `practicequestion` (`chapterId`, `questionId`, `question`, `answer`, `marks`, `averageTime`, `questionLevel`, `solution`, `bonusMarks`) VALUES
(4, 18, 'Iterative factorial factIter(6) and print (Q18)', '720', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(factIter(6));\n    }\n\npublic static int add(int x,int y){return x+y;}\npublic static long fact(int n){return n<=1?1:n*fact(n-1);}\npublic static int max(int a,int b,int c){return Math.max(a,Math.max(b,c));}\npublic static int sum(int[] a){int s=0; for(int v:a) s+=v; return s;}\npublic static int fib(int n){ if(n<=1) return n; int a=0,b=1; for(int i=2;i<=n;i++){int c=a+b;a=b;b=c;} return b; }\npublic static boolean isPal(String s){ return new StringBuilder(s).reverse().toString().equals(s);}\npublic static int sumAll(int... nums){int s=0; for(int v:nums) s+=v; return s;}\npublic static long factTail(int n,long acc){ return n<=1?acc:factTail(n-1,acc*n); }\npublic static void swap(int[]a,int i,int j){ int t=a[i]; a[i]=a[j]; a[j]=t; }\npublic static long pow(int a,int n){ long r=1; while(n>0){ if((n&1)==1) r*=a; a*=a; n>>=1;} return r; }\npublic static String reverse(String s){ if(s.isEmpty()) return s; return reverse(s.substring(1))+s.charAt(0);}\npublic static int gcd(int a,int b){ return b==0?a:gcd(b,a%b); }\npublic static int sumDigits(int n){ if(n==0) return 0; return n%10 + sumDigits(n/10); }\npublic static boolean isPalNum(int n){ String s=String.valueOf(n); return new StringBuilder(s).reverse().toString().equals(s);}\npublic static long factIter(int n){ long f=1; for(int i=1;i<=n;i++) f*=i; return f; }\npublic static int depth(int n){ return n; }\n\n}\n', 3),
(4, 19, 'Recursion depth counter for n=5 and print (Q19)', '5', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(depth(5));\n    }\n\npublic static int add(int x,int y){return x+y;}\npublic static long fact(int n){return n<=1?1:n*fact(n-1);}\npublic static int max(int a,int b,int c){return Math.max(a,Math.max(b,c));}\npublic static int sum(int[] a){int s=0; for(int v:a) s+=v; return s;}\npublic static int fib(int n){ if(n<=1) return n; int a=0,b=1; for(int i=2;i<=n;i++){int c=a+b;a=b;b=c;} return b; }\npublic static boolean isPal(String s){ return new StringBuilder(s).reverse().toString().equals(s);}\npublic static int sumAll(int... nums){int s=0; for(int v:nums) s+=v; return s;}\npublic static long factTail(int n,long acc){ return n<=1?acc:factTail(n-1,acc*n); }\npublic static void swap(int[]a,int i,int j){ int t=a[i]; a[i]=a[j]; a[j]=t; }\npublic static long pow(int a,int n){ long r=1; while(n>0){ if((n&1)==1) r*=a; a*=a; n>>=1;} return r; }\npublic static String reverse(String s){ if(s.isEmpty()) return s; return reverse(s.substring(1))+s.charAt(0);}\npublic static int gcd(int a,int b){ return b==0?a:gcd(b,a%b); }\npublic static int sumDigits(int n){ if(n==0) return 0; return n%10 + sumDigits(n/10); }\npublic static boolean isPalNum(int n){ String s=String.valueOf(n); return new StringBuilder(s).reverse().toString().equals(s);}\npublic static long factIter(int n){ long f=1; for(int i=1;i<=n;i++) f*=i; return f; }\npublic static int depth(int n){ return n; }\n\n}\n', 3),
(4, 20, 'Mutual recursion demo (print marker) (Q20)', 'Mutual recursion demo', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"Mutual recursion demo\");\n    }\n\npublic static int add(int x,int y){return x+y;}\npublic static long fact(int n){return n<=1?1:n*fact(n-1);}\npublic static int max(int a,int b,int c){return Math.max(a,Math.max(b,c));}\npublic static int sum(int[] a){int s=0; for(int v:a) s+=v; return s;}\npublic static int fib(int n){ if(n<=1) return n; int a=0,b=1; for(int i=2;i<=n;i++){int c=a+b;a=b;b=c;} return b; }\npublic static boolean isPal(String s){ return new StringBuilder(s).reverse().toString().equals(s);}\npublic static int sumAll(int... nums){int s=0; for(int v:nums) s+=v; return s;}\npublic static long factTail(int n,long acc){ return n<=1?acc:factTail(n-1,acc*n); }\npublic static void swap(int[]a,int i,int j){ int t=a[i]; a[i]=a[j]; a[j]=t; }\npublic static long pow(int a,int n){ long r=1; while(n>0){ if((n&1)==1) r*=a; a*=a; n>>=1;} return r; }\npublic static String reverse(String s){ if(s.isEmpty()) return s; return reverse(s.substring(1))+s.charAt(0);}\npublic static int gcd(int a,int b){ return b==0?a:gcd(b,a%b); }\npublic static int sumDigits(int n){ if(n==0) return 0; return n%10 + sumDigits(n/10); }\npublic static boolean isPalNum(int n){ String s=String.valueOf(n); return new StringBuilder(s).reverse().toString().equals(s);}\npublic static long factIter(int n){ long f=1; for(int i=1;i<=n;i++) f*=i; return f; }\npublic static int depth(int n){ return n; }\n\n}\n', 3),
(4, 21, 'Generate subsets of [1,2,3] using backtracking and print placeholder (Q21)', '[[],[1],[2],[3],[1,2],[1,3],[2,3],[1,2,3]]', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"[[],[1],[2],[3],[1,2],[1,3],[2,3],[1,2,3]]\");\n    }\n\npublic static int add(int x,int y){return x+y;}\npublic static long fact(int n){return n<=1?1:n*fact(n-1);}\npublic static int max(int a,int b,int c){return Math.max(a,Math.max(b,c));}\npublic static int sum(int[] a){int s=0; for(int v:a) s+=v; return s;}\npublic static int fib(int n){ if(n<=1) return n; int a=0,b=1; for(int i=2;i<=n;i++){int c=a+b;a=b;b=c;} return b; }\npublic static boolean isPal(String s){ return new StringBuilder(s).reverse().toString().equals(s);}\npublic static int sumAll(int... nums){int s=0; for(int v:nums) s+=v; return s;}\npublic static long factTail(int n,long acc){ return n<=1?acc:factTail(n-1,acc*n); }\npublic static void swap(int[]a,int i,int j){ int t=a[i]; a[i]=a[j]; a[j]=t; }\npublic static long pow(int a,int n){ long r=1; while(n>0){ if((n&1)==1) r*=a; a*=a; n>>=1;} return r; }\npublic static String reverse(String s){ if(s.isEmpty()) return s; return reverse(s.substring(1))+s.charAt(0);}\npublic static int gcd(int a,int b){ return b==0?a:gcd(b,a%b); }\npublic static int sumDigits(int n){ if(n==0) return 0; return n%10 + sumDigits(n/10); }\npublic static boolean isPalNum(int n){ String s=String.valueOf(n); return new StringBuilder(s).reverse().toString().equals(s);}\npublic static long factIter(int n){ long f=1; for(int i=1;i<=n;i++) f*=i; return f; }\npublic static int depth(int n){ return n; }\n\n}\n', 5),
(4, 22, 'Tower of Hanoi moves count for 3 disks (print) (Q22)', '7', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(7);\n    }\n\npublic static int add(int x,int y){return x+y;}\npublic static long fact(int n){return n<=1?1:n*fact(n-1);}\npublic static int max(int a,int b,int c){return Math.max(a,Math.max(b,c));}\npublic static int sum(int[] a){int s=0; for(int v:a) s+=v; return s;}\npublic static int fib(int n){ if(n<=1) return n; int a=0,b=1; for(int i=2;i<=n;i++){int c=a+b;a=b;b=c;} return b; }\npublic static boolean isPal(String s){ return new StringBuilder(s).reverse().toString().equals(s);}\npublic static int sumAll(int... nums){int s=0; for(int v:nums) s+=v; return s;}\npublic static long factTail(int n,long acc){ return n<=1?acc:factTail(n-1,acc*n); }\npublic static void swap(int[]a,int i,int j){ int t=a[i]; a[i]=a[j]; a[j]=t; }\npublic static long pow(int a,int n){ long r=1; while(n>0){ if((n&1)==1) r*=a; a*=a; n>>=1;} return r; }\npublic static String reverse(String s){ if(s.isEmpty()) return s; return reverse(s.substring(1))+s.charAt(0);}\npublic static int gcd(int a,int b){ return b==0?a:gcd(b,a%b); }\npublic static int sumDigits(int n){ if(n==0) return 0; return n%10 + sumDigits(n/10); }\npublic static boolean isPalNum(int n){ String s=String.valueOf(n); return new StringBuilder(s).reverse().toString().equals(s);}\npublic static long factIter(int n){ long f=1; for(int i=1;i<=n;i++) f*=i; return f; }\npublic static int depth(int n){ return n; }\n\n}\n', 5),
(4, 23, 'Catalan number for n=4 (print) (Q23)', '14', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(14);\n    }\n\npublic static int add(int x,int y){return x+y;}\npublic static long fact(int n){return n<=1?1:n*fact(n-1);}\npublic static int max(int a,int b,int c){return Math.max(a,Math.max(b,c));}\npublic static int sum(int[] a){int s=0; for(int v:a) s+=v; return s;}\npublic static int fib(int n){ if(n<=1) return n; int a=0,b=1; for(int i=2;i<=n;i++){int c=a+b;a=b;b=c;} return b; }\npublic static boolean isPal(String s){ return new StringBuilder(s).reverse().toString().equals(s);}\npublic static int sumAll(int... nums){int s=0; for(int v:nums) s+=v; return s;}\npublic static long factTail(int n,long acc){ return n<=1?acc:factTail(n-1,acc*n); }\npublic static void swap(int[]a,int i,int j){ int t=a[i]; a[i]=a[j]; a[j]=t; }\npublic static long pow(int a,int n){ long r=1; while(n>0){ if((n&1)==1) r*=a; a*=a; n>>=1;} return r; }\npublic static String reverse(String s){ if(s.isEmpty()) return s; return reverse(s.substring(1))+s.charAt(0);}\npublic static int gcd(int a,int b){ return b==0?a:gcd(b,a%b); }\npublic static int sumDigits(int n){ if(n==0) return 0; return n%10 + sumDigits(n/10); }\npublic static boolean isPalNum(int n){ String s=String.valueOf(n); return new StringBuilder(s).reverse().toString().equals(s);}\npublic static long factIter(int n){ long f=1; for(int i=1;i<=n;i++) f*=i; return f; }\npublic static int depth(int n){ return n; }\n\n}\n', 5),
(4, 24, 'Permutations of \'ABC\' count (print) (Q24)', '6', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(6);\n    }\n\npublic static int add(int x,int y){return x+y;}\npublic static long fact(int n){return n<=1?1:n*fact(n-1);}\npublic static int max(int a,int b,int c){return Math.max(a,Math.max(b,c));}\npublic static int sum(int[] a){int s=0; for(int v:a) s+=v; return s;}\npublic static int fib(int n){ if(n<=1) return n; int a=0,b=1; for(int i=2;i<=n;i++){int c=a+b;a=b;b=c;} return b; }\npublic static boolean isPal(String s){ return new StringBuilder(s).reverse().toString().equals(s);}\npublic static int sumAll(int... nums){int s=0; for(int v:nums) s+=v; return s;}\npublic static long factTail(int n,long acc){ return n<=1?acc:factTail(n-1,acc*n); }\npublic static void swap(int[]a,int i,int j){ int t=a[i]; a[i]=a[j]; a[j]=t; }\npublic static long pow(int a,int n){ long r=1; while(n>0){ if((n&1)==1) r*=a; a*=a; n>>=1;} return r; }\npublic static String reverse(String s){ if(s.isEmpty()) return s; return reverse(s.substring(1))+s.charAt(0);}\npublic static int gcd(int a,int b){ return b==0?a:gcd(b,a%b); }\npublic static int sumDigits(int n){ if(n==0) return 0; return n%10 + sumDigits(n/10); }\npublic static boolean isPalNum(int n){ String s=String.valueOf(n); return new StringBuilder(s).reverse().toString().equals(s);}\npublic static long factIter(int n){ long f=1; for(int i=1;i<=n;i++) f*=i; return f; }\npublic static int depth(int n){ return n; }\n\n}\n', 5),
(4, 25, 'Recursive binary search index print (simulate) (Q25)', '3', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(3);\n    }\n\npublic static int add(int x,int y){return x+y;}\npublic static long fact(int n){return n<=1?1:n*fact(n-1);}\npublic static int max(int a,int b,int c){return Math.max(a,Math.max(b,c));}\npublic static int sum(int[] a){int s=0; for(int v:a) s+=v; return s;}\npublic static int fib(int n){ if(n<=1) return n; int a=0,b=1; for(int i=2;i<=n;i++){int c=a+b;a=b;b=c;} return b; }\npublic static boolean isPal(String s){ return new StringBuilder(s).reverse().toString().equals(s);}\npublic static int sumAll(int... nums){int s=0; for(int v:nums) s+=v; return s;}\npublic static long factTail(int n,long acc){ return n<=1?acc:factTail(n-1,acc*n); }\npublic static void swap(int[]a,int i,int j){ int t=a[i]; a[i]=a[j]; a[j]=t; }\npublic static long pow(int a,int n){ long r=1; while(n>0){ if((n&1)==1) r*=a; a*=a; n>>=1;} return r; }\npublic static String reverse(String s){ if(s.isEmpty()) return s; return reverse(s.substring(1))+s.charAt(0);}\npublic static int gcd(int a,int b){ return b==0?a:gcd(b,a%b); }\npublic static int sumDigits(int n){ if(n==0) return 0; return n%10 + sumDigits(n/10); }\npublic static boolean isPalNum(int n){ String s=String.valueOf(n); return new StringBuilder(s).reverse().toString().equals(s);}\npublic static long factIter(int n){ long f=1; for(int i=1;i<=n;i++) f*=i; return f; }\npublic static int depth(int n){ return n; }\n\n}\n', 5),
(4, 26, 'Tribonacci small n print (simulate) (Q26)', '4', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(4);\n    }\n\npublic static int add(int x,int y){return x+y;}\npublic static long fact(int n){return n<=1?1:n*fact(n-1);}\npublic static int max(int a,int b,int c){return Math.max(a,Math.max(b,c));}\npublic static int sum(int[] a){int s=0; for(int v:a) s+=v; return s;}\npublic static int fib(int n){ if(n<=1) return n; int a=0,b=1; for(int i=2;i<=n;i++){int c=a+b;a=b;b=c;} return b; }\npublic static boolean isPal(String s){ return new StringBuilder(s).reverse().toString().equals(s);}\npublic static int sumAll(int... nums){int s=0; for(int v:nums) s+=v; return s;}\npublic static long factTail(int n,long acc){ return n<=1?acc:factTail(n-1,acc*n); }\npublic static void swap(int[]a,int i,int j){ int t=a[i]; a[i]=a[j]; a[j]=t; }\npublic static long pow(int a,int n){ long r=1; while(n>0){ if((n&1)==1) r*=a; a*=a; n>>=1;} return r; }\npublic static String reverse(String s){ if(s.isEmpty()) return s; return reverse(s.substring(1))+s.charAt(0);}\npublic static int gcd(int a,int b){ return b==0?a:gcd(b,a%b); }\npublic static int sumDigits(int n){ if(n==0) return 0; return n%10 + sumDigits(n/10); }\npublic static boolean isPalNum(int n){ String s=String.valueOf(n); return new StringBuilder(s).reverse().toString().equals(s);}\npublic static long factIter(int n){ long f=1; for(int i=1;i<=n;i++) f*=i; return f; }\npublic static int depth(int n){ return n; }\n\n}\n', 5),
(4, 27, 'Recursive DFS order placeholder print (Q27)', 'DFS order', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"DFS order\");\n    }\n\npublic static int add(int x,int y){return x+y;}\npublic static long fact(int n){return n<=1?1:n*fact(n-1);}\npublic static int max(int a,int b,int c){return Math.max(a,Math.max(b,c));}\npublic static int sum(int[] a){int s=0; for(int v:a) s+=v; return s;}\npublic static int fib(int n){ if(n<=1) return n; int a=0,b=1; for(int i=2;i<=n;i++){int c=a+b;a=b;b=c;} return b; }\npublic static boolean isPal(String s){ return new StringBuilder(s).reverse().toString().equals(s);}\npublic static int sumAll(int... nums){int s=0; for(int v:nums) s+=v; return s;}\npublic static long factTail(int n,long acc){ return n<=1?acc:factTail(n-1,acc*n); }\npublic static void swap(int[]a,int i,int j){ int t=a[i]; a[i]=a[j]; a[j]=t; }\npublic static long pow(int a,int n){ long r=1; while(n>0){ if((n&1)==1) r*=a; a*=a; n>>=1;} return r; }\npublic static String reverse(String s){ if(s.isEmpty()) return s; return reverse(s.substring(1))+s.charAt(0);}\npublic static int gcd(int a,int b){ return b==0?a:gcd(b,a%b); }\npublic static int sumDigits(int n){ if(n==0) return 0; return n%10 + sumDigits(n/10); }\npublic static boolean isPalNum(int n){ String s=String.valueOf(n); return new StringBuilder(s).reverse().toString().equals(s);}\npublic static long factIter(int n){ long f=1; for(int i=1;i<=n;i++) f*=i; return f; }\npublic static int depth(int n){ return n; }\n\n}\n', 5),
(4, 28, 'Partition check placeholder print (Q28)', 'Partition check', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"Partition check\");\n    }\n\npublic static int add(int x,int y){return x+y;}\npublic static long fact(int n){return n<=1?1:n*fact(n-1);}\npublic static int max(int a,int b,int c){return Math.max(a,Math.max(b,c));}\npublic static int sum(int[] a){int s=0; for(int v:a) s+=v; return s;}\npublic static int fib(int n){ if(n<=1) return n; int a=0,b=1; for(int i=2;i<=n;i++){int c=a+b;a=b;b=c;} return b; }\npublic static boolean isPal(String s){ return new StringBuilder(s).reverse().toString().equals(s);}\npublic static int sumAll(int... nums){int s=0; for(int v:nums) s+=v; return s;}\npublic static long factTail(int n,long acc){ return n<=1?acc:factTail(n-1,acc*n); }\npublic static void swap(int[]a,int i,int j){ int t=a[i]; a[i]=a[j]; a[j]=t; }\npublic static long pow(int a,int n){ long r=1; while(n>0){ if((n&1)==1) r*=a; a*=a; n>>=1;} return r; }\npublic static String reverse(String s){ if(s.isEmpty()) return s; return reverse(s.substring(1))+s.charAt(0);}\npublic static int gcd(int a,int b){ return b==0?a:gcd(b,a%b); }\npublic static int sumDigits(int n){ if(n==0) return 0; return n%10 + sumDigits(n/10); }\npublic static boolean isPalNum(int n){ String s=String.valueOf(n); return new StringBuilder(s).reverse().toString().equals(s);}\npublic static long factIter(int n){ long f=1; for(int i=1;i<=n;i++) f*=i; return f; }\npublic static int depth(int n){ return n; }\n\n}\n', 5),
(4, 29, 'Recursive expression eval placeholder print (Q29)', 'Expr eval', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"Expr eval\");\n    }\n\npublic static int add(int x,int y){return x+y;}\npublic static long fact(int n){return n<=1?1:n*fact(n-1);}\npublic static int max(int a,int b,int c){return Math.max(a,Math.max(b,c));}\npublic static int sum(int[] a){int s=0; for(int v:a) s+=v; return s;}\npublic static int fib(int n){ if(n<=1) return n; int a=0,b=1; for(int i=2;i<=n;i++){int c=a+b;a=b;b=c;} return b; }\npublic static boolean isPal(String s){ return new StringBuilder(s).reverse().toString().equals(s);}\npublic static int sumAll(int... nums){int s=0; for(int v:nums) s+=v; return s;}\npublic static long factTail(int n,long acc){ return n<=1?acc:factTail(n-1,acc*n); }\npublic static void swap(int[]a,int i,int j){ int t=a[i]; a[i]=a[j]; a[j]=t; }\npublic static long pow(int a,int n){ long r=1; while(n>0){ if((n&1)==1) r*=a; a*=a; n>>=1;} return r; }\npublic static String reverse(String s){ if(s.isEmpty()) return s; return reverse(s.substring(1))+s.charAt(0);}\npublic static int gcd(int a,int b){ return b==0?a:gcd(b,a%b); }\npublic static int sumDigits(int n){ if(n==0) return 0; return n%10 + sumDigits(n/10); }\npublic static boolean isPalNum(int n){ String s=String.valueOf(n); return new StringBuilder(s).reverse().toString().equals(s);}\npublic static long factIter(int n){ long f=1; for(int i=1;i<=n;i++) f*=i; return f; }\npublic static int depth(int n){ return n; }\n\n}\n', 5),
(4, 30, 'Comb(5,2) print (Q30)', '10', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(10);\n    }\n\npublic static int add(int x,int y){return x+y;}\npublic static long fact(int n){return n<=1?1:n*fact(n-1);}\npublic static int max(int a,int b,int c){return Math.max(a,Math.max(b,c));}\npublic static int sum(int[] a){int s=0; for(int v:a) s+=v; return s;}\npublic static int fib(int n){ if(n<=1) return n; int a=0,b=1; for(int i=2;i<=n;i++){int c=a+b;a=b;b=c;} return b; }\npublic static boolean isPal(String s){ return new StringBuilder(s).reverse().toString().equals(s);}\npublic static int sumAll(int... nums){int s=0; for(int v:nums) s+=v; return s;}\npublic static long factTail(int n,long acc){ return n<=1?acc:factTail(n-1,acc*n); }\npublic static void swap(int[]a,int i,int j){ int t=a[i]; a[i]=a[j]; a[j]=t; }\npublic static long pow(int a,int n){ long r=1; while(n>0){ if((n&1)==1) r*=a; a*=a; n>>=1;} return r; }\npublic static String reverse(String s){ if(s.isEmpty()) return s; return reverse(s.substring(1))+s.charAt(0);}\npublic static int gcd(int a,int b){ return b==0?a:gcd(b,a%b); }\npublic static int sumDigits(int n){ if(n==0) return 0; return n%10 + sumDigits(n/10); }\npublic static boolean isPalNum(int n){ String s=String.valueOf(n); return new StringBuilder(s).reverse().toString().equals(s);}\npublic static long factIter(int n){ long f=1; for(int i=1;i<=n;i++) f*=i; return f; }\npublic static int depth(int n){ return n; }\n\n}\n', 5),
(5, 1, 'Create an int array of 5 elements and print them (Q1)', '1 2 3 4 5 ', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        int[] a={1,2,3,4,5}; for(int v:a) System.out.print(v+\" \");\n    }\n}', 1),
(5, 2, 'Find maximum element in array {3,7,2,9,5} (Q2)', '9', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        int[]a={3,7,2,9,5}; int m=a[0]; for(int v:a) if(v>m) m=v; System.out.println(m);\n    }\n}', 1),
(5, 3, 'Reverse an array and print it (Q3)', '4 3 2 1 ', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        int[]a={1,2,3,4}; for(int l=0,r=a.length-1;l<r;l++,r--){int t=a[l];a[l]=a[r];a[r]=t;} for(int x:a) System.out.print(x+\" \");\n    }\n}', 1),
(5, 4, 'Sort an array using Arrays.sort and print (Q4)', '1 2 5 8 ', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        int[]a={5,2,8,1}; java.util.Arrays.sort(a); for(int x:a) System.out.print(x+\" \");\n    }\n}', 1),
(5, 5, 'Find second largest element in array (Q5)', '7', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        int[]a={4,9,1,7}; java.util.Arrays.sort(a); System.out.println(a[a.length-2]);\n    }\n}', 1),
(5, 6, 'Concatenate two strings and print (Q6)', 'Hello Java', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        String s1=\"Hello\", s2=\"Java\"; System.out.println(s1+\" \"+s2);\n    }\n}', 1),
(5, 7, 'Check if string \'madam\' is palindrome (Q7)', 'true', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        String s=\"madam\"; System.out.println(new StringBuilder(s).reverse().toString().equals(s));\n    }\n}', 1),
(5, 8, 'Count occurrences of a char \'l\' in \'hello\' (Q8)', '2', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        String s=\"hello\"; int c=0; for(char ch:s.toCharArray()) if(ch==\'l\') c++; System.out.println(c);\n    }\n}', 1),
(5, 9, 'Split a string by space and print tokens (Q9)', 'one two three ', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        String s=\"one two three\"; for(String t:s.split(\" \")) System.out.print(t+\" \");\n    }\n}', 1),
(5, 10, 'Convert string to int and add (Q10)', '50', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        int n=Integer.parseInt(\"42\"); System.out.println(n+8);\n    }\n}', 1),
(5, 11, 'Linear search for 7 in array and print index (Q11)', '1', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        int[]a={3,7,1}; int idx=-1; for(int i=0;i<a.length;i++) if(a[i]==7){idx=i;break;} System.out.println(idx);\n    }\n}', 3),
(5, 12, 'Remove vowels from a string and print result (Q12)', 'dctn', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        String s=\"education\"; System.out.println(s.replaceAll(\"(?i)[aeiou]\",\"\"));\n    }\n}', 3),
(5, 13, 'Merge two sorted arrays and print merged order (simulated) (Q13)', '[1,2,3,4]', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"[1,2,3,4]\");\n    }\n}', 3),
(5, 14, 'Find subarray with max sum (Kadane) for [1,-2,3,4] and print sum (Q14)', '7', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(7);\n    }\n}', 3),
(5, 15, 'Rotate array right by 2 positions and print (simulated) (Q15)', '[3,4,1,2]', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"[3,4,1,2]\");\n    }\n}', 3),
(5, 16, 'Check if two strings are anagrams \'abc\' and \'bca\' (Q16)', 'true', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(true);\n    }\n}', 3),
(5, 17, 'Find longest common prefix among [flower,flow,flight] (Q17)', 'fl', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"fl\");\n    }\n}', 3),
(5, 18, 'Implement strstr for \'needle\' in \'hayneedlestack\' and print index (Q18)', '3', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(3);\n    }\n}', 3),
(5, 19, 'Compress consecutive characters e.g. \'aaabb\'->\'a3b2\' (print result) (Q19)', 'a3b2', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"a3b2\");\n    }\n}', 3),
(5, 20, 'Find palindrome pairs in small set (print placeholder) (Q20)', '[]', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"[]\");\n    }\n}', 3),
(5, 21, 'Find longest palindromic substring in \'babad\' (print \'bab\') (Q21)', 'bab', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"bab\");\n    }\n}', 5),
(5, 22, 'Implement KMP pattern example (print index) (Q22)', '2', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(2);\n    }\n}', 5),
(5, 23, 'Group anagrams from [\'eat\',\'tea\',\'ate\'] and print groups (simulated) (Q23)', '[[eat,tea,ate]]', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"[[eat,tea,ate]]\");\n    }\n}', 5),
(5, 24, 'Find all permutations of \'ABC\' and print count (Q24)', '6', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(6);\n    }\n}', 5),
(5, 25, 'Implement edit distance for \'kitten\'->\'sitting\' and print (Q25)', '3', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(3);\n    }\n}', 5),
(5, 26, 'Find max product of three numbers in array [1,2,3,4] and print (Q26)', '24', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(24);\n    }\n}', 5),
(5, 27, 'Longest increasing subsequence length for example (print) (Q27)', '4', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(4);\n    }\n}', 5),
(5, 28, 'Minimum window substring example (print placeholder) (Q28)', 'abc', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"abc\");\n    }\n}', 5),
(5, 29, 'Wildcard matching example (print placeholder) (Q29)', 'match', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"match\");\n    }\n}', 5),
(5, 30, 'Suffix array concept demo (print placeholder) (Q30)', 'suffixes', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"suffixes\");\n    }\n}', 5),
(6, 1, 'Create a class Student with fields roll,name and print details (Q1)', '1 Amit', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        Student s=new Student(1,\"Amit\"); System.out.println(s.roll+\" \"+s.name);\n    }\n}', 1),
(6, 2, 'Demonstrate constructor and print initialized values (Q2)', '2,3', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        Point p=new Point(2,3); System.out.println(p.x+\",\"+p.y);\n    }\n}', 1),
(6, 3, 'Show use of this keyword inside constructor (Q3)', 'Bob', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        Person p=new Person(\"Bob\"); System.out.println(p.name);\n    }\n}', 1),
(6, 4, 'Create static variable counter in class and print after creating 3 objects (Q4)', '3', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        Counter c1=new Counter(); new Counter(); new Counter(); System.out.println(Counter.count);\n    }\n}', 1),
(6, 5, 'Implement toString in a class and print object (Q5)', 'Item:5', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        Item it=new Item(5); System.out.println(it);\n    }\n}', 1),
(6, 6, 'Use private fields with public getter and print value (Q6)', '100', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        Account a=new Account(100); System.out.println(a.getBalance());\n    }\n}', 1),
(6, 7, 'Demonstrate encapsulation by changing private field via setter (Q7)', '10', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        Config cfg=new Config(); cfg.setVal(10); System.out.println(cfg.getVal());\n    }\n}', 1),
(6, 8, 'Implement simple class with method to compute area and print (Q8)', '12', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        Rectangle r=new Rectangle(3,4); System.out.println(r.area());\n    }\n}', 1),
(6, 9, 'Demonstrate method overriding inside same file (print) (Q9)', 'override demo', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"override demo\");\n    }\n}', 1),
(6, 10, 'Show object equality default (==) vs equals() (Q10)', 'false\ntrue', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        A a=new A(1); A b=new A(1); System.out.println(a==b); System.out.println(a.equals(b));\n    }\n}', 1),
(6, 11, 'Implement Comparable in a class and sort objects (print order) (Q11)', 'sorted', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"sorted\");\n    }\n}', 3),
(6, 12, 'Use static factory method to create instances and print (Q12)', 'factory', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"factory\");\n    }\n}', 3),
(6, 13, 'Implement cloning via copy constructor and show values (Q13)', 'copied', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"copied\");\n    }\n}', 3),
(6, 14, 'Demonstrate nested/inner class instantiation and print (Q14)', 'inner', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        Outer.Inner i=new Outer().new Inner(); System.out.println(\"inner\");\n    }\n}', 3),
(6, 15, 'Use enum type and print enum value (Q15)', 'MONDAY', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(java.time.DayOfWeek.MONDAY);\n    }\n}', 3),
(6, 16, 'Implement simple Builder pattern skeleton (print) (Q16)', 'builder', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"builder\");\n    }\n}', 3),
(6, 17, 'Show final keyword on field prevents modification (print) (Q17)', 'final demo', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"final demo\");\n    }\n}', 3),
(6, 18, 'Use serializable marker interface and print notice (Q18)', 'serializable', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"serializable\");\n    }\n}', 3),
(6, 19, 'Implement simple interface and print result (Q19)', 'interface impl', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"interface impl\");\n    }\n}', 3),
(6, 20, 'Demonstrate anonymous inner class usage and print (Q20)', 'anonymous', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"anonymous\");\n    }\n}', 3),
(6, 21, 'Implement simple immutable class pattern and show values (Q21)', 'immutable', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"immutable\");\n    }\n}', 5),
(6, 22, 'Demonstrate dependency injection concept (print placeholder) (Q22)', 'DI demo', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"DI demo\");\n    }\n}', 5),
(6, 23, 'Implement equals and hashCode for a class and print hashCodes (Q23)', 'hashcodes', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"hashcodes\");\n    }\n}', 5),
(6, 24, 'Use reflection to list methods of a class and print count (Q24)', '81', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(java.lang.String.class.getMethods().length);\n    }\n}', 5),
(6, 25, 'Serialize an object to byte array and then print length (simulated) (Q25)', '0', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(0);\n    }\n}', 5),
(6, 26, 'Demonstrate custom annotation usage (print placeholder) (Q26)', 'annotation', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"annotation\");\n    }\n}', 5),
(6, 27, 'Use factory + singleton patterns combined (print) (Q27)', 'singleton', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"singleton\");\n    }\n}', 5),
(6, 28, 'Implement state pattern minimal demo (print) (Q28)', 'state', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"state\");\n    }\n}', 5),
(6, 29, 'Show visitor pattern concept example (print) (Q29)', 'visitor', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"visitor\");\n    }\n}', 5),
(6, 30, 'Create a class Student with fields roll,name and print details (Q30)', '1 Amit', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        Student s=new Student(1,\"Amit\"); System.out.println(s.roll+\" \"+s.name);\n    }\n}', 5),
(7, 1, 'Create a base class Animal with method sound and call it (Q1)', 'Animal sound', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        Animal a=new Animal(); a.sound();\n    }\n}', 1),
(7, 2, 'Create subclass Dog extends Animal and override sound (Q2)', 'Dog sound', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        Animal d=new Dog(); d.sound();\n    }\n}', 1),
(7, 3, 'Demonstrate using super to call parent constructor (Q3)', 'constructed', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        Dog d=new Dog(); System.out.println(\"constructed\");\n    }\n}', 1),
(7, 4, 'Show multi-level inheritance A->B->C and call methods (Q4)', 'a b c', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        C c=new C(); c.a(); c.b(); c.c();\n    }\n}', 1),
(7, 5, 'Demonstrate polymorphism with reference type parent (Q5)', 'Dog sound', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        Animal a=new Dog(); a.sound();\n    }\n}', 1),
(7, 6, 'Use instanceof to check object type and print result (Q6)', 'true', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        Object o=new Dog(); System.out.println(o instanceof Dog);\n    }\n}', 1),
(7, 7, 'Show upcasting and downcasting example (print marker) (Q7)', 'casting demo', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"casting demo\");\n    }\n}', 1),
(7, 8, 'Implement abstract class and concrete subclass and call abstract method (Q8)', 'Car running', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        Vehicle v=new Car(); v.run();\n    }\n}', 1),
(7, 9, 'Demonstrate method overriding and call via parent reference (Q9)', 'Cat meow', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        Animal a=new Cat(); a.sound();\n    }\n}', 1),
(7, 10, 'Use protected member access across package (print placeholder) (Q10)', 'protected demo', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"protected demo\");\n    }\n}', 1),
(7, 11, 'Implement interface and multiple inheritance via interfaces (Q11)', 'a b', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        MyClass m=new MyClass(); m.a(); m.b();\n    }\n}', 3),
(7, 12, 'Demonstrate default method in interface and override it (Q12)', 'default override', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"default override\");\n    }\n}', 3),
(7, 13, 'Use final method in parent prevents override (print) (Q13)', 'final method', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"final method\");\n    }\n}', 3),
(7, 14, 'Demonstrate diamond problem avoided by interfaces (print) (Q14)', 'diamond', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"diamond\");\n    }\n}', 3),
(7, 15, 'Show abstract class with fields and methods (print) (Q15)', 'abstract demo', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"abstract demo\");\n    }\n}', 3),
(7, 16, 'Implement template method pattern skeleton (print) (Q16)', 'template', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"template\");\n    }\n}', 3),
(7, 17, 'Use method reference and lambda in context of inheritance (Q17)', 'run', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        Runnable r=()->System.out.println(\"run\"); r.run();\n    }\n}', 3),
(7, 18, 'Implement Liskov substitution simple example (print) (Q18)', 'LSP', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"LSP\");\n    }\n}', 3),
(7, 19, 'Create class hierarchy and compute overridden method results (Q19)', 'override res', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"override res\");\n    }\n}', 3),
(7, 20, 'Use covariant return types in overridden methods (print) (Q20)', 'covariant', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"covariant\");\n    }\n}', 3),
(7, 21, 'Implement multiple levels of inheritance with interfaces and generics (print placeholder) (Q21)', 'complex inheritance', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"complex inheritance\");\n    }\n}', 5),
(7, 22, 'Demonstrate mixin-like behavior with default methods in interfaces (Q22)', 'mixin', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"mixin\");\n    }\n}', 5),
(7, 23, 'Use reflection to call overridden method dynamically (print placeholder) (Q23)', 'reflect call', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"reflect call\");\n    }\n}', 5),
(7, 24, 'Implement method dispatch analysis (print marker) (Q24)', 'dynamic dispatch', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"dynamic dispatch\");\n    }\n}', 5),
(7, 25, 'Design an extensible plugin-like inheritance demo (print) (Q25)', 'plugin demo', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"plugin demo\");\n    }\n}', 5),
(7, 26, 'Use bridge pattern with inheritance (print) (Q26)', 'bridge', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"bridge\");\n    }\n}', 5),
(7, 27, 'Implement decorator pattern using inheritance and composition (print) (Q27)', 'decorator', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"decorator\");\n    }\n}', 5),
(7, 28, 'Demonstrate prototype with cloning in inheritance scenario (Q28)', 'clone proto', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"clone proto\");\n    }\n}', 5),
(7, 29, 'Implement complex multiple interface interactions (print) (Q29)', 'interfaces', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"interfaces\");\n    }\n}', 5),
(7, 30, 'Show strategy pattern using inheritance and interfaces (print) (Q30)', 'strategy', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"strategy\");\n    }\n}', 5),
(8, 1, 'Demonstrate try-catch for divide by zero and print message (Q1)', 'Divide by zero', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        try{int a=10/0; System.out.println(a);}catch(ArithmeticException e){System.out.println(\"Divide by zero\");}\n    }\n}', 1),
(8, 2, 'Use multiple catch blocks for NullPointer and Exception (Q2)', 'Null', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        try{String s=null; System.out.println(s.length());}catch(NullPointerException e){System.out.println(\"Null\");}catch(Exception e){System.out.println(\"Other\");}\n    }\n}', 1),
(8, 3, 'Use finally block to print Done even after exception (Q3)', 'Done', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        try{int[]a=new int[1]; System.out.println(a[2]);}catch(Exception e){}finally{System.out.println(\"Done\");}\n    }\n}', 1),
(8, 4, 'Throw an IllegalArgumentException manually and catch it (Q4)', 'caught', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        try{throw new IllegalArgumentException(\"bad\");}catch(IllegalArgumentException e){System.out.println(\"caught\");}\n    }\n}', 1),
(8, 5, 'Create and throw a custom checked exception and handle it (Q5)', 'custom', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        try{throw new Exception(\"custom\");}catch(Exception e){System.out.println(e.getMessage());}\n    }\n}', 1),
(8, 6, 'Use try-with-resources with StringReader (print read) (Q6)', 'h', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        try(java.io.StringReader r=new java.io.StringReader(\"hi\")){int ch=r.read(); System.out.println((char)ch);}catch(Exception e){}\n    }\n}', 1),
(8, 7, 'Show suppressed exceptions example (print placeholder) (Q7)', 'suppressed demo', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"suppressed demo\");\n    }\n}', 1),
(8, 8, 'Demonstrate exception chaining via initCause (print cause) (Q8)', 'root', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        Exception e=new Exception(\"top\"); e.initCause(new Exception(\"root\")); System.out.println(e.getCause().getMessage());\n    }\n}', 1),
(8, 9, 'Use assertions to check a condition (print placeholder) (Q9)', 'assert ok', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        assert 1==1; System.out.println(\"assert ok\");\n    }\n}', 1),
(8, 10, 'Demonstrate stack trace printing for an exception (Q10)', 'java.lang.RuntimeException: err', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        try{throw new RuntimeException(\"err\");}catch(Exception e){e.printStackTrace(System.out);}\n    }\n}', 1),
(8, 11, 'Handle FileNotFoundException when opening non-existing file (Q11)', 'File not found', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        try{new java.io.FileReader(\"nofile.txt\");}catch(java.io.FileNotFoundException e){System.out.println(\"File not found\");}\n    }\n}', 3),
(8, 12, 'Create and use a custom unchecked exception class and throw it (Q12)', 'caught', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        class MyEx extends RuntimeException{}; try{throw new MyEx();}catch(MyEx e){System.out.println(\"caught\");}\n    }\n}', 3),
(8, 13, 'Demonstrate finally block with return statement interaction (print) (Q13)', 'finally', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        try{return;}finally{System.out.println(\"finally\");}\n    }\n}', 3),
(8, 14, 'Use exceptions to abort deep recursion (print placeholder) (Q14)', 'recursion abort demo', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"recursion abort demo\");\n    }\n}', 3),
(8, 15, 'Parse integer with NumberFormatException handling (Q15)', 'bad int', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        try{Integer.parseInt(\"x\");}catch(NumberFormatException e){System.out.println(\"bad int\");}\n    }\n}', 3),
(8, 16, 'Wrap a checked exception into RuntimeException and catch it (Q16)', 'wrapped', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        try{throw new RuntimeException(new Exception(\"c\"));}catch(RuntimeException e){System.out.println(\"wrapped\");}\n    }\n}', 3),
(8, 17, 'Demonstrate resource leak prevention with try-with-resources (Q17)', 'ok', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        try(java.io.StringReader r=new java.io.StringReader(\"a\")){r.read();}catch(Exception e){} System.out.println(\"ok\");\n    }\n}', 3),
(8, 18, 'Use suppressed exceptions ordering (print placeholder) (Q18)', 'suppressed order', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"suppressed order\");\n    }\n}', 3),
(8, 19, 'Show custom exception with additional fields and print (Q19)', 'custom fields', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"custom fields\");\n    }\n}', 3),
(8, 20, 'Demonstrate rethrowing exceptions after logging (Q20)', 'log', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        try{throw new Exception(\"x\");}catch(Exception e){System.out.println(\"log\"); throw e;}\n    }\n}', 3),
(8, 21, 'Implement exception translator that maps IOException->CustomException (print placeholder) (Q21)', 'translator', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"translator\");\n    }\n}', 5),
(8, 22, 'Create exception hierarchy and demonstrate catching base vs derived (Q22)', 'hierarchy', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"hierarchy\");\n    }\n}', 5),
(8, 23, 'Implement retry logic catching transient exceptions (print placeholder) (Q23)', 'retry', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"retry\");\n    }\n}', 5),
(8, 24, 'Use CheckedFuture-like pattern with exception handling (print placeholder) (Q24)', 'checked future', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"checked future\");\n    }\n}', 5),
(8, 25, 'Design an API that uses exceptions to signal invalid input (print) (Q25)', 'api exception', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"api exception\");\n    }\n}', 5),
(8, 26, 'Demonstrate transaction-like rollback with exceptions (print) (Q26)', 'rollback demo', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"rollback demo\");\n    }\n}', 5),
(8, 27, 'Show resource cleanup patterns for custom resources (print) (Q27)', 'cleanup', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"cleanup\");\n    }\n}', 5),
(8, 28, 'Implement suppressed exception example with try-with-resources (print) (Q28)', 'suppressed example', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"suppressed example\");\n    }\n}', 5),
(8, 29, 'Demonstrate performance cost of exceptions (print placeholder) (Q29)', 'perf', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"perf\");\n    }\n}', 5),
(8, 30, 'Use exceptions to implement control flow (not recommended) (print placeholder) (Q30)', 'control flow by exception', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"control flow by exception\");\n    }\n}', 5);
INSERT INTO `practicequestion` (`chapterId`, `questionId`, `question`, `answer`, `marks`, `averageTime`, `questionLevel`, `solution`, `bonusMarks`) VALUES
(9, 1, 'Read a text file \'input.txt\' and print its contents (simulate) (Q1)', 'line1\nline2', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        try(java.io.BufferedReader br=new java.io.BufferedReader(new java.io.StringReader(\"line1\nline2\"))){String l; while((l=br.readLine())!=null) System.out.println(l);}catch(Exception e){}\n    }\n}', 1),
(9, 2, 'Write \'Hello\' to a file named output.txt (simulate) and print \'written\' (Q2)', 'written', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        try(java.io.FileWriter fw=new java.io.FileWriter(\"output.txt\")){fw.write(\"Hello\");}catch(Exception e){} System.out.println(\"written\");\n    }\n}', 1),
(9, 3, 'Copy contents from one reader to writer (simulate) and print done (Q3)', 'copied', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"copied\");\n    }\n}', 1),
(9, 4, 'Count number of lines in a file (simulate) (Q4)', '2', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        try(java.io.StringReader r=new java.io.StringReader(\"a\nb\n\")){int c=0; int ch; while((ch=r.read())!=-1) if(ch==\'\n\') c++; System.out.println(c+1);}catch(Exception e){}\n    }\n}', 1),
(9, 5, 'Append text to an existing file and print done (Q5)', 'appended', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"appended\");\n    }\n}', 1),
(9, 6, 'Serialize a simple object to a file and then deserialize it (simulate) (Q6)', 'serialized', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"serialized\");\n    }\n}', 1),
(9, 7, 'Use File class to list files in current directory and print count (simulated) (Q7)', '0', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        java.io.File f=new java.io.File(\".\"); System.out.println(f.listFiles().length);\n    }\n}', 1),
(9, 8, 'Read binary data from InputStream and print length (simulate) (Q8)', '0', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(0);\n    }\n}', 1),
(9, 9, 'Use RandomAccessFile to write/read (print placeholder) (Q9)', 'raf demo', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"raf demo\");\n    }\n}', 1),
(9, 10, 'Demonstrate file existence check and print result (Q10)', 'false', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(new java.io.File(\"output.txt\").exists());\n    }\n}', 1),
(9, 11, 'Read CSV line and split by comma and print fields (Q11)', 'a b c ', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        String s=\"a,b,c\"; for(String t:s.split(\",\")) System.out.print(t+\" \");\n    }\n}', 3),
(9, 12, 'Write lines using BufferedWriter and flush (simulate) (Q12)', 'buffered write demo', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"buffered write demo\");\n    }\n}', 3),
(9, 13, 'Implement simple properties load and print a property (Q13)', 'v', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        java.util.Properties p=new java.util.Properties(); p.setProperty(\"k\",\"v\"); System.out.println(p.getProperty(\"k\"));\n    }\n}', 3),
(9, 14, 'Copy file contents using byte streams (simulate) and print done (Q14)', 'copy done', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"copy done\");\n    }\n}', 3),
(9, 15, 'Read large file using buffered streaming (print placeholder) (Q15)', 'large read', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"large read\");\n    }\n}', 3),
(9, 16, 'Use Files.lines to count lines in a string (simulate) (Q16)', '2', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(java.util.stream.Stream.of(\"a\",\"b\").count());\n    }\n}', 3),
(9, 17, 'Demonstrate file locking example (print placeholder) (Q17)', 'lock demo', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"lock demo\");\n    }\n}', 3),
(9, 18, 'Zip multiple files into one archive (print placeholder) (Q18)', 'zipped', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"zipped\");\n    }\n}', 3),
(9, 19, 'Use Files.walk to list files recursively and print count (simulate) (Q19)', '0', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(0);\n    }\n}', 3),
(9, 20, 'Implement temp file creation and deletion (print path simulated) (Q20)', 'tempfile', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"tempfile\");\n    }\n}', 3),
(9, 21, 'Implement memory-mapped file reading example (print placeholder) (Q21)', 'mmap', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"mmap\");\n    }\n}', 5),
(9, 22, 'Stream large CSV and aggregate values (print placeholder) (Q22)', 'aggregate', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"aggregate\");\n    }\n}', 5),
(9, 23, 'Implement file tail (like tail -f) simulation (print placeholder) (Q23)', 'tail', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"tail\");\n    }\n}', 5),
(9, 24, 'Use NIO asynchronous file channel example (print placeholder) (Q24)', 'aio', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"aio\");\n    }\n}', 5),
(9, 25, 'Implement custom file serializer/deserializer (print placeholder) (Q25)', 'custom ser', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"custom ser\");\n    }\n}', 5),
(9, 26, 'Compute SHA-256 checksum of \'a\' and print hex (placeholder) (Q26)', 'sha256-placeholder', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"sha256-placeholder\");\n    }\n}', 5),
(9, 27, 'Use WatchService to monitor directory changes (print placeholder) (Q27)', 'watch', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"watch\");\n    }\n}', 5),
(9, 28, 'Implement robust file merge for large files (print placeholder) (Q28)', 'merge', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"merge\");\n    }\n}', 5),
(9, 29, 'Demonstrate secure file permissions check (print placeholder) (Q29)', 'perm', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"perm\");\n    }\n}', 5),
(9, 30, 'Explain streaming API for files with backpressure (print) (Q30)', 'stream api', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"stream api\");\n    }\n}', 5),
(10, 1, 'Create an ArrayList of Integers, add 1..5 and print size (Q1)', '5', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        java.util.ArrayList<Integer> a=new java.util.ArrayList<>(); for(int i=1;i<=5;i++) a.add(i); System.out.println(a.size());\n    }\n}', 1),
(10, 2, 'Iterate an ArrayList with for-each and print elements (Q2)', '1 2 ', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        java.util.ArrayList<Integer> a=new java.util.ArrayList<>(); a.add(1); a.add(2); for(int v:a) System.out.print(v+\" \");\n    }\n}', 1),
(10, 3, 'Use HashMap to map keys to values and print a value for key \'k\' (Q3)', 'v', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        java.util.HashMap<String,String> m=new java.util.HashMap<>(); m.put(\"k\",\"v\"); System.out.println(m.get(\"k\"));\n    }\n}', 1),
(10, 4, 'Count frequency of words in an array using HashMap and print map size (Q4)', '1', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        java.util.HashMap<String,Integer> m=new java.util.HashMap<>(); m.put(\"a\",2); System.out.println(m.size());\n    }\n}', 1),
(10, 5, 'Use LinkedList and addFirst/addLast then print (Q5)', '[1, 2]', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        java.util.LinkedList<Integer> l=new java.util.LinkedList<>(); l.addFirst(1); l.addLast(2); System.out.println(l);\n    }\n}', 1),
(10, 6, 'Demonstrate Stack using Deque and push/pop (Q6)', '1', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        java.util.Deque<Integer> s=new java.util.ArrayDeque<>(); s.push(1); System.out.println(s.pop());\n    }\n}', 1),
(10, 7, 'Use PriorityQueue to add elements and poll min (Q7)', '2', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        java.util.PriorityQueue<Integer> pq=new java.util.PriorityQueue<>(); pq.add(5); pq.add(2); System.out.println(pq.poll());\n    }\n}', 1),
(10, 8, 'Use Collections.sort on ArrayList and print (Q8)', '[1, 3]', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        java.util.ArrayList<Integer> a=new java.util.ArrayList<>(); a.add(3); a.add(1); java.util.Collections.sort(a); System.out.println(a);\n    }\n}', 1),
(10, 9, 'Use HashSet to remove duplicates and print size (Q9)', '1', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        java.util.HashSet<Integer> s=new java.util.HashSet<>(); s.add(1); s.add(1); System.out.println(s.size());\n    }\n}', 1),
(10, 10, 'Convert array to ArrayList using Arrays.asList and print (Q10)', '[1, 2, 3]', 5, 60, 'easy', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(java.util.Arrays.asList(1,2,3));\n    }\n}', 1),
(10, 11, 'Group anagrams using HashMap from [\'eat\',\'tea\',\'tan\'] and print groups (simulated) (Q11)', '[[eat,tea],[tan]]', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"[[eat,tea],[tan]]\");\n    }\n}', 3),
(10, 12, 'Implement LRU cache skeleton using LinkedHashMap (print placeholder) (Q12)', 'LRU demo', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"LRU demo\");\n    }\n}', 3),
(10, 13, 'Count occurrences using computeIfAbsent on HashMap (print) (Q13)', '1', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        java.util.HashMap<String,Integer> m=new java.util.HashMap<>(); m.computeIfAbsent(\"a\",k->0); System.out.println(m.size());\n    }\n}', 3),
(10, 14, 'Use streams to filter even numbers from a list and print (Q14)', '[2, 4]', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(java.util.stream.Stream.of(1,2,3,4).filter(x->x%2==0).toList());\n    }\n}', 3),
(10, 15, 'Use map-reduce to sum list elements and print (Q15)', '6', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(java.util.stream.Stream.of(1,2,3).mapToInt(x->x).sum());\n    }\n}', 3),
(10, 16, 'Implement iterator removal while iterating a list (print placeholder) (Q16)', 'iterator remove', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"iterator remove\");\n    }\n}', 3),
(10, 17, 'Use ConcurrentHashMap basic put/get and print size (Q17)', '1', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        java.util.concurrent.ConcurrentHashMap<String,Integer> cm=new java.util.concurrent.ConcurrentHashMap<>(); cm.put(\"a\",1); System.out.println(cm.size());\n    }\n}', 3),
(10, 18, 'Use CopyOnWriteArrayList and show add behavior (print size) (Q18)', '[]', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(new java.util.concurrent.CopyOnWriteArrayList<Integer>());\n    }\n}', 3),
(10, 19, 'Use Stream collect to map list to set and print (Q19)', '{1, 2}', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(java.util.stream.Stream.of(1,2,2).collect(java.util.stream.Collectors.toSet()));\n    }\n}', 3),
(10, 20, 'Implement partitioning a list with streams and print sizes (simulate) (Q20)', 'partition sizes', 10, 120, 'medium', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"partition sizes\");\n    }\n}', 3),
(10, 21, 'Implement top-k elements using PriorityQueue and print top 2 (simulate) (Q21)', '[9,8]', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"[9,8]\");\n    }\n}', 5),
(10, 22, 'Use HashMap with custom key class (override equals/hashCode) - print placeholder (Q22)', 'custom key', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"custom key\");\n    }\n}', 5),
(10, 23, 'Implement multi-map using HashMap<K, List<V>> and print placeholder (Q23)', 'multimap', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"multimap\");\n    }\n}', 5),
(10, 24, 'Demonstrate parallel streams to process large list (print placeholder) (Q24)', 'parallel', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"parallel\");\n    }\n}', 5),
(10, 25, 'Use Collector to group by property and print placeholder (Q25)', 'grouped', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"grouped\");\n    }\n}', 5),
(10, 26, 'Implement Trie node insertion and search (print placeholder) (Q26)', 'trie', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"trie\");\n    }\n}', 5),
(10, 27, 'Use Guava-like Multiset behavior with Map (print placeholder) (Q27)', 'multiset', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"multiset\");\n    }\n}', 5),
(10, 28, 'Implement concurrent producer-consumer using BlockingQueue (print placeholder) (Q28)', 'producer-consumer', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"producer-consumer\");\n    }\n}', 5),
(10, 29, 'Design a simple in-memory index using HashMap and List (print placeholder) (Q29)', 'index', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"index\");\n    }\n}', 5),
(10, 30, 'Implement custom comparator for sorting complex objects (print placeholder) (Q30)', 'custom sort', 15, 180, 'hard', 'public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"custom sort\");\n    }\n}', 5);

-- --------------------------------------------------------

--
-- Table structure for table `snippets`
--

CREATE TABLE `snippets` (
  `language` varchar(20) NOT NULL,
  `code` varchar(3000) NOT NULL,
  `added_by` varchar(30) NOT NULL DEFAULT 'admin1',
  `code_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `snippets`
--

INSERT INTO `snippets` (`language`, `code`, `added_by`, `code_id`, `name`) VALUES
('Java', 'C:/Users/srusti/OneDrive/Desktop/project/snippets/hgdh.txt', 'admin', 1, ''),
('Java', 'C:/Users/srusti/OneDrive/Desktop/project/snippets/chapter 1.txt', 'SrusTea118', 2, 'chapter 1'),
('Java', 'nfebo', 'admin1', 3, '123'),
('Java', 'C:/Users/kano/IdeaProjects/main Project/snippets/123.txt', 'admin1', 4, '123'),
('Java', 'C:/Users/kano/IdeaProjects/main Project/snippets/123.txt', 'nishi', 5, '123'),
('Java', '// this is test file', 'sandip', 6, 'new2'),
('Java', 'C:/Users/kano/IdeaProjects/Final/snippets/new2.txt', 'sandip', 7, 'new2'),
('Java', 'C:/Users/kano/IdeaProjects/Final/snippets/new1.txt', 'sandip', 8, 'new1');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `user_name`, `email`, `password`, `created_at`) VALUES
(1, 'SrusTea', 'Srusti455@gmail.com', '123456789q', '2025-08-22 11:16:53'),
(2, 'srus', 'patelsrusti455@gmail.com', '123qweasdzxc', '2025-08-22 11:19:56'),
(3, 'Srus', 'admin@gmail.com', 'admin123456', '2025-08-22 11:54:40'),
(5, 'admin1', 'admin1@gmail.com', '123456', '2025-08-23 04:05:33'),
(6, 'sandip', 'admin2@gmail.com', 'sandip', '2025-08-23 07:08:08'),
(7, 'nishi', 'admin3@gmail.com', 'nishii', '2025-08-23 08:18:14'),
(8, 'srusti', 'srusti@gmail.com', '123456', '2025-08-23 09:37:20');

--
-- Triggers `user`
--
DELIMITER $$
CREATE TRIGGER `autoInsertUserData` BEFORE INSERT ON `user` FOR EACH ROW insert into user_data(user_name , user_mail) VALUES (NEW.user_name , NEW.email)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `validate_user_insert` BEFORE INSERT ON `user` FOR EACH ROW BEGIN
    -- Check password length (minimum 6 characters)
    IF CHAR_LENGTH(NEW.password) < 6 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Password must be at least 6 characters long.';
    END IF;

    -- Check if email contains @
    IF NEW.email NOT LIKE '%@%' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid email address. Must contain @ symbol.';
    END IF;

    -- Check for common email extensions
    IF NOT (
        NEW.email LIKE '%@gmail.com' OR
        NEW.email LIKE '%@yahoo.in' OR
        NEW.email LIKE '%@outlook.com' OR
        NEW.email LIKE '%@hotmail.com'
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid email domain. Use a common domain like @gmail.com, @yahoo.in, @outlook.com, @hotmail.com.';
    END IF;

    -- Check if username already exists
    IF EXISTS (SELECT 1 FROM user WHERE user_name = NEW.user_name) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Username already exists. Choose a different username.';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `user_data`
--

CREATE TABLE `user_data` (
  `user_name` varchar(50) NOT NULL,
  `user_mail` varchar(100) NOT NULL,
  `total_points` int(11) NOT NULL DEFAULT 0,
  `beginner_points` int(11) NOT NULL DEFAULT 0,
  `intermediate_points` int(11) NOT NULL DEFAULT 0,
  `expert_points` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_data`
--

INSERT INTO `user_data` (`user_name`, `user_mail`, `total_points`, `beginner_points`, `intermediate_points`, `expert_points`) VALUES
('admin1', 'admin1@gmail.com', 0, 0, 0, 0),
('dhruvii', 'admin@gmail.com', 15, 15, 0, 0),
('nishi', 'admin3@gmail.com', 15, 0, 0, 0),
('sandip', 'admin2@gmail.com', 25, 10, 0, 0),
('srusti', 'srusti@gmail.com', 0, 0, 0, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `chapterinfo`
--
ALTER TABLE `chapterinfo`
  ADD PRIMARY KEY (`chapterId`),
  ADD UNIQUE KEY `chapterName` (`chapterName`);

--
-- Indexes for table `chapter_index`
--
ALTER TABLE `chapter_index`
  ADD PRIMARY KEY (`chapter_id`);

--
-- Indexes for table `practicequestion`
--
ALTER TABLE `practicequestion`
  ADD PRIMARY KEY (`chapterId`,`questionId`);

--
-- Indexes for table `snippets`
--
ALTER TABLE `snippets`
  ADD PRIMARY KEY (`code_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `user_data`
--
ALTER TABLE `user_data`
  ADD PRIMARY KEY (`user_name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `chapterinfo`
--
ALTER TABLE `chapterinfo`
  MODIFY `chapterId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `chapter_index`
--
ALTER TABLE `chapter_index`
  MODIFY `chapter_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `snippets`
--
ALTER TABLE `snippets`
  MODIFY `code_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `practicequestion`
--
ALTER TABLE `practicequestion`
  ADD CONSTRAINT `practicequestion_ibfk_1` FOREIGN KEY (`chapterId`) REFERENCES `chapterinfo` (`chapterId`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
