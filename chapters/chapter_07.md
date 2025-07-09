
## Chapter 7: Abstraction and Interfaces

-----

In our journey through Object-Oriented Programming, we've explored Encapsulation (hiding implementation details), Inheritance (reusing code and establishing "is-a" relationships), and Polymorphism (allowing different objects to respond to the same message in unique ways). Now, we arrive at **Abstraction**, a crucial design principle that complements these concepts.

### 7.1 What is Abstraction?

**Abstraction** is the process of simplifying complex reality by modeling classes based on the **essential properties and behaviors** required for a specific purpose, while **ignoring irrelevant details**. It's about focusing on "what" an object does rather than "how" it does it.

Consider a simple remote control for a television. You press the "Volume Up" button, and the volume increases. You don't need to know the intricate electronic signals sent, how the amplifier works, or the speaker's impedance. The remote control provides an **abstracted interface** to the TV's volume control.

In OOP, abstraction helps us:

  * **Manage Complexity:** By hiding unnecessary details, systems become easier to understand and work with.
  * **Define Clear Contracts:** It establishes a contract (an interface) for what services an object will provide, without revealing the underlying implementation.
  * **Promote Modularity:** It allows components to be swapped out (e.g., changing database implementations) as long as they adhere to the same abstract interface.

Harbour, like many dynamic languages, implements abstraction primarily through the design of its classes and methods, often simulating concepts found explicitly in more strictly typed languages.

### 7.2 **Abstract Classes** (Simulated in Harbour)

An **abstract class** is a class that **cannot be instantiated directly** (you cannot create objects from it). It is designed to be a base class that defines a common interface and possibly some common functionality for its derived classes. Abstract classes often contain **abstract methods** (methods declared but without an implementation), which must then be implemented by any concrete (non-abstract) child class that inherits from it.

  * **Harbour's Approach:** Harbour does not have an explicit `ABSTRACT CLASS` keyword like Java or C\#. However, you can **simulate** an abstract class by:
    1.  **Omitting a constructor (`:New()`):** If a class has no `New()` method, you cannot directly instantiate it.
    2.  **Defining "placeholder" methods:** Create methods in the base class that raise an error if called, or simply provide a comment indicating they *must* be overridden by child classes.

**Example of a Simulated Abstract Class:**

Let's imagine a base `cShape` class. We know all shapes have an `Area()`, but the calculation is different for each specific shape (circle, square, triangle).

```harbour
// File: cshape.prg
#include "hbclass.ch"

// This class is intended to be abstract
CLASS CShape
    VAR cShapeType AS CHARACTER PROTECTED

   // No explicit New() method, making it hard to instantiate directly.
   // You could also define a New() that raises an error if called directly.
   // METHOD New()
   //    MsgStop("Cannot instantiate cShape directly. Use derived classes.", "Error")
   //    RETURN NIL // Or raise an error
   // ENDMETHOD

   // Abstract method simulation: defines a contract, child classes MUST implement this
   METHOD GetArea() // Intended to be overridden
   // Concrete method (has an implementation)
   METHOD GetInfo() INLINE "This is a generic " + ::cShapeType + " shape."

ENDCLASS

// Abstract method simulation: defines a contract, child classes MUST implement this
METHOD GetArea() CLASS CShape // Intended to be overridden
   BREAK "Error: GetArea() must be implemented by derived classes."
RETURN 0
```

```harbour
// File: ccircle.prg
#include "hbclass.ch"

CLASS CCircle INHERIT CShape
   VAR nRadius AS NUMERIC HIDDEN

   METHOD New( nRadiusParam )
   METHOD SetRadius( nVal ) HIDDEN
   METHOD GetRadius() INLINE  ::nRadius

   // Implement the abstract method from CShape
   METHOD GetArea() INLINE Pi() * ( ::nRadius ^ 2 )

ENDCLASS


METHOD New( nRadiusParam ) CLASS CCircle
   ::Super:New() // Call parent's (empty or error-throwing) constructor  SUPER
   ::cShapeType := "Circle" // Set inherited property
   ::SetRadius( nRadiusParam )
RETURN SELF

METHOD SetRadius( nVal ) CLASS CCircle

   IF ValType(nVal) == 'N' .AND. nVal >= 0
      ::nRadius := nVal
   ELSE
      QOut("Error: Invalid radius for Circle.")
      ::nRadius := 0
   ENDIF

RETURN NIL
```

```harbour
// File: csquare.prg
#include "hbclass.ch"

CLASS CSquare INHERIT CShape
   VAR nSide AS NUMERIC HIDDEN

   METHOD New( nSideParam )
   METHOD SetSide( nVal ) HIDDEN
   METHOD GetSide() INLINE ::nSide

   // Implement the abstract method from cShape
   METHOD GetArea() INLINE ::nSide ^ 2

ENDCLASS

METHOD New( nSideParam )  CLASS CSquare
   ::SUPER:New()          //Super
   ::cShapeType := "Square"
   ::SetSide( nSideParam )
RETURN SELF

METHOD SetSide( nVal ) CLASS CSquare

   IF ValType(nVal) == 'N' .AND. nVal >= 0
      ::nSide := nVal
   ELSE
      QOut("Error: Invalid side length for Square.")
      ::nSide := 0
   ENDIF

RETURN NIL
```

```harbour
// --- main.prg ---
#include "hbclass.ch"
#include "inkey.ch"

PROCEDURE Main()

   LOCAL oCircle AS OBJECT
   LOCAL oSquare AS OBJECT
   LOCAL oShape  AS OBJECT
   LOCAL aShapes := {} // Array to hold diverse shapes

   // Attempting to instantiate an abstract class directly (will fail or error)
   // LOCAL oAbstractShape := CShape():New() // If New() raises error, this stops execution
   oCircle := CCircle():New( 5 )
   oSquare := CSquare():New( 10 )

   AAdd( aShapes, oCircle )
   AAdd( aShapes, oSquare )

   QOut( "--- Calculating Areas ---" )
   FOR EACH oShape IN aShapes
      QOut( oShape:GetInfo() ) // Inherited concrete method
      QOut( "  Area: " + LTrim( Str( oShape:GetArea(), 10, 2 ) ) ) // Polymorphic call to abstract method
   NEXT

RETURN
```

## 🔷 **File: `cshape.prg`** — Abstract Base Class

```harbour
CLASS cShape
    VAR cShapeType AS CHARACTER PROTECTED
    METHOD GetArea()
    METHOD GetInfo() INLINE "This is a generic " + ::cShapeType + " shape."
ENDCLASS
```

### ✅ Purpose:

* `cShape` acts as an **abstract base class** for all shapes.
* It defines a **contract**: every subclass must implement `GetArea()`.

### ✅ Key Concepts:

* `VAR cShapeType`: Holds the shape type, e.g., `"Circle"` or `"Square"`.
* `GetArea()`: This is a **virtual method**, meant to be overridden.

  ```harbour
  METHOD GetArea() CLASS cShape
     BREAK "Error: GetArea() must be implemented by derived classes."
     RETURN 0
  ```

  If a subclass doesn’t override it, it will break the program.
* `GetInfo()`: A **concrete method** returning a generic description.

---

## 🔷 **File: `ccircle.prg`** — Concrete Class: Circle

```harbour
CLASS cCircle INHERIT cShape
   VAR nRadius AS NUMERIC HIDDEN
   METHOD New( nRadiusParam )
   METHOD SetRadius( nVal ) HIDDEN
   METHOD GetRadius() INLINE  ::nRadius
   METHOD GetArea() INLINE Pi() * ( ::nRadius ^ 2 )
ENDCLASS
```

### ✅ Purpose:

* Implements a specific shape: **Circle**.
* **Inherits** from `cShape`.

### ✅ Key Concepts:

* `New(nRadiusParam)`: Constructor that sets `cShapeType := "Circle"` and assigns radius.
* `SetRadius(nVal)`: Private method to validate radius.
* `GetArea()`: Implements abstract method using the circle area formula.

---

## 🔷 **File: `csquare.prg`** — Concrete Class: Square

```harbour
CLASS cSquare INHERIT cShape
   VAR nSide AS NUMERIC HIDDEN
   METHOD New( nSideParam )
   METHOD SetSide( nVal ) HIDDEN
   METHOD GetSide() INLINE ::nSide
   METHOD GetArea() INLINE ::nSide ^ 2
ENDCLASS
```

### ✅ Purpose:

* Implements a **Square**, inherits from `cShape`.

### ✅ Key Concepts:

* `SetSide(nVal)`: Ensures non-negative side.
* `GetArea()`: Returns area of square (`side²`).

---

## 🔷 **File: `main.prg`** — Application Entry Point

```harbour
PROCEDURE Main()
   LOCAL aShapes := {}
   oCircle := cCircle():New(5)
   oSquare := cSquare():New(10)
   AAdd(aShapes, oCircle)
   AAdd(aShapes, oSquare)

   FOR EACH oShape IN aShapes
      QOut(oShape:GetInfo())
      QOut("  Area: " + LTrim(Str(oShape:GetArea(), 10, 2)))
   NEXT
RETURN
```

### ✅ Purpose:

* Demonstrates **polymorphism**: array holds both circles and squares as `cShape` types.
* Loops through the array, calls `GetInfo()` and `GetArea()` dynamically based on object type.

---

## 🧠 **Key OOP Concepts Demonstrated**

| Concept            | Shown In                        | Description                                                    |
| ------------------ | ------------------------------- | -------------------------------------------------------------- |
| **Abstract Class** | `cShape`                        | Prevents direct instantiation. Provides a contract (`GetArea`) |
| **Inheritance**    | `cCircle`, `cSquare` → `cShape` | Both shapes inherit common behavior                            |
| **Encapsulation**  | `nRadius`, `nSide` are hidden   | Controlled via `Set` methods                                   |
| **Polymorphism**   | `aShapes` array loop            | Same method (`GetArea`) called, different implementations      |
| **Error Handling** | `BREAK` in `GetArea()`          | Enforces implementation in subclasses                          |

---
## 🧪 Output Sample

```text
"--- Calculating Areas ---"
This is a generic Circle shape.
  Area: 78.54
This is a generic Square shape.
  Area: 100.00
```
---
## ✅ Summary

This code is a **clean and classic example** of using **OOP in Harbour/xHarbour**, showing:

* Abstract class behavior without native language support.
* Inheritance and method overriding.
* Polymorphism via common method interface (`GetArea()`).
