---

# **The Sequelizer**

The Sequelizer is a robust, developer-centric tool that translates Spring Data JPA queries into SQL statements. By providing accurate and efficient query conversion, it bridges the gap between the abstraction of JPA and the specificity of SQL, making debugging and query optimization seamless.

---

## **Features**

- **Accurate Query Translation**  
  Converts Spring Data JPA queries to their SQL equivalents with high precision.  

- **Support for Complex Scenarios**  
  Handles joins, nested queries, and advanced JPA constructs effortlessly.  

- **Powered by Lex and Yacc**  
  Built with industry-standard tools for robust lexical analysis and parsing.  

- **Platform Flexibility**  
  Works seamlessly on Linux and Windows (via WSL).  

---

## **Getting Started**

### **Prerequisites**

Before using The Sequelizer, ensure the following are installed on your system:  
- A C/C++ compiler (e.g., GCC).  
- `flex` (Lex implementation).  
- `bison` (Yacc implementation).  

#### Install Required Tools
For Ubuntu-based systems, run:
```bash
sudo apt update
sudo apt install flex bison build-essential
```

### **Installation**

Clone the repository and navigate to the project directory:
```bash
git clone https://github.com/OmkarLolage21/The-Sequelizer.git
cd The-Sequelizer
```

---

## **Usage**

### **Building the Project**
To compile the project:
```bash
make
```
This command generates the `sequelizer` executable.

### **Running The Sequelizer**
1. **Prepare Input**  
   Write your JPA queries in a text file, e.g., `input.jpa`.

2. **Execute the Tool**  
   Convert JPA queries to SQL by running:
   ```bash
   ./sequelizer < input.jpa > output.sql
   ```
   The SQL queries will be written to `output.sql`.

### **Example**

**Input (`input.jpa`)**:
```jpa
findBy id (id = 2)
```

**Output (`output.sql`)**:
```sql
SELECT * FROM table WHERE id = 2
```

---

## **Development**

### **Project Structure**

- **`lexer.l`**: Tokenizes JPA queries using Lex.  
- **`parser.y`**: Implements grammar rules and query translation logic using Yacc. 

### **Build Commands**
- **Compile the Project**:
  ```bash
  flex lexer.l
  bison -d parser.y
  gcc -o sequelizer lex.yy.c parser.tab.c -lfl
  ```
- **Clean Generated Files**:
  ```bash
  make clean
  ```

---

## **Contributing**

We welcome contributions to The Sequelizer! Whether it's reporting bugs, suggesting new features, or submitting pull requests, your input helps improve the tool.

### **How to Contribute**
1. Fork the repository.  
2. Create a new branch:  
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes:  
   ```bash
   git commit -m "Add feature description"
   ```
4. Push to your branch:  
   ```bash
   git push origin feature-name
   ```
5. Submit a pull request on GitHub.

---

## **License**

This project is licensed under the [MIT License](LICENSE). Feel free to use, modify, and distribute it as per the license terms.

---
