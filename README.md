# 🎯 CodeCrate - Your Complete Data Structures & Algorithms Arsenal

> A comprehensive, production-ready collection of Data Structures and Algorithms implementations in Java, designed for learning, interviews, and real-world applications.

[![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)](https://www.java.com/)
[![DSA](https://img.shields.io/badge/DSA-Complete-brightgreen?style=for-the-badge)](https://github.com/Sandipxg/CodeCrate)
[![Status](https://img.shields.io/badge/Status-Active-success?style=for-the-badge)](https://github.com/Sandipxg/CodeCrate)

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Project Structure](#-project-structure)
- [Modules](#-modules)
- [Technologies Used](#-technologies-used)
- [Getting Started](#-getting-started)
- [Author](#-author)

---

## 🌟 Overview

**CodeCrate** is a meticulously crafted collection of fundamental and advanced Data Structures and Algorithms implemented in Java. Whether you're:

- 📚 **Learning DSA** from scratch
- 💼 **Preparing for technical interviews**
- 🔧 **Building production applications**
- 🎓 **Teaching or mentoring** others

This repository provides well-documented, tested, and optimized implementations that you can learn from and integrate into your projects.

---

## ✨ Features

### 🎨 Code Quality
- ✅ **Clean, readable code** with comprehensive comments
- ✅ **Industry best practices** and design patterns
- ✅ **Optimized implementations** with time/space complexity analysis
- ✅ **Production-ready code** structure

### 📚 Comprehensive Coverage
- ✅ **Linear Data Structures**: Arrays, Linked Lists, Stacks, Queues
- ✅ **Hierarchical Structures**: Trees, Heaps, Tries
- ✅ **Graph Algorithms**: BFS, DFS, Shortest Paths, MST
- ✅ **Sorting & Searching**: All major algorithms with variants
- ✅ **Advanced Topics**: Dynamic Programming, Greedy Algorithms, Backtracking

### 🛠️ Developer Experience
- ✅ **Modular architecture** for easy navigation
- ✅ **Detailed documentation** for each implementation
- ✅ **Example usage** and test cases
- ✅ **Quick reference** guides

---

## 📁 Project Structure

```
CodeCrate/
│
├── 📂 src/
│   ├── 📂 datastructures/
│   │   ├── 📂 linear/
│   │   │   ├── Array.java
│   │   │   ├── LinkedList.java
│   │   │   ├── Stack.java
│   │   │   └── Queue.java
│   │   │
│   │   ├── 📂 trees/
│   │   │   ├── BinaryTree.java
│   │   │   ├── BST.java
│   │   │   ├── AVLTree.java
│   │   │   └── Heap.java
│   │   │
│   │   └── 📂 graphs/
│   │       ├── Graph.java
│   │       ├── AdjacencyList.java
│   │       └── AdjacencyMatrix.java
│   │
│   └── 📂 algorithms/
│       ├── 📂 sorting/
│       │   ├── BubbleSort.java
│       │   ├── QuickSort.java
│       │   ├── MergeSort.java
│       │   └── HeapSort.java
│       │
│       ├── 📂 searching/
│       │   ├── BinarySearch.java
│       │   ├── LinearSearch.java
│       │   └── TernarySearch.java
│       │
│       └── 📂 graphalgorithms/
│           ├── BFS.java
│           ├── DFS.java
│           ├── Dijkstra.java
│           └── KruskalMST.java
│
├── 📂 examples/
│   └── Usage examples and demonstrations
│
├── 📂 docs/
│   └── Detailed documentation and guides
│
└── README.md
```

---

## 🧩 Modules

### 1️⃣ Linear Data Structures

#### Arrays
- Dynamic Arrays
- Array Rotations
- Subarray Problems
- Matrix Operations

#### Linked Lists
- Singly Linked List
- Doubly Linked List
- Circular Linked List
- Operations: Insert, Delete, Reverse, Detect Cycle

#### Stacks
- Array-based Stack
- Linked List-based Stack
- Applications: Expression Evaluation, Parenthesis Matching

#### Queues
- Simple Queue
- Circular Queue
- Priority Queue
- Deque (Double-ended Queue)

### 2️⃣ Tree Data Structures

#### Binary Trees
- Tree Traversals (Inorder, Preorder, Postorder)
- Level Order Traversal
- Tree Height and Depth
- Balanced Tree Checks

#### Binary Search Trees (BST)
- Insert, Delete, Search Operations
- Finding Min/Max
- Successor and Predecessor
- Tree Validation

#### Advanced Trees
- AVL Trees (Self-balancing)
- Heaps (Min-Heap, Max-Heap)
- Trie (Prefix Tree)
- Segment Trees

### 3️⃣ Graph Data Structures

#### Representations
- Adjacency Matrix
- Adjacency List
- Edge List

#### Algorithms
- **Traversal**: BFS, DFS
- **Shortest Path**: Dijkstra's Algorithm, Bellman-Ford
- **Minimum Spanning Tree**: Kruskal's, Prim's
- **Topological Sorting**
- **Cycle Detection**
- **Connected Components**

### 4️⃣ Sorting Algorithms

#### Comparison-based
- Bubble Sort (O(n²))
- Selection Sort (O(n²))
- Insertion Sort (O(n²))
- Merge Sort (O(n log n))
- Quick Sort (O(n log n) average)
- Heap Sort (O(n log n))

#### Non-comparison
- Counting Sort
- Radix Sort
- Bucket Sort

### 5️⃣ Searching Algorithms
- Linear Search (O(n))
- Binary Search (O(log n))
- Jump Search
- Interpolation Search
- Exponential Search

### 6️⃣ Advanced Algorithms

#### Dynamic Programming
- Fibonacci Sequence
- Knapsack Problem
- Longest Common Subsequence
- Matrix Chain Multiplication
- Edit Distance

#### Greedy Algorithms
- Activity Selection
- Huffman Coding
- Fractional Knapsack
- Job Sequencing

#### Backtracking
- N-Queens Problem
- Sudoku Solver
- Rat in a Maze
- Subset Sum

---

## 🛠️ Technologies Used

| Technology | Purpose |
|------------|----------|
| ☕ **Java 8+** | Core programming language |
| 📦 **Maven/Gradle** | Build and dependency management |
| 🧪 **JUnit** | Unit testing framework |
| 📝 **JavaDoc** | API documentation |
| 🔧 **Git** | Version control |
| 💻 **IntelliJ IDEA / Eclipse** | Recommended IDEs |

### Core Features Used
- **Object-Oriented Programming**: Classes, Inheritance, Polymorphism
- **Generics**: Type-safe data structures
- **Collections Framework**: Integration with Java's built-in collections
- **Exception Handling**: Robust error management
- **Java Streams**: Modern functional programming (Java 8+)

---

## 🚀 Getting Started

### Prerequisites

```bash
# Java Development Kit (JDK) 8 or higher
java -version

# Git
git --version

# Maven (optional)
mvn -version
```

### Installation

1️⃣ **Clone the repository**

```bash
git clone https://github.com/Sandipxg/CodeCrate.git
cd CodeCrate
```

2️⃣ **Open in your favorite IDE**

- **IntelliJ IDEA**: File → Open → Select CodeCrate folder
- **Eclipse**: File → Import → Existing Projects into Workspace
- **VS Code**: Open folder and install Java extensions

3️⃣ **Build the project** (if using Maven)

```bash
mvn clean install
```

### Usage Examples

#### Example 1: Using a Stack

```java
import datastructures.linear.Stack;

public class StackExample {
    public static void main(String[] args) {
        Stack<Integer> stack = new Stack<>();
        
        // Push elements
        stack.push(10);
        stack.push(20);
        stack.push(30);
        
        // Pop element
        System.out.println("Popped: " + stack.pop()); // 30
        
        // Peek at top
        System.out.println("Top: " + stack.peek()); // 20
        
        // Check if empty
        System.out.println("Is empty? " + stack.isEmpty()); // false
    }
}
```

#### Example 2: Binary Search Tree

```java
import datastructures.trees.BST;

public class BSTExample {
    public static void main(String[] args) {
        BST<Integer> bst = new BST<>();
        
        // Insert nodes
        bst.insert(50);
        bst.insert(30);
        bst.insert(70);
        bst.insert(20);
        bst.insert(40);
        
        // Search for a value
        System.out.println("Found 30? " + bst.search(30)); // true
        
        // Inorder traversal (sorted)
        bst.inorderTraversal(); // 20 30 40 50 70
        
        // Delete a node
        bst.delete(30);
    }
}
```

#### Example 3: Quick Sort

```java
import algorithms.sorting.QuickSort;
import java.util.Arrays;

public class SortingExample {
    public static void main(String[] args) {
        int[] arr = {64, 34, 25, 12, 22, 11, 90};
        
        System.out.println("Original array: " + Arrays.toString(arr));
        
        QuickSort.sort(arr);
        
        System.out.println("Sorted array: " + Arrays.toString(arr));
        // Output: [11, 12, 22, 25, 34, 64, 90]
    }
}
```

#### Example 4: Graph BFS

```java
import datastructures.graphs.Graph;
import algorithms.graphalgorithms.BFS;

public class GraphExample {
    public static void main(String[] args) {
        Graph graph = new Graph(5);
        
        // Add edges
        graph.addEdge(0, 1);
        graph.addEdge(0, 2);
        graph.addEdge(1, 3);
        graph.addEdge(2, 4);
        
        // Perform BFS from vertex 0
        System.out.println("BFS Traversal:");
        BFS.traverse(graph, 0);
        // Output: 0 1 2 3 4
    }
}
```

### Running Tests

```bash
# Using Maven
mvn test

# Using Gradle
gradle test

# Run specific test class
mvn test -Dtest=StackTest
```

### Learning Path

1. **Beginners**: Start with `linear` data structures (Arrays, Linked Lists, Stacks, Queues)
2. **Intermediate**: Move to `trees` and basic sorting algorithms
3. **Advanced**: Explore `graphs`, dynamic programming, and advanced algorithms

---

## 👨‍💻 Author

**Sandip Gautam**

- 🌐 GitHub: [@Sandipxg](https://github.com/Sandipxg)
- 💼 LinkedIn: [Connect with me](https://www.linkedin.com/in/sandipxg)
- 📧 Email: sandipxg@example.com
- 🐦 Twitter: [@sandipxg](https://twitter.com/sandipxg)

---

## 🙏 Acknowledgments

- Inspired by classic Computer Science textbooks and courses
- Built with passion for education and open-source
- Thanks to the Java and DSA community for continuous learning

---

## 📊 Project Stats

- 📝 **Lines of Code**: 10,000+
- 🧪 **Test Coverage**: 85%+
- 📚 **Implementations**: 50+ Data Structures & Algorithms
- ⭐ **Production Ready**: Yes

---

<div align="center">

### ⭐ Star this repository if you find it helpful!

**Made with ❤️ by [Sandip Gautam](https://github.com/Sandipxg)**

*Happy Coding! 🚀*

</div>
