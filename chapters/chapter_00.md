## Object-Oriented Programming in Harbour: A Comprehensive Manual

### Table of Contents

-----

### **Chapter 1: Introduction to Object-Oriented Programming (OOP)**

1.1 What is OOP?

1.2 Why OOP in Harbour?

1.3 Core Concepts of OOP:

1.3.1 Encapsulation

1.3.2 Inheritance

1.3.3 Polymorphism

1.3.4 Abstraction

1.4 A Brief History of OOP in xBase (Clipper, FoxPro, Harbour)

-----

### **Chapter 2: Classes and Objects in Harbour**

2.1 Defining a Class: Syntax and Structure

2.1.1 `CLASS ... ENDCLASS`

2.1.2 Declaring **Instance Variables (Properties)**: `DATA | VAR`

2.1.3 Declaring **Class Variables**: `STATIC VAR`

2.2 Creating **Objects (Instances)**: `ClassName():New()`

2.3 Accessing **Properties** and Calling **Methods**: `oObject:Property` and `oObject:Method()`

2.4 The **Constructor Method**: `:New()`

2.4.1 Purpose and Usage

2.4.2 Initializing Object State

2.5 The **Destructor Method** (Implicit in Harbour)

2.6 Code Examples: A Basic `CPerson` Class


-----

### **Chapter 3: Methods and Messages**

3.1 Defining **Methods**: `METHOD`

3.1.1 **Instance Methods**

3.2 **Message Passing**: Invoking Methods

3.3 The **`SELF`** Keyword: Referring to the Current Object

3.4 The **`SUPER`** Keyword: Calling Parent Class Methods

3.5 **Access Modifiers** (Visibility):

3.6 Code Examples: `CAccount` with Deposit and Withdraw Methods

-----

### **Chapter 4: Encapsulation: Protecting Data**

4.1 The Importance of Data Hiding

4.2 Using **Access Modifiers** for Properties:

4.3 **Getter and Setter Methods**: Controlled Access to Properties

4.3.1 `READONLY` and `WRITEONLY` Properties

4.4 Code Examples: Encapsulating `cProduct` details

-----

### **Chapter 5: Inheritance: Code Reusability**

5.1 Concepts of **Parent Class (Base Class)** and **Child Class (Derived Class)**

5.2 The `INHERIT` Clause

5.3 **Method Overriding**: Customizing Parent Behavior

5.4 Calling the **Parent Constructor**: `::SUPER:New()`

5.5 Multi-level Inheritance and Multiple Inheritance (Harbour's approach)

5.6 Code Examples: `CAnimal` as Base, `CDog` and `CCat` as Derived

-----

### **Chapter 6: Polymorphism: Many Forms**

6.1 Understanding Polymorphism

6.2 **Method Overloading** (Concept and Simulation in Harbour)

6.3 **Method Overriding** as a form of Polymorphism

6.4 **Duck Typing** in Harbour's Dynamic Nature

6.5 Code Examples: A Collection of `cAnimal` objects responding to `Speak()`

-----

### **Chapter 7: Abstraction and Interfaces**

7.1 **What is Abstraction?**

7.2 **Abstract Classes** (Simulated in Harbour)

-----
