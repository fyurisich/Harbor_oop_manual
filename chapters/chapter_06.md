
## Chapter 6: Polymorphism: Many Forms

-----

Welcome to Chapter 6, where we explore **Polymorphism**, arguably one of the most elegant and powerful concepts in Object-Oriented Programming. While **inheritance** allows you to define "is-a" relationships and reuse code, **polymorphism** lets you interact with objects in a more general way, even if they are of different specific types. The word "polymorphism" comes from Greek, meaning "many forms."

In essence, polymorphism means that objects of different classes can be treated as objects of a common type (usually their parent class), and a single message (method call) can produce different, type-specific behaviors.

### 6.1 Understanding Polymorphism

To truly grasp polymorphism, let's revisit our `CAnimal`, `CDog`, and `CCat` example from Chapter 5.

  * `CAnimal` has a `Speak()` method that outputs "Generic animal sound."
  * `CDog` **overrides** `Speak()` to output "Woof\! Woof\!"
  * `CCat` **overrides** `Speak()` to output "Meow."

Now, imagine you have a list of various animals: some dogs, some cats, and maybe a generic animal. Without polymorphism, you'd have to write conditional code to figure out each object's exact type and then call the appropriate method:

```harbour
// Procedural (non-polymorphic) way - BAD PRACTICE!
LOCAL aAnimals := {}
AAdd( aAnimals, cDog():New( "Buddy", 5, .T. ) )
AAdd( aAnimals, cCat():New( "Whiskers", 3, .T. ) )
AAdd( aAnimals, cAnimal():New( "Bird", "Tweety", 2 ) )

FOR EACH oAnimal IN aAnimals
   IF IsInstanceOf( oAnimal, "cDog" )
      oAnimal:Speak() // Call cDog's Speak
   ELSEIF IsInstanceOf( oAnimal, "cCat" )
      oAnimal:Speak() // Call cCat's Speak
   ELSEIF IsInstanceOf( oAnimal, "cAnimal" )
      oAnimal:Speak() // Call cAnimal's Speak
   ENDIF
NEXT
```

This code is cumbersome and fragile. If you add a `cHorse` class, you have to modify this `FOR EACH` loop.

With polymorphism, you simply treat all these objects as their common parent type (`cAnimal`) and send the `Speak()` message. Each object, at runtime, knows how to respond to that message in its own specific way.

```harbour
// Polymorphic way - GOOD PRACTICE!
LOCAL aAnimals := {}
AAdd( aAnimals, cDog():New( "Buddy", 5, .T. ) )
AAdd( aAnimals, cCat():New( "Whiskers", 3, .T. ) )
AAdd( aAnimals, cAnimal():New( "Bird", "Tweety", 2 ) )

FOR EACH oAnimal IN aAnimals
   // Each object knows how to respond to 'Speak()'
   oAnimal:Speak()
NEXT
// Output:
// Buddy says Woof! Woof!
// Whiskers says Meow.
// Generic animal sound.
```

This exemplifies polymorphism: a single method call (`oAnimal:Speak()`) invokes different implementations based on the actual type of the object at runtime. This makes your code much cleaner, more extensible, and easier to maintain.

### 6.2 **Method Overloading** (Concept and Simulation in Harbour)

**Method overloading** typically refers to the ability to define multiple methods within the same class that have the **same name** but **different parameters** (e.g., different number of parameters or different data types of parameters). The compiler then decides which version to call based on the arguments provided.

  * **Harbour's Approach:** Harbour, being a dynamically typed language, **does not support true method overloading** in the same way statically typed languages like Java or C\# do. In Harbour, if you define two methods with the same name in the same class, the *last one defined* will effectively overwrite any previous ones.

However, you can **simulate** method overloading by making your methods flexible with parameters:

  * **Optional Parameters:** Use `HB_PCOUNT()` to check how many parameters were passed.
  * **Parameter Type Checking:** Use `ValType()` to check the type of passed parameters.

**Example of Simulated Overloading:**

```harbour
#include "hbclass.ch"

CLASS CCalculator
   METHOD Add( x, y )
ENDCLASS

METHOD Add( x, y ) CLASS CCalculator

      LOCAL nResult := 0

      IF PCount() == 1 .AND. ValType(x) == "N" // Assuming single parameter for increment
         nResult := x + 1
         QOut( "Incrementing: " + LTrim( Str( x ) ) + " to " + LTrim( Str( nResult ) ) )
      ELSEIF PCount() == 2 .AND. ValType( x ) == 'N' .AND. ValType( y ) == 'N'
         nResult := x + y
         QOut( "Adding: " + LTrim( Str( x ) ) + " + " + LTrim( Str( y ) ) + " = " + LTrim( Str( nResult ) ) )
      ELSE
         QOut( "Error: Invalid parameters for Add method." )
      ENDIF

RETURN nResult

// Usage:
PROCEDURE main()

   LOCAL oCalc := CCalculator():New()
   oCalc:Add( 5, 3 )    // Calls the two-parameter logic
   oCalc:Add( 10 )      // Calls the one-parameter (increment) logic
   oCalc:Add( "abc" )   // Calls error logic

RETURN
```

While this works, it adds complexity to a single method. Often, it's clearer to use different method names (`Increment()`, `AddTwoNumbers()`) rather than overloading in Harbour if the logic diverges significantly.


## 📘 Overview of the Code

This Harbour program defines a class `cCalculator` with a single method `Add()` that behaves differently based on the number and type of arguments passed. The key idea is to **simulate method overloading**, which Harbour does not support natively, by checking the argument count and types.

---

### ✅ Code Walkthrough and Commentary

```harbour
#include "hbclass.ch"
```

* Includes Harbour's object-oriented class support. This is necessary to define and use classes and methods in Harbour.

---

### 📦 Class Definition

```harbour
CLASS cCalculator
   METHOD Add( x, y )
ENDCLASS
```

* **Class Name:** `cCalculator`
* **Method:** `Add(x, y)` is declared with two arguments, but Harbour allows flexible parameter handling using `PCount()`.

---

### 🧠 Method Implementation

```harbour
METHOD Add( x, y ) CLASS cCalculator
   LOCAL nResult := 0
```

* Declares a local variable `nResult` to hold the result of the operation.

#### 🔁 Case 1: One Parameter (Simulating Increment)

```harbour
IF PCount() == 1 .AND. ValType(x) == "N"
```

* Checks if only one argument is passed and it's numeric.
* If true, treats it as an **increment** operation (`x + 1`).

```harbour
   nResult := x + 1
   QOut( "Incrementing: " + LTrim( Str( x ) ) + " to " + LTrim( Str( nResult ) ) )
```

* Converts numbers to strings and prints the incremented result.

---

#### ➕ Case 2: Two Numeric Parameters

```harbour
ELSEIF PCount() == 2 .AND. ValType( x ) == 'N' .AND. ValType( y ) == 'N'
```

* Checks that two numeric parameters were passed.

```harbour
   nResult := x + y
   QOut( "Adding: " + LTrim( Str( x ) ) + " + " + LTrim( Str( y ) ) + " = " + LTrim( Str( nResult ) ) )
```

* Performs a standard addition and prints the result.

---

#### ❌ Case 3: Invalid Parameters

```harbour
ELSE
   QOut( "Error: Invalid parameters for Add method." )
ENDIF
```

* Catches all other invalid cases (e.g., wrong types or number of parameters) and shows an error message.

---

### 🔄 Return Statement

```harbour
RETURN nResult
```

* Returns the result of the operation. If invalid input was given, returns 0 (default initialized value).

---

### 🧪 Usage Example in `main()`

```harbour
PROCEDURE main()

   LOCAL oCalc := CCalculator():New()
```

* Instantiates a `cCalculator` object.

```harbour
   oCalc:Add( 5, 3 )    // Output: "Adding: 5 + 3 = 8"
   oCalc:Add( 10 )      // Output: "Incrementing: 10 to 11"
   oCalc:Add( "abc" )   // Output: "Error: Invalid parameters for Add method."
```

* Demonstrates the three different code paths.

---

## 🧠 Object-Oriented Concepts in Use

| Concept                | Application                                                         |
| ---------------------- | ------------------------------------------------------------------- |
| **Encapsulation**      | Method logic is wrapped inside class                                |
| **Method Overloading** | Simulated using `PCount()` and `ValType()`                          |
| **Polymorphism**       | Not used directly but the structure allows future method overriding |

---
## 🧪 Output Sample

```text
Adding: 5 + 3 = 8
Incrementing: 10 to 11
Error: Invalid parameters for Add method.
```
---
## ✅ Final Thoughts

This is a compact and well-designed class that demonstrates:

* Use of object-oriented design in Harbour
* Method logic branching using `PCount()` and `ValType()`
* Practical simulation of method overloading


### 6.3 **Method Overriding** as a form of Polymorphism

As seen in the `Speak()` example, **method overriding** is the most common and direct way to achieve polymorphism in Harbour. When a child class provides its own implementation of a method that is already defined in its parent class, it's overriding that method.

The key to polymorphism here is that even if you treat a `cDog` object as a `CAnimal` object (e.g., by putting it in an array of `CAnimal` objects), when you call `Speak()`, Harbour's runtime environment will always execute the method belonging to the object's **actual class** (`CDog`'s `Speak()`) rather than the parent's. This is known as **late binding** or dynamic dispatch.

### 6.4 **Duck Typing** in Harbour's Dynamic Nature

Harbour, like many dynamically typed languages (e.g., Python, Ruby), implicitly supports a concept called **"Duck Typing."** The saying goes, "If it walks like a duck and quacks like a duck, then it's a duck."

In OOP, this means that the **type of an object is less important than whether it has the specific methods (or properties) you want to call.** If an object has a `Speak()` method, you can call `obj:Speak()` on it, regardless of its class hierarchy, as long as it behaves like an object that can "speak."

**Example:**

You could have a `CRobot` class that does **not** inherit from `CAnimal`, but you could still give it a `Speak()` method:

```harbour
// In crobot.prg
#include "hbclass.ch"

CLASS CRobot
   VAR cID AS CHARACTER

   METHOD New( cIDParam )
   METHOD Speak()

ENDCLASS

METHOD New( cIDParam )
   ::cID := cIDParam
RETURN SELF

METHOD Speak()
   QOut( "Beep boop, I am " + ::cID + "." )
RETURN NIL
```

```harbour
// In main.prg
#include "hbclass.ch"

PROCEDURE Main()

   LOCAL aSpeakers := {}
   AAdd( aSpeakers, CDog():New( "Fido", 4, .T. ) )
   AAdd( aSpeakers, CCat():New( "Mittens", 2, .F. ) )
   AAdd( aSpeakers, CRobot():New( "Unit-734" ) ) // Robot does NOT inherit from CAnimal

   FOR EACH oSpeaker IN aSpeakers
      // Even though CRobot is not an CAnimal, it has a Speak() method
      oSpeaker:Speak()
   NEXT
   // Output:
   // Fido says Woof! Woof!
   // Mittens says Meow.
   // Beep boop, I am Unit-734.

RETURN
```

Here, the `FOR EACH` loop doesn't care if `oSpeaker` is an `CAnimal`, `CDog`, `CCat`, or `CRobot`. It just assumes that whatever `oSpeaker` is, it has a `Speak()` method. This flexibility is a hallmark of dynamically typed, object-oriented languages like Harbour.

### 6.5 Code Examples: A Collection of `CAnimal` Objects Responding to `Speak()`

Let's refine the polymorphic example from the beginning of the chapter to demonstrate how you can group objects of different types that share a common ancestor and interact with them polymorphically.

```harbour
// Ensure all class files (canimal.prg, cdog.prg, ccat.prg) are in the same folder
// or are properly included in your .hbp project file for compilation.

// main.prg
#include "hbclass.ch" // Essential for OOP features
#include "inkey.ch"   // For QOut

//Include all necessary class definitions
//#include "canimal.prg"  Defines CAnimal
//#include "cdog.prg"     Defines CDog INHERIT CAnimal
//#include "ccat.prg"     Defines CCat INHERIT CAnimal

PROCEDURE Main()

   LOCAL aPets AS ARRAY := {} // An array to hold various CAnimal objects
   LOCAL oCurrentPet AS OBJECT

   QOut( "--- Creating Our Pets ---" )

   // Create instances of derived classes and add them to the array
   AAdd( aPets, CDog():New( "Buddy", 5, .T. ) )
   AAdd( aPets, CCat():New( "Whiskers", 3, .F. ) )
   AAdd( aPets, CDog():New( "Max", 2, .F. ) )
   AAdd( aPets, CAnimal():New( "Parrot", "Polly", 8 ) ) // A base CAnimal instance
   AAdd( aPets, CCat():New( "Shadow", 7, .T. ) )

   QOut( "" )
   QOut( "--- Our Pets Speaking in Order ---" )


   // Iterate through the array. Even though 'aPets' holds different
   // specific types (CDog, CCat, CAnimal), they are all CAnimal or
   // derived from CAnimal, meaning they *all* respond to 'Speak()'.
   FOR EACH oCurrentPet IN aPets
      // This is the core of polymorphism: one message, varied behavior.
      oCurrentPet:Speak()
      // We can also call inherited methods that are not overridden:
      QOut( "  Info: " + oCurrentPet:GetInfo() )
   NEXT

   QOut( "" )
   QOut( "--- Demonstrating Specific Actions (Requires Type Checking or Duck Typing) ---" )

   // If you need to perform a specific action available only in a derived class,
   // you might use type checking (IsInstanceOf) or rely on duck typing.
   // Using IsInstanceOf is safer if the specific method is critical.
   FOR EACH oCurrentPet IN aPets
      IF IsInstanceOf( oCurrentPet, "CDog" )
         // Only CDog objects have the Fetch() method
         oCurrentPet:Fetch()
      ELSEIF IsInstanceOf( oCurrentPet, "CCat" )
         // Only CCat objects have the Climb() method
         oCurrentPet:Climb()
      ENDIF
   NEXT

RETURN NIL
```

**Explanation of the Code Example:**

1.  **`LOCAL aPets AS ARRAY := {}`**: We create a simple array. The key here is that this array can hold references to objects of different classes (`CDog`, `CCat`, `CAnimal`), as long as they share a common base type (explicitly `CAnimal` or implicitly because they "duck type" like an animal that can speak).
2.  **`AAdd( aPets, CDog():New(...) )`**: We add instances of our derived classes, and even one base `CAnimal` instance, to this array.
3.  **`FOR EACH oCurrentPet IN aPets ... oCurrentPet:Speak()`**: This loop is where polymorphism shines. In each iteration, `oCurrentPet` will refer to a different animal object. When `oCurrentPet:Speak()` is called, Harbour's runtime system determines the **actual type** of `oCurrentPet` and executes the `Speak()` method that belongs to that specific class.
      * If `oCurrentPet` is a `CDog`, `CDog:Speak()` runs.
      * If `oCurrentPet` is a `CCat`, `CCat:Speak()` runs.
      * If `oCurrentPet` is a `CAnimal`, `CAnimal:Speak()` runs.
4.  **`oCurrentPet:GetInfo()`**: This demonstrates that methods inherited from the parent class that are *not* overridden can also be called polymorphically.
5.  **Specific Actions and Type Checking**: The second loop illustrates a scenario where you *might* need to know the specific type of an object to call a method that is *not* common to all objects in the collection (e.g., `Fetch()` is only for `CDog`). `IsInstanceOf()` is a useful Harbour function for this purpose, allowing you to safely cast or call specific methods.

Polymorphism, especially when combined with inheritance, allows you to write highly flexible and maintainable code. It enables you to design systems where new types of objects can be added with minimal changes to existing code, as long as they adhere to a common interface defined by a parent class or a set of expected behaviors (duck typing).

-----
