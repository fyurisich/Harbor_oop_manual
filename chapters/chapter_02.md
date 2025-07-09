
# Chapter 2: Classes and Objects in Harbour

-----

Now that you've got a grasp of the core concepts of OOP, it's time to get your hands dirty with the fundamental building blocks: **classes** and **objects**. In Harbour, these are how you translate your real-world entities and their behaviors into executable code.

### 2.1 Defining a Class: Syntax and Structure

A **class** is essentially a blueprint or a template for creating objects. It defines the properties (data) and methods (behavior) that all objects of that class will possess. Think of it like the blueprint for a house: it specifies how many rooms, where the windows are, etc., but it's not the actual house itself.

In Harbour, you define a class using the `CLASS ... ENDCLASS` block.

#### 2.1.1 `CLASS ... ENDCLASS`

This is the most basic structure for defining a class. All class members (properties and methods) are declared within this block.

**Syntax:**

```harbour
CLASS ClassName
   // Properties (data that describes the object)
   // Methods (functions that the object can perform)
ENDCLASS
```

  * `ClassName`: This is the name you give to your class. By convention, class names typically start with an uppercase 'C' (e.g., `CPerson`, `CBook`, `CLoan`) to denote them as classes, but this is a convention, not a strict rule.
  
  So, to create a new class, use the command CLASS ... ENDCLASS:

[Harbour for beginners/Alexander Kresin](https://www.kresin.ru/en/hrbfaq_3.html#Doc3)
```harbour
  [CREATE] CLASS <cClassName> [ FROM | INHERIT <cSuperClass1> [, ... ,<cSuperClassN>] ]
                [ MODULE FRIENDLY ] [ STATIC ] [ FUNCTION <cFuncName> ]

      [HIDDEN:]
         [ CLASSDATA | CLASSVAR  | CLASS VAR <DataName1>]
         [ DATA | VAR  <DataName1> [,<DataNameN>] [ AS <type> ] [ INIT <uValue> ]
                [[EXPORTED | VISIBLE] | [PROTECTED] | [HIDDEN]] [READONLY | RO] ]
         ...
         [ METHOD <MethodName>( [<params,...>] ) [CONSTRUCTOR] ]
         [ METHOD <MethodName>( [<params,...>] ) INLINE <Code,...> ]
         [ METHOD <MethodName>( [<params,...>] ) BLOCK  <CodeBlock> ]
         [ METHOD <MethodName>( [<params,...>] ) EXTERN <funcName>([<args,...>]) ]
         [ METHOD <MethodName>( [<params,...>] ) SETGET ]
         [ METHOD <MethodName>( [<params,...>] ) VIRTUAL ]
         [ METHOD <MethodName>( [<params,...>] ) OPERATOR <op> ]
         [ ERROR HANDLER <MethodName>( [<params,...>] ) ]
         [ ON ERROR <MethodName>( [<params,...>] ) ]
         ...
      [PROTECTED:]
         ...
      [VISIBLE:]
      [EXPORTED:]
         ...

      [FRIEND CLASS <ClassName,...>]
      [FRIEND FUNCTION <FuncName,...>]

      [SYNC METHOD <cSyncMethod>]

      ENDCLASS [ LOCK | LOCKED ]
  ```

## 🧠 HARBOUR OOP CLASS SYNTAX EXPLAINED

---

## ✅ BASIC STRUCTURE

### `CREATE CLASS <cClassName>`

Defines a new class with the specified name.

**Example:**

```harbour
CREATE CLASS Person
```

---

### `FROM` or `INHERIT <cSuperClass1>, ...`

Defines **inheritance** from one or more parent classes (supports multiple inheritance). Use `FROM` or `INHERIT` interchangeably.

**Example:**

```harbour
CREATE CLASS Employee FROM Person
```

---

### `MODULE FRIENDLY`

Makes class **accessible only within the same source file (module)**. Useful for internal helpers.

**Example:**

```harbour
CREATE CLASS Logger MODULE FRIENDLY
```

---

### `STATIC`

Creates a class that **cannot be instantiated**. Often used for utility classes or namespaces.

**Example:**

```harbour
STATIC CLASS MathUtils
```

---

### `FUNCTION <cFuncName>`

Defines the function name used to create a new object instance of the class.

**Example:**

```harbour
CREATE CLASS Car FUNCTION NewCar
```

Usage:

```harbour
oCar := NewCar()
```

---

## 🔒 ACCESS SECTIONS

### `HIDDEN:`, `PROTECTED:`, `VISIBLE:`, `EXPORTED:`

These define **access control levels** for members.

* `HIDDEN:` - Accessible only within the class itself.
* `PROTECTED:` - Accessible within the class and its descendants.
* `VISIBLE:` or `EXPORTED:` - Accessible from outside (public).

**Example:**

```harbour
HIDDEN:
   VAR nSecret AS NUMERIC INIT 42

EXPORTED:
   VAR cName AS CHARACTER
```

---

## 📦 CLASS DATA & VARIABLES

### `CLASSDATA` or `CLASSVAR`

Creates a **shared static variable** across all instances of the class.

**Example:**

```harbour
CLASSDATA nCounter INIT 0
```

---

### `DATA` or `VAR <Name> [,<NameN>]`

Defines an **instance variable** (property).

* `AS <type>`: Type hint (informative only).
* `INIT <value>`: Default initial value.
* Visibility: `EXPORTED`, `PROTECTED`, `HIDDEN`
* `READONLY` or `RO`: Prevents modification

**Example:**

```harbour
VAR cName AS CHARACTER INIT "Unknown" EXPORTED
VAR nAge AS NUMERIC INIT 0 PROTECTED
```

---

## 🧱 METHODS

### `METHOD <MethodName>([<params>])`

Defines a class **method** (function associated with an object).

**Example:**

```harbour
METHOD SayHello()
```

---

### `METHOD ... CONSTRUCTOR`

Marks a method as the **constructor**, called automatically when the object is created.

**Example:**

```harbour
METHOD Init( cName ) CONSTRUCTOR
```

---

### `METHOD ... INLINE`

Defines the method with **inline code**, useful for one-liners.

**Example:**

```harbour
METHOD GetName() INLINE ::cName
```

---

### `METHOD ... BLOCK`

Defines the method with a **code block** instead of a traditional body.

**Example:**

```harbour
METHOD DoubleAge() BLOCK { || ::nAge * 2 }
```

---

### `METHOD ... EXTERN <funcName>([<args>])`

Binds the method to an **external function**.

**Example:**

```harbour
METHOD CalculateSalary() EXTERN CalculateSalaryFunc()
```

---

### `METHOD ... SETGET`

Automatically generates **setter/getter** methods for a property.

**Example:**

```harbour
VAR cName EXPORTED
METHOD cName() SETGET
```

Usage:

```harbour
oPerson:cName( "John" ) // Setter
? oPerson:cName()       // Getter
```

---

### `METHOD ... VIRTUAL`

Declares a **virtual method**, allowing it to be **overridden** in derived classes.

**Example:**

```harbour
METHOD Speak() VIRTUAL
```

---

### `METHOD ... OPERATOR <op>`

Overloads an **operator** (like `+`, `==`).

**Example:**

```harbour
METHOD Operator== ( oOther ) INLINE ::cName == oOther:cName
```

---

## ⚠️ ERROR HANDLING

### `ERROR HANDLER <MethodName>( [<params>] )`

Defines a **custom error handler** for method calls.

**Example:**

```harbour
ERROR HANDLER OnError()
```

---

### `ON ERROR <MethodName>( [<params>] )`

Alternative syntax for error handling (similar purpose).

**Example:**

```harbour
ON ERROR HandleClassError()
```

---

## 👥 FRIEND ACCESS

### `FRIEND CLASS <ClassName,...>`

Grants another class **access to private/protected members**.

**Example:**

```harbour
FRIEND CLASS PayrollProcessor
```

---

### `FRIEND FUNCTION <FuncName,...>`

Grants a function **friend access** to the class.

**Example:**

```harbour
FRIEND FUNCTION ExportToCSV
```

---

## 🔄 SYNC

### `SYNC METHOD <cSyncMethod>`

Used in **thread-safe environments** (MiniGUI, multithreading) to define synchronization methods.

**Example:**

```harbour
SYNC METHOD LockData
```

---

## 🔐 END OF CLASS

### `ENDCLASS [LOCK | LOCKED]`

Closes the class definition.

* `LOCK`: Marks the class as immutable (prevents modification at runtime).

**Example:**

```harbour
ENDCLASS LOCK
```
---

#### 2.1.2 Declaring **Instance Variables (Properties)**: ` DATA | VAR`

**Instance variables**, more commonly called **properties** in OOP, are the data fields that hold the state of an object. Each object created from the class will have its own independent copy of these properties. They define the "what it knows" about itself.

In Harbour, you declare instance variables using the **` DATA | VAR`** keyword within the `CLASS` block. By default, `VAR` properties are **public**, meaning they can be accessed and modified directly from outside the object. While convenient for quick access, for better **encapsulation** (which we'll cover in Chapter 4), you'll often use getter and setter methods to control access to these properties.

**Syntax:**

```harbour
CLASS ClassName
   VAR PropertyName1               // Basic declaration
   VAR PropertyName2 AS DataType   // Declaration with optional type hinting
   // ... more properties
ENDCLASS
```

  * `PropertyName1`, `PropertyName2`: These are the names of your properties. Good practice suggests descriptive names, often starting with a lowercase letter or a prefix indicating type (e.g., `cName` for character, `nAge` for numeric, `lActive` for logical).
  * `AS DataType`: Harbour is a dynamically typed language, meaning you don't strictly need to declare data types for variables. However, adding `AS` followed by a data type (e.g., `CHARACTER`, `NUMERIC`, `LOGICAL`, `DATE`, `ARRAY`, `OBJECT`, `BLOCK`) is highly recommended. It serves as **type hinting**, significantly improving code readability, acting as documentation, and helping tools with analysis.

**How it Works:**

When an object is created, memory is allocated for its instance variables. Each object gets its unique set of these variables. Changes to `oPerson1:cName` won't affect `oPerson2:cName`, even if both are instances of `CPerson`.

### 2.2 Creating **Objects (Instances)**: `ClassName():New()`

An **object** is a concrete realization or an instance of a class. While a class is the blueprint, an object is the actual house built from that blueprint. Objects are where the data (properties) actually live and where methods are executed.

In Harbour, you create a new object instance by calling the class's **constructor method**, which is typically named **`:New()`**.

**Syntax:**

```harbour
LOCAL oObject
oObject := ClassName():New()
```

  * `oObject`: This is a variable that will hold a reference to your newly created object. You should declare it with `LOCAL`.
  * `ClassName()`: This is the name of the class you want to instantiate. The empty parentheses are crucial; they indicate a function call, which in this context, is the constructor.
  * `:New()`: This explicitly calls the constructor method defined within your class. As you'll see next, this method is where you initialize the object's state.

When `ClassName():New()` is executed:

1.  Harbour allocates memory for the new object.
2.  The `:New()` method of the class is executed.
3.  A reference to the newly created object is returned and assigned to your variable (`oObject`).

### 2.3 Accessing **Properties** and Calling **Methods**: `oObject:Property` and `oObject:Method()`

Once you have an object, you interact with it using the **colon (`:`) operator**. This operator is used to access properties or call methods of an object.

**Accessing Properties:**

```harbour
oObject:PropertyName
```

  * To read a property's value: `QOut( oPerson:cName )`
  * To set a property's value: `oPerson:cName := "John Doe"`

**Calling Methods:**

```harbour
oObject:MethodName( [param1, param2, ...] )
```

  * To execute a method: `oPerson:DisplayInfo()`
  * To execute a method with parameters: `oAccount:Deposit( 100.00 )`

### 2.4 The **Constructor Method**: `:New()`

The **constructor** is a special method that is automatically invoked when a new object is created (`ClassName():New()`). Its primary purpose is to initialize the object's properties to a valid starting state. This prevents objects from being in an undefined or invalid condition immediately after creation.

#### 2.4.1 Purpose and Usage

  * **Initialization:** Set initial values for instance variables.
  * **Resource Allocation:** Open files, establish database connections, or perform any setup required by the object.
  * **Parameter Acceptance:** Constructors can accept parameters to customize the initial state of the object.

#### 2.4.2 Initializing Object State

Inside the `:New()` method, you typically assign default values or values passed as parameters to the object's properties. You refer to the current object's properties and methods using the **`::` operator** (sometimes called the "self-reference" or "scope resolution" operator).

**Example of a Constructor:**

```harbour
CLASS CPerson
   VAR cName    AS CHARACTER
   VAR nAge     AS NUMERIC
   VAR dDOB     AS DATE
   
   /* --- Constructor --- */
   METHOD New( cNameParam, nAgeParam, dDOBParam )

ENDCLASS

METHOD New( cNameParam, nAgeParam, dDOBParam )
      // Initialize instance variables using :: operator
      ::cName := If( ValType( cNameParam ) == 'C', cNameParam, "" )

      ::nAge  := If( ValType( nAgeParam )  == 'N', nAgeParam, 0  )

      ::dDOB  := If( ValType( dDOBParam )  == 'D', dDOBParam, CToD("") )

      // The constructor should always return SELF
RETURN SELF
```

Now, you could create objects like this:

```harbour
LOCAL oPerson1 := CPerson():New( "Alice", 30, CTOD("07/15/1999") )
LOCAL oPerson2 := CPerson():New() // Using default empty values
```

### 2.5 The **Destructor Method** (Implicit in Harbour)

Unlike some other OOP languages (like C++), Harbour does **not** have an explicit destructor method that you define in your class (e.g., `CLASS_DESTROY` or similar). Harbour uses **automatic garbage collection** to manage memory.

When an object is no longer referenced by any part of your program, Harbour's garbage collector will automatically reclaim the memory occupied by that object. You generally don't need to worry about manually releasing object memory.

However, if your object holds **external resources** (like open file handles, database connections, or GUI controls that need explicit release), you would typically implement a specific **`Close()`** or **`Release()`** method that you manually call when you're done with the object, rather than relying solely on garbage collection for resource cleanup.

### 2.6 Code Examples: A Basic `CPerson` Class

Let's put together what we've learned with a more complete `CPerson` example.

```harbour
// File: person.prg
// Purpose: Demonstrates a complete Person class implementation in Harbour OOP
// Concepts: Encapsulation, Getters/Setters, Object Construction

#include "hbclass.ch"  // Required for OOP functionality in Harbour

/*
* Class: TPerson
* Description: Models a person with basic attributes and access methods
* Design Pattern: Follows the classic encapsulation pattern with:
*   - Private data (through DATA declarations)
*   - Public interface (through methods)
*/
CREATE CLASS TPerson

   /* --- Instance Variables (Attributes) --- */
   DATA cName       INIT ""     // String: Stores the person's full name
   DATA nAge        INIT 0      // Numeric: Stores age in years
   DATA dBirthDate  INIT CTOD("") // Date: Birth date (empty date initialized)
   DATA lActive     INIT .F.    // Logical: Activation status flag

   /* --- Constructor --- */
   METHOD New( cName, nAge, dBirthDate, lActive )  // Parameterized constructor

   /* --- Accessor Methods (Getters) --- */
   METHOD GetName()        // Returns name
   METHOD GetAge()         // Returns age
   METHOD GetBirthDate()   // Returns birth date
   METHOD IsActive()       // Returns active status (proper boolean naming)

   /* --- Mutator Methods (Setters) --- */
   METHOD SetName( cName )         // Updates name
   METHOD SetAge( nAge )           // Updates age
   METHOD SetBirthDate( dBirthDate ) // Updates birth date
   METHOD SetActive( lActive )     // Updates active status

ENDCLASS

/*
* Method: New (Constructor)
* Class: TPerson
* Parameters:
*   cName - String - Person's name
*   nAge - Numeric - Age in years
*   dBirthDate - Date - Birth date
*   lActive - Logical - Active status
* Returns: Self reference (standard Harbour OOP practice)
* Note: Implements complete initialization in one call
*/
METHOD New( cName, nAge, dBirthDate, lActive ) CLASS TPerson
   ::cName      := cName       // Assign name
   ::nAge       := nAge        // Assign age
   ::dBirthDate := dBirthDate  // Assign birth date
   ::lActive    := lActive     // Set active status
   RETURN Self                 // Enable method chaining

/* --- Getter Methods --- */

/*
* Method: GetName
* Returns: String - The person's name
* Note: Simple accessor with no side effects
*/
METHOD GetName() CLASS TPerson
   RETURN ::cName

/*
* Method: GetAge
* Returns: Numeric - The person's age
*/
METHOD GetAge() CLASS TPerson
   RETURN ::nAge

/*
* Method: GetBirthDate
* Returns: Date - Birth date in date format
* Note: Uses Harbour's native date type
*/
METHOD GetBirthDate() CLASS TPerson
   RETURN ::dBirthDate

/*
* Method: IsActive
* Returns: Logical - Active status
* Note: Follows boolean naming convention (IsXxx)
*/
METHOD IsActive() CLASS TPerson
   RETURN ::lActive

/* --- Setter Methods --- */

/*
* Method: SetName
* Parameters: cName - String - New name value
* Returns: NIL (standard for setters in Harbour)
* Note: No validation shown (would be added in real application)
*/
METHOD SetName( cName ) CLASS TPerson
   ::cName := cName
   RETURN NIL

/*
* Method: SetAge
* Parameters: nAge - Numeric - New age value
* Note: Real implementation would validate (0-150 range etc.)
*/
METHOD SetAge( nAge ) CLASS TPerson
   ::nAge := nAge
   RETURN NIL

/*
* Method: SetBirthDate
* Parameters: dBirthDate - Date - New birth date
* Note: Would normally validate date is in reasonable range
*/
METHOD SetBirthDate( dBirthDate ) CLASS TPerson
   ::dBirthDate := dBirthDate
   RETURN NIL

/*
* Method: SetActive
* Parameters: lActive - Logical - New active status
* Note: Direct assignment, could add business logic
*/
METHOD SetActive( lActive ) CLASS TPerson
   ::lActive := lActive
   RETURN NIL

// --- Demonstration Code ---
/*
* Procedure: Main
* Purpose: Demonstrates TPerson class usage
* Shows:
*   1. Object creation with New()
*   2. Getter method usage
*   3. Basic console output
*/
PROCEDURE Main()
   LOCAL oPerson1, oPerson2  // Declare object references

   SET CENTURY ON  // Ensure proper date display format

   // Create two person instances with different data
   oPerson1 := TPerson():New( "John Smith", 30, CTOD("01/01/1995"), .T. )
   oPerson2 := TPerson():New( "Alice Doe", 25, CTOD("07/15/1999"), .F. )

   // Display first person's data using getters
   ? "Person #1"
   ? "Name:", oPerson1:GetName()          // Get name
   ? "Person's age: ", oPerson1:GetAge()  // Get age
   ? "Date of birth: ", oPerson1:GetBirthDate() // Get birth date
   ? "Is Active:", oPerson1:IsActive()    // Check active status

   // Display second person's data
   ? ""
   ? "Person #2"
   ? "Name:", oPerson2:GetName()
   ? "Person's age: ", oPerson2:GetAge()
   ? "Date of birth: ", oPerson2:GetBirthDate()
   ? "Is Active:", oPerson2:IsActive()
   ? ""

   inkey(0)  // Wait for keypress before exiting

RETURN
```

**Explanation of the Code Example:**
---

### 🔷 **Overview**

The code defines a **class called `TPerson`** in Harbour, which models a basic "person" with attributes like name, age, birthdate, and active status.

---

### 🔸 **1. CLASS Definition**

```harbour
CLASS TPerson
```

This begins the definition of the `TPerson` class.

---

### 🔸 **2. Instance Attributes**

```harbour
DATA cName       INIT ""
DATA nAge        INIT 0
DATA dBirthDate  INIT CTOD("")
DATA lActive     INIT .F.
```

Each `TPerson` object has four properties:

* `cName`: the name of the person (string)
* `nAge`: the person's age (numeric)
* `dBirthDate`: date of birth (date type)
* `lActive`: whether the person is active or not (logical/boolean)

`INIT` sets the **default value** for each attribute.

---
### 🔸 **3. Constructor Method**

```harbour
METHOD New( cName, nAge, dBirthDate, lActive )
```

The `New()` method is the **constructor**, used to initialize a new object.

Inside the method:

```harbour
   ::cName      := cName
   ::nAge       := nAge
   ::dBirthDate := dBirthDate
   ::lActive    := lActive
```
---

### 🔸 **4. Getter Methods**

These return the value of an attribute:

```harbour
METHOD GetName()       → returns ::cName
METHOD GetAge()        → returns ::nAge
METHOD GetBirthDate()  → returns ::dBirthDate
METHOD IsActive()      → returns ::lActive
```

---

### 🔸 **5. Setter Methods**

These assign new values to the object's attributes:

```harbour
METHOD SetName( cName )         → ::cName := cName
METHOD SetAge( nAge )           → ::nAge := nAge
METHOD SetBirthDate( dBirthDate ) → ::dBirthDate := dBirthDate
METHOD SetActive( lActive )     → ::lActive := lActive
```

Each setter updates the internal value of the attribute.

---
### 🔸 **6. Example Usage (`Main()` procedure)**

```harbour
PROCEDURE Main()
   LOCAL oPerson1, oPerson2

   oPerson1 := TPerson():New( "John Smith", 30, CTOD("01/01/1995"), .T. )
   oPerson2 := TPerson():New( "Alice Doe", 25, CTOD("07/15/1999"), .F. )

   ? "Person #1"
   ? "Name:", oPerson1:GetName()
   ? "Person's age: ", oPerson1:GetAge()
   ? "Date of birth: ", oPerson1:GetBirthDate()
   ? "Is Active:", oPerson1:IsActive()

   ? ""
   ? "Person #2"
   ? "Name:", oPerson2:GetName()
   ? "Person's age: ", oPerson2:GetAge()
   ? "Date of birth: ", oPerson2:GetBirthDate()
   ? "Is Active:", oPerson2:IsActive()
   ? ""

   RETURN
```

* Creates two `TPerson` objects.
* Shows the name and active status of the first person.
* Shows the name and active status of the second person.

---

### ✅ Summary

| Component             | Purpose                                      |
| --------------------- | -------------------------------------------- |
| `cName`, `nAge`, etc. | Instance variables to hold data              |
| `New()`               | Initializes a new person and increases count |
| Getters/Setters       | Access and modify object properties          |

---
