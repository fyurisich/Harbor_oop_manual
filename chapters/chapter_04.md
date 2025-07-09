
## Chapter 4: Encapsulation: Protecting Data

-----

Encapsulation is one of the most fundamental principles of Object-Oriented Programming, often considered one of the "big four" along with Inheritance, Polymorphism, and Abstraction. In simple terms, encapsulation is about **bundling the data (properties) and the methods (behaviors) that operate on that data into a single unit – the object – and restricting direct access to some of the object's components.**

Imagine a complex machine, like a car engine. As a driver, you interact with the steering wheel, accelerator, and brake pedal. You don't (and shouldn't) directly manipulate the spark plugs, fuel injectors, or crankshaft. The internal workings are "hidden" from you, and you interact through a well-defined interface (the dashboard controls). This "hiding of internal details" is precisely what encapsulation achieves.

### 4.1 The Importance of Data Hiding

Data hiding, a key aspect of encapsulation, is crucial for several reasons:

1.  **Data Integrity:** By preventing direct, unrestricted access to an object's internal data, you can ensure that the data remains in a valid and consistent state. Methods can implement validation rules before allowing changes to properties.
2.  **Reduced Coupling:** Objects become less dependent on the internal implementation details of other objects. If an object's internal data structure changes, other objects that interact with it through its public interface won't be affected. This reduces "ripple effects" of changes throughout your codebase.
3.  **Maintainability:** When data is encapsulated, debugging and maintaining code becomes easier. If there's an issue with a property's value, you know that the problem must lie within the methods that operate on that property, rather than anywhere in the entire program.
4.  **Flexibility and Scalability:** You can change the internal implementation of a class without breaking the code that uses it, as long as its public interface (its public methods) remains consistent. This allows for easier refactoring and future enhancements.

In Harbour, while `VAR` properties are public by default, good OOP practice encourages explicit control over property access.

### 4.2 Using **Access Modifiers** for Properties:

Just like with methods, Harbour provides **access modifiers** to control the visibility of instance variables (properties).

  * **`DATA | VAR` (Public by Default)**:

      * Properties declared with `DATA | VAR` (or explicitly `PUBLIC VAR`) are accessible from **anywhere**. This means code outside the class can directly read and write to these properties using the colon (`:`) operator.
      * **Use Case:** Simple, read-only data that doesn't require validation, or properties primarily used for internal communication between tightly coupled objects (though often better replaced by methods).

    <!-- end list -->

    ```harbour
    CLASS cProduct

       VAR cName            // Public by default
       VAR nPrice  EXPORTED // Explicitly public
    ENDCLASS
    ```

  * **`PROTECTED VAR`**:

      * Properties declared `PROTECTED VAR` are accessible only from **within the class itself** and from **derived (child) classes**.
      * They are hidden from outside objects.
      * **Use Case:** Data that is internal to the class's implementation but might need to be accessed or manipulated by subclasses to extend functionality.

    <!-- end list -->

```harbour
#include "hbclass.ch" // Include Harbour class definitions

// Define a base class for bank accounts
CLASS CBaseAccount
   VAR nBalance PROTECTED // Protected: accessible only within the class and its subclasses
ENDCLASS

// Define a subclass for credit accounts that inherits from cBaseAccount
CLASS CCreditAccount INHERIT CBaseAccount

   METHOD New( nValor )        // Constructor method to initialize the balance
   METHOD ApplyInterest()      // Method to apply interest to the balance

ENDCLASS

// Constructor method for cCreditAccount
METHOD New( nValor ) CLASS CCreditAccount
   ::nBalance := nValor        // Set the initial balance using the inherited protected variable
RETURN Self                 // Return the created object (this)

// Method to apply 5% interest to the account balance
METHOD ApplyInterest() CLASS cCreditAccount
   // Access the inherited protected variable nBalance and apply 5% interest
   ::nBalance := ::nBalance * 1.05
RETURN ::nBalance           // Return the new balance after interest is applied

// --- Usage Example ---
PROCEDURE Main()

   LOCAL oCredito := CCreditAccount():New( 100 ) // Create a new credit account with $100
   ? oCredito:ApplyInterest()                    // Apply interest and display the updated balance

RETURN
```
## 🔍 **Code Explanation**

### 🔹 Purpose

This program defines a simple **bank account structure using OOP in Harbour**, with a focus on inheritance and access control using the `PROTECTED` keyword.

---

### 🔹 Class `CBaseAccount`

```harbour
CLASS CBaseAccount
   VAR nBalance PROTECTED
ENDCLASS
```

* A base class that contains a single attribute:

  * `nBalance`: the account balance
  * It's marked as `PROTECTED`, meaning it can be accessed inside this class **and** any class that inherits from it.

---

### 🔹 Class `cCreditAccount` (inherits from `cBaseAccount`)

```harbour
CLASS cCreditAccount INHERIT cBaseAccount
```

* This class **extends `cBaseAccount`**, so it inherits the `nBalance` variable.
* It adds two methods:

  * `New(nValor)` → constructor to set the initial balance
  * `ApplyInterest()` → adds 5% interest to the balance

---

### 🔹 `New()` Method

```harbour
METHOD New( nValor ) CLASS cCreditAccount
   ::nBalance := nValor
RETURN Self
```

* This is the **constructor** for `cCreditAccount`.
* It initializes `nBalance` with the value passed as `nValor`.
* Returns the object so that it can be used in a single statement like:

  ```harbour
  LOCAL oCredito := cCreditAccount():New(100)
  ```

---

### 🔹 `ApplyInterest()` Method

```harbour
METHOD ApplyInterest() CLASS cCreditAccount
   ::nBalance := ::nBalance * 1.05
RETURN ::nBalance
```

* Applies a 5% interest increase to the account balance.
* Uses the inherited `nBalance` variable from the base class.
* Returns the updated balance.

---

### 🔹 `Main()` Procedure

```harbour
PROCEDURE Main()
   LOCAL oCredito := cCreditAccount():New(100)
   ? oCredito:ApplyInterest()
   RETURN
```

* Creates a `cCreditAccount` object with an initial balance of `$100`.
* Calls `ApplyInterest()` to increase it by 5% (so it becomes `$105.00`).
* Displays the result using `?`.

---

## 🧾 Output

```
105.00
```

---

## ✅ Summary

| Feature             | Description                                           |
| ------------------- | ----------------------------------------------------- |
| **Inheritance**     | `cCreditAccount` inherits from `cBaseAccount`         |
| **Access Control**  | `nBalance` is `PROTECTED`, accessible in both classes |
| **Encapsulation**   | Balance is modified only through methods              |
| **Method Override** | Not used, but could be added in future                |
| **Interest Logic**  | Simple 5% interest application                        |

---
  * **`HIDDEN VAR`**:

      * Properties declared `HIDDEN VAR` are the most restrictive. They are accessible **only from within the class itself**. They are completely invisible to objects outside the class and to derived classes.
      * **Use Case:** Internal data that represents the private state of the object and should never be exposed or directly modified, even by subclasses. This is the strongest form of data hiding.

    <!-- end list -->

    ```harbour
    CLASS CAuthenticator
       VAR cPasswordHash  HIDDEN // Only CAuthenticator methods can see this
    ENDCLASS
    ```

**Choosing the Right Modifier:**

  * **`HIDDEN`**: Start with this. If a property doesn't *need* to be accessed from outside, make it hidden. This is the safest approach for encapsulation.
  * **`PROTECTED`**: Use this if a property is truly an internal detail, but you anticipate that subclasses might need direct access to implement their specific behaviors.
  * **`VARDATA | VAR`/`EXPORTED`**: Use sparingly. Only for properties that are part of the object's public interface and whose direct modification is harmless and doesn't require validation.

### 4.3 **Getter and Setter Methods**: Controlled Access to Properties

Even for properties that are declared `HIDDEN` or `PROTECTED`, you often need a way for external code or child classes to interact with them in a controlled manner. This is where **getter** and **setter** methods come into play.

  * **Getter Method (Accessor):** A method whose sole purpose is to retrieve the value of a private or protected property. It typically starts with `Get` (e.g., `GetBalance()`, `GetName()`).
  * **Setter Method (Mutator):** A method whose sole purpose is to modify the value of a private or protected property. It typically starts with `Set` (e.g., `SetAddress( cNewAddress )`, `SetPrice( nNewPrice )`). Crucially, setter methods can include **validation logic** to ensure that the new value is valid before it's assigned to the property.

**Advantages of Getters and Setters:**

1.  **Validation:** Setters allow you to enforce business rules. For example, a `SetAge()` method could prevent setting a negative age.
2.  **Computation:** A getter might not just return a stored value but could compute it on the fly. `GetFullName()` could concatenate `cFirstName` and `cLastName`.
3.  **Logging/Auditing:** Setters can log when a property's value changes.
4.  **Notifications:** Setters can trigger other actions or notifications when a value is updated.
5.  **Abstraction:** The internal representation of a property can change without affecting the external code that uses the getter/setter. If `cFirstName` and `cLastName` are combined into `cFullName` internally, the `GetFirstName()` method could simply parse `cFullName`.

**Syntax Example:**

```harbour
#include "hbclass.ch"  // Include Harbour's Object-Oriented Class framework

/*
* Class: CPerson
* Description: Models a person with name and age properties
* Encapsulation: All attributes marked as HIDDEN (strict encapsulation)
* Attributes:
*   cFirstName - Character - Person's first name
*   cLastName  - Character - Person's last name
*   nAge       - Numeric   - Person's age (0-150)
* Note: Uses both DATA and VAR syntax for attribute declaration
*/
CLASS CPerson
   DATA cFirstName  AS CHARACTER INIT "" HIDDEN  // First name (hidden)
   DATA cLastName   AS CHARACTER INIT "" HIDDEN  // Last name (hidden)
   VAR nAge         AS NUMERIC   INIT  0 HIDDEN  // Age (hidden, typed)

   // --- Public Interface ---
   METHOD New( cFirst, cLast, nYears )  // Constructor

   // Accessor Methods (Getters)
   METHOD GetFirstName()  // Returns first name
   METHOD GetLastName()   // Returns last name
   METHOD GetFullName()   // Returns combined name
   METHOD GetAge()        // Returns age

   // Mutator Methods (Setters)
   METHOD SetFirstName( cNewFirst )  // Updates first name
   METHOD SetLastName( cNewLast )    // Updates last name
   METHOD SetAge( nNewAge )          // Updates age with validation
ENDCLASS

/* === Constructor Implementation === */

/*
* Method: New
* Parameters:
*   cFirst - Character - Initial first name
*   cLast  - Character - Initial last name
*   nYears - Numeric   - Initial age
* Design:
*   - Uses setters for initialization to enforce validation
*   - Returns SELF for method chaining
*/
METHOD New( cFirst, cLast, nYears ) CLASS CPerson
   ::SetFirstName( cFirst )  // Validated assignment
   ::SetLastName( cLast )    // Validated assignment
   ::SetAge( nYears )        // Validated assignment
RETURN SELF                  // Enable fluent interface

/* === Accessor Methods (Getters) === */

/*
* Method: GetFirstName
* Returns: Character - Current first name
* Note: Simple accessor for hidden property
*/
METHOD GetFirstName() CLASS CPerson
RETURN ::cFirstName

/*
* Method: GetLastName
* Returns: Character - Current last name
* Note: Simple accessor for hidden property
*/
METHOD GetLastName() CLASS CPerson
RETURN ::cLastName

/*
* Method: GetFullName
* Returns: Character - Combined first and last name
* Format: "FirstName LastName" (with single space)
* Processing: Uses AllTrim() to clean whitespace
*/
METHOD GetFullName() CLASS CPerson
RETURN AllTrim( ::cFirstName ) + " " + AllTrim( ::cLastName )

/*
* Method: GetAge
* Returns: Numeric - Current age
* Note: Simple accessor for hidden property
*/
METHOD GetAge() CLASS CPerson
RETURN ::nAge

/* === Mutator Methods (Setters) === */

/*
* Method: SetFirstName
* Parameters: cNewFirst - Character - New first name
* Validation: Rejects empty strings
* Error Handling: Prints message to console on error
*/
METHOD SetFirstName( cNewFirst ) CLASS CPerson
   IF ! Empty( cNewFirst )
      ::cFirstName := cNewFirst  // Valid assignment
   ELSE
      QOut( "Error: First name cannot be empty." )  // Error feedback
   ENDIF
RETURN NIL

/*
* Method: SetLastName
* Parameters: cNewLast - Character - New last name
* Validation: Rejects empty strings
* Error Handling: Prints message to console on error
*/
METHOD SetLastName( cNewLast ) CLASS CPerson
   IF ! Empty( cNewLast )
      ::cLastName := cNewLast  // Valid assignment
   ELSE
      QOut( "Error: Last name cannot be empty." )  // Error feedback
   ENDIF
RETURN NIL

/*
* Method: SetAge
* Parameters: nNewAge - Numeric - New age value
* Validation:
*   - Must be numeric type
*   - Must be between 0 and 150 (inclusive)
* Error Handling: Prints message to console on error
*/
METHOD SetAge( nNewAge ) CLASS CPerson
   IF ValType( nNewAge ) == 'N' .AND. nNewAge >= 0 .AND. nNewAge <= 150
      ::nAge := nNewAge  // Valid assignment
   ELSE
      QOut( "Error: Invalid age. Must be between 0 and 150." )  // Error feedback
   ENDIF
RETURN NIL
```
## ✅ General Overview

* **Purpose**: Define a `CPerson` class with properties like first name, last name, and age.
* **Encapsulation**: All attributes are marked as `HIDDEN`, so they cannot be accessed directly outside the class.
* **Access**: Controlled through getter and setter methods.
* **Validation**: Ensures that data integrity is maintained (e.g., no empty names, age within range).

---

## 📦 Class Structure: `CPerson`

### 🔐 Attributes

```harbour
DATA cFirstName AS CHARACTER INIT "" HIDDEN
DATA cLastName  AS CHARACTER INIT "" HIDDEN
VAR  nAge       AS NUMERIC   INIT 0 HIDDEN
```

* `DATA` and `VAR` are used to declare class attributes.
* `HIDDEN` enforces strict encapsulation — attributes cannot be accessed directly from outside the class.
* `INIT` gives a default value to the attributes (empty string or 0).

---

### 🏗️ Constructor: `New()`

```harbour
METHOD New( cFirst, cLast, nYears ) CLASS CPerson
   ::SetFirstName( cFirst )
   ::SetLastName( cLast )
   ::SetAge( nYears )
RETURN SELF
```

* Initializes the object with name and age.
* **Good practice**: It uses setter methods inside the constructor, which enforces validation rules from the start.
* `RETURN SELF` enables method chaining or fluent interface.

---

### 🔍 Getter Methods (Accessors)

```harbour
METHOD GetFirstName() CLASS CPerson
RETURN ::cFirstName

METHOD GetLastName() CLASS CPerson
RETURN ::cLastName

METHOD GetFullName() CLASS CPerson
RETURN AllTrim( ::cFirstName ) + " " + AllTrim( ::cLastName )

METHOD GetAge() CLASS CPerson
RETURN ::nAge
```

* Provide **controlled access** to the internal state.
* `GetFullName()` constructs a full name using `AllTrim()` to avoid spacing issues.

---

### ✏️ Setter Methods (Mutators) with Validation

#### ✅ `SetFirstName()` and `SetLastName()`

```harbour
IF ! Empty( cNewFirst )
   ::cFirstName := cNewFirst
ELSE
   QOut( "Error: First name cannot be empty." )
```

* Prevents empty names.
* Uses `QOut()` to inform the user of input errors.

#### ✅ `SetAge()`

```harbour
IF ValType( nNewAge ) == 'N' .AND. nNewAge >= 0 .AND. nNewAge <= 150
   ::nAge := nNewAge
ELSE
   QOut( "Error: Invalid age. Must be between 0 and 150." )
```

* Validates that the input is:

  * A number
  * Within the range 0–150 (realistic human age range)

---

## 🔐 Encapsulation Features

* **`HIDDEN`**: Ensures that attributes can't be modified directly — access is strictly via methods.
* This promotes **data integrity** and **controlled modification**.
* Prevents accidental misuse of internal state from external procedures or classes.

---

## 🔄 Object-Oriented Best Practices Followed

| Principle     | Implementation in Code                             |
| ------------- | -------------------------------------------------- |
| Encapsulation | `HIDDEN` attributes + validated setters            |
| Abstraction   | Public methods hide implementation details         |
| Validation    | Prevents invalid states (empty names, invalid age) |
| Fluent API    | `New()` returns `SELF` to support chaining         |

---

## 🧠 Suggested Improvements (Optional)

* Add a `ToString()` method to represent the person in a single-line format.
* Add `READONLY` to any getter methods if you intend them to be fixed once set.
* Use `PROTECTED` for internal methods if more complexity is introduced later (e.g., logging, age groups).

---

## 🧪 Example Usage (Not in code but inferred)

```harbour
LOCAL oPerson := CPerson():New( "John", "Doe", 30 )
? oPerson:GetFullName()     // Outputs: "John Doe"
? oPerson:GetAge()          // Outputs: 30
```
---
#### 4.3.1 `READONLY` and `RO` Properties (Harbour Specific Syntax)

Harbour offers a syntactic sugar to simplify the creation of simple getter/setter methods. While the manual `METHOD GetX()` / `METHOD SetX()` approach is clear, `READONLY` and `RO` keywords can create them implicitly.

  * **`READONLY VAR PropertyName AS DataType`**:

      * This property acts as if it has a `HIDDEN VAR PropertyName` and a `PUBLIC METHOD GetPropertyName()`.
      * You can read its value from outside (`oObject:PropertyName`), but you cannot directly assign to it (`oObject:PropertyName := "New"` will cause an error). You would typically set its value internally, often in the constructor or other methods.

  * **`WRITEONLY VAR PropertyName AS DataType`**:

      * This property acts as if it has a `HIDDEN VAR PropertyName` and a `METHOD SetPropertyName( Value ) EXPORTED`.
      * You can assign a value to it from outside (`oObject:PropertyName := "New"`), but you cannot directly read its value (`QOut(oObject:PropertyName)` will cause an error). This is less common but useful for "write-only" properties like passwords.

**Example with `READONLY` and `RO`:**

```harbour
#include "hbclass.ch"  // Include Harbour's Object-Oriented Class framework

/*
* Class: CSession
* Description: Demonstrates advanced visibility control in Harbour OOP
* Visibility Types:
*   - READONLY: Public read but private write
*   - EXPORTED: Public write and read
*   - HIDDEN: Fully private (accessible only within class)
* Use Case: Secure session management with controlled access
*/
CLASS CSession
   // --- Visibility-Controlled Attributes ---
   DATA cSessionID AS CHARACTER READONLY    // Public read, private write
   VAR  cPassword  AS CHARACTER EXPORTED    // Public write and read
   VAR  nInternalCounter AS NUMERIC HIDDEN  // Fully private counter

   // --- Public Interface ---
   METHOD New()              // Constructor
   METHOD IncrementCounter() // Modifies hidden counter
   METHOD GetCounter()       // Accesses hidden counter
ENDCLASS

/* === Constructor Implementation === */

/*
* Method: New
* Initializes:
*   - cSessionID: Generated unique session ID
*   - nInternalCounter: Zero-initialized
* Design:
*   - Session ID combines timestamp and random number
*   - Uses Seconds() for uniqueness
*   - Rand() adds extra entropy
*/
METHOD New() CLASS CSession
   ::cSessionID := AllTrim( Str( Seconds(), 10 ) ) + "-" + ;
                   AllTrim( Str( Int( Rand() * 10000 ), 5 ) )
   ::nInternalCounter := 0  // Initialize hidden counter
RETURN SELF

/* === Counter Management Methods === */

/*
* Method: IncrementCounter
* Purpose: Modifies the hidden internal counter
* Visibility: Needed because nInternalCounter is HIDDEN
* Note: Could add validation/logging here
*/
METHOD IncrementCounter() CLASS CSession
   ::nInternalCounter++  // Direct access to hidden member
RETURN NIL

/*
* Method: GetCounter
* Returns: Numeric - Current counter value
* Purpose: Provides controlled read access to hidden counter
* Security: Allows monitoring without direct access
*/
METHOD GetCounter() CLASS CSession
RETURN ::nInternalCounter  // Only way to read hidden value

/* === Demonstration Code === */
PROCEDURE main()
   // Create new session instance
   LOCAL oSession := CSession():New()

   // --- READONLY Property Demo ---
   QOut( "Session ID: " + oSession:cSessionID )  // Allowed (read)
   // oSession:cSessionID := "new"  // Would fail (READONLY prevents write)

   // --- EXPORTED Property Demo ---
   oSession:cPassword := "MySecret!"  // Allowed (write)
   QOut( oSession:cPassword )


   // --- HIDDEN Property Demo ---
   oSession:IncrementCounter()  // Modifies hidden counter via method
   QOut( "Internal Counter: " + LTrim( Str( oSession:GetCounter() ) ) )  // Reads via getter

RETURN
```
## ✅ Overview

This program defines a class called `CSession` designed to simulate a **secure session system**, emphasizing **visibility modifiers** (`READONLY`, `EXPORTED`, `HIDDEN`) in Harbour’s OOP system.

Visibility is tightly controlled to:

* Prevent unauthorized access to sensitive attributes (`READONLY`, `HIDDEN`)
* Allow flexible access where needed (`EXPORTED`)

---

## 📦 Header

```harbour
#include "hbclass.ch"
```

This header includes the Harbour OOP class system definitions, enabling the use of `CLASS`, `METHOD`, `DATA`, `VAR`, and visibility modifiers like `HIDDEN`, `READONLY`, and `EXPORTED`.

---

## 🔐 Class Definition: `CSession`

```harbour
CLASS CSession
```

A class modeling a user session with:

### 🔒 Visibility-Controlled Attributes

```harbour
DATA cSessionID AS CHARACTER READONLY
VAR  cPassword  AS CHARACTER EXPORTED
VAR  nInternalCounter AS NUMERIC HIDDEN
```

| Attribute          | Type   | Visibility | Purpose                                                        |
| ------------------ | ------ | ---------- | -------------------------------------------------------------- |
| `cSessionID`       | `DATA` | `READONLY` | Unique session ID; readable but **write-protected** externally |
| `cPassword`        | `VAR`  | `EXPORTED` | Publicly **readable/writable** password field                  |
| `nInternalCounter` | `VAR`  | `HIDDEN`   | A private numeric counter, inaccessible outside the class      |

---

## 🏗️ Constructor Method: `New()`

```harbour
METHOD New() CLASS CSession
   ::cSessionID := AllTrim( Str( Seconds(), 10 ) ) + "-" + ;
                   AllTrim( Str( Int( Rand() * 10000 ), 5 ) )
   ::nInternalCounter := 0
RETURN SELF
```

### What it does:

* Generates a **unique session ID** using:

  * `Seconds()`: current time in seconds since midnight
  * `Rand()`: random number generator for entropy
* Initializes `nInternalCounter` to 0
* Returns the newly created object (`SELF`)

---

## 🔄 Method: `IncrementCounter()`

```harbour
METHOD IncrementCounter() CLASS CSession
   ::nInternalCounter++
RETURN NIL
```

### Purpose:

* Increments the **private counter**
* Since `nInternalCounter` is `HIDDEN`, external code **cannot modify it directly**, so this method is required

---

## 📖 Method: `GetCounter()`

```harbour
METHOD GetCounter() CLASS CSession
RETURN ::nInternalCounter
```

### Purpose:

* Exposes the current value of `nInternalCounter`
* Follows **encapsulation** principles: data is hidden, access is controlled

---

## 🧪 Demonstration Code: `main()`

```harbour
PROCEDURE main()
   LOCAL oSession := CSession():New()
```

### READONLY Test

```harbour
QOut( "Session ID: " + oSession:cSessionID )  // OK: Read allowed
// oSession:cSessionID := "new"              // Error: Cannot write
```

* Shows that `cSessionID` can be read, but attempts to write it would fail due to `READONLY`.

### EXPORTED Test

```harbour
oSession:cPassword := "MySecret!"   // OK: write allowed
QOut( oSession:cPassword )          // OK: read allowed
```

* `EXPORTED` allows full access (read/write) from outside.

### HIDDEN Test

```harbour
oSession:IncrementCounter()                    // OK: modifies via method
QOut( "Internal Counter: " + ;
   LTrim( Str( oSession:GetCounter() ) ) )     // OK: read via method
```

* Cannot access `nInternalCounter` directly — interaction only through methods.

---

## 🧠 Design Principles Applied

| Principle                 | Implementation                                                              |
| ------------------------- | --------------------------------------------------------------------------- |
| **Encapsulation**         | Via `HIDDEN`, `READONLY`, and controlled access methods                     |
| **Abstraction**           | Hides implementation details (e.g., session ID format, counter logic)       |
| **Security**              | Prevents unauthorized access/modification of critical session data          |
| **Single Responsibility** | Each method does exactly one thing (e.g., `IncrementCounter`, `GetCounter`) |

---

## 📝 Summary

This code demonstrates **professional OOP practices** in Harbour with strong control over attribute visibility. It's especially useful in contexts such as:

* **Secure session or token management**
* **Controlled lifecycle of objects**
* **Audit or monitoring of sensitive internal operations**

---

### 4.4 Code Examples: Encapsulating `cProduct
` Details

Let's refine our `cProduct
` example to demonstrate strong encapsulation, using hidden variables and getter/setter methods for controlled access.

```harbour
/*
* Class: CProduct
* Description: Models a product with inventory management capabilities
* Visibility: All attributes marked as HIDDEN (strict encapsulation)
* Attributes:
*   cProductID   - Unique product identifier
*   cProductName - Product description
*   nUnitPrice   - Current price per unit
*   nStockCount  - Current inventory quantity
* Design Pattern: Classic Domain Model with Active Record elements
*/
#include "hbclass.ch"  // Harbour OOP framework
#include "inkey.ch"    // For input handling (though not used in this example)

CLASS CProduct
   // --- Hidden Instance Variables ---
   VAR cProductID  AS CHARACTER  HIDDEN  // Protected from direct access
   VAR cProductName AS CHARACTER HIDDEN  // Enforces method-based access
   VAR nUnitPrice  AS NUMERIC    HIDDEN  // Financial data protected
   VAR nStockCount AS NUMERIC    HIDDEN  // Inventory control

   // --- Public Interface ---
   METHOD New( cID, cName, nPrice, nStock )  // Constructor

   // Accessor Methods (Getters)
   METHOD GetProductID()
   METHOD GetProductName()
   METHOD GetUnitPrice()
   METHOD GetStockCount()

   // Mutator Methods (Setters with validation)
   METHOD SetProductID( cNewID )
   METHOD SetProductName( cNewName )
   METHOD SetUnitPrice( nNewPrice )
   METHOD SetStockCount( nNewStock )

   // Business Logic Methods
   METHOD Purchase( nQuantity )  // Inventory addition
   METHOD Sell( nQuantity )     // Inventory deduction
   METHOD GetProductValue()     // Calculates total inventory value
ENDCLASS

/* === Constructor Implementation === */

/*
* Method: New
* Parameters:
*   cID     - Initial product ID
*   cName   - Initial product name
*   nPrice  - Initial unit price
*   nStock  - Initial stock quantity
* Design:
*   - Uses setters for initialization to enforce validation
*   - Ensures valid initial state
* Returns: Self reference
*/
METHOD New( cID, cName, nPrice, nStock ) CLASS CProduct
   ::SetProductID( cID )     // Validated assignment
   ::SetProductName( cName )  // Validated assignment
   ::SetUnitPrice( nPrice )   // Validated assignment
   ::SetStockCount( nStock )  // Validated assignment
RETURN SELF

/* === Accessor Methods === */

// Simple getters provide read-only access to hidden properties
METHOD GetProductID() CLASS CProduct
RETURN ::cProductID

METHOD GetProductName() CLASS CProduct
RETURN ::cProductName

METHOD GetUnitPrice() CLASS CProduct
RETURN ::nUnitPrice

METHOD GetStockCount() CLASS CProduct
RETURN ::nStockCount

/* === Mutator Methods with Validation === */

/*
* Method: SetProductID
* Validation Rules:
*   - Non-empty string
*   - Maximum 20 characters
* Error Handling: Console message on failure
*/
METHOD SetProductID( cNewID ) CLASS CProduct
   IF ! Empty( cNewID ) .AND. Len( cNewID ) <= 20
      ::cProductID := AllTrim( cNewID )  // Clean assignment
   ELSE
      QOut( "Error: Invalid Product ID. Must be non-empty and max 20 chars." )
   ENDIF
RETURN NIL

/*
* Method: SetProductName
* Validation Rules:
*   - Non-empty string
*   - Maximum 100 characters
*/
METHOD SetProductName( cNewName ) CLASS CProduct
   IF ! Empty( cNewName ) .AND. Len( cNewName ) <= 100
      ::cProductName := AllTrim( cNewName )
   ELSE
      QOut( "Error: Invalid Product Name. Must be non-empty and max 100 chars." )
   ENDIF
RETURN NIL

/*
* Method: SetUnitPrice
* Validation Rules:
*   - Must be numeric
*   - Non-negative value
*/
METHOD SetUnitPrice( nNewPrice ) CLASS CProduct
   IF ValType( nNewPrice ) == 'N' .AND. nNewPrice >= 0
      ::nUnitPrice := nNewPrice
   ELSE
      QOut( "Error: Unit Price must be a non-negative number." )
   ENDIF
RETURN NIL

/*
* Method: SetStockCount
* Validation Rules:
*   - Must be numeric
*   - Non-negative integer
*/
METHOD SetStockCount( nNewStock ) CLASS CProduct
   IF ValType( nNewStock ) == 'N' .AND. nNewStock >= 0 .AND. Int( nNewStock ) == nNewStock
      ::nStockCount := nNewStock
   ELSE
      QOut( "Error: Stock Count must be a non-negative integer." )
   ENDIF
RETURN NIL

/* === Business Logic Methods === */

/*
* Method: Purchase
* Parameters: nQuantity - Amount to add to stock
* Validation:
*   - Positive numeric value
* Side Effects:
*   - Increases stock count
*   - Outputs transaction message
* Returns: Logical success status
*/
METHOD Purchase( nQuantity ) CLASS CProduct
   LOCAL lSuccess := .F.
   IF ValType( nQuantity ) == 'N' .AND. nQuantity > 0
      ::nStockCount += nQuantity
      QOut( "Purchased " + LTrim( Str( nQuantity ) ) + " units of " + ;
            ::cProductName + ". New stock: " + LTrim( Str( ::nStockCount ) ) )
      lSuccess := .T.
   ELSE
      QOut( "Error: Purchase quantity must be positive." )
   ENDIF
RETURN lSuccess

/*
* Method: Sell
* Parameters: nQuantity - Amount to deduct from stock
* Validation:
*   - Positive numeric value
*   - Sufficient stock available
* Returns: Logical success status
*/
METHOD Sell( nQuantity ) CLASS cProduct
   LOCAL lSuccess := .F.
   IF ValType( nQuantity ) == 'N' .AND. nQuantity > 0
      IF ::nStockCount >= nQuantity
         ::nStockCount -= nQuantity
         QOut( "Sold " + LTrim( Str( nQuantity ) ) + " units of " + ;
               ::cProductName + ". Remaining stock: " + LTrim( Str( ::nStockCount ) ) )
         lSuccess := .T.
      ELSE
         QOut( "Error: Insufficient stock to sell " + LTrim( Str( nQuantity ) ) + ;
               " units of " + ::cProductName + "." )
      ENDIF
   ELSE
      QOut( "Error: Sell quantity must be positive." )
   ENDIF
RETURN lSuccess

/*
* Method: GetProductValue
* Returns: Total monetary value of current stock
* Calculation: unit price × stock count
*/
METHOD GetProductValue() CLASS CProduct
RETURN ::nUnitPrice * ::nStockCount

/* === Demonstration Code === */
PROCEDURE Main()

   LOCAL oLaptop   AS OBJECT
   LOCAL oMouse    AS OBJECT

   QOut( "--- Creating Products ---" )
   // Create a laptop object using the constructor
   oLaptop := CProduct():New( "LP-001", "Gaming Laptop", 1500.00, 10 )
   QOut( "Laptop Created: " + oLaptop:GetProductName() + ", Stock: " + LTrim( Str( oLaptop:GetStockCount() ) ) )

   // Create a mouse object with initial invalid values to show validation
   oMouse := cProduct():New( "MS-001", "Wireless Mouse", -5.00, 5 ) // Invalid price
   QOut( "Mouse Created: " + oMouse:GetProductName() + ", Stock: " + LTrim( Str( oMouse:GetStockCount() ) ) )

   QOut( "" )
   QOut( "--- Encapsulation in Action ---" )

   // Attempt to set an invalid name (setter will reject)
   QOut( "Attempting to set invalid laptop name..." )
   oLaptop:SetProductName( "" ) // This will trigger the validation error
   QOut( "Laptop Name (after invalid attempt): " + oLaptop:GetProductName() )

   // Successfully update name via setter
   QOut( "Setting valid laptop name..." )
   oLaptop:SetProductName( "High-Performance Laptop" )
   QOut( "Laptop Name (after valid attempt): " + oLaptop:GetProductName() )

   // --- Business Operations (using methods) ---
   QOut( "" )
   QOut( "--- Performing Stock Operations ---" )

   // Sell some laptops
   oLaptop:Sell( 3 ) // Valid sale
   oLaptop:Sell( 10 ) // Insufficient stock

   // Purchase more mice
   oMouse:Purchase( 20 ) // Purchase more stock for mouse

   // Get product values
   QOut( "" )
   QOut( "--- Product Valuations ---" )
   QOut( "Laptop Value: " + LTrim( Str( oLaptop:GetProductValue(), 10, 2 ) ) )
   QOut( "Mouse Value: " + LTrim( Str( oMouse:GetProductValue(), 10, 2 ) ) )

RETURN NIL
```
## ✅ Overview

This code defines a class `cProduct
` that encapsulates **product-related data** and business logic in an inventory context. It is structured around object-oriented principles with **strict visibility rules** (all attributes are `HIDDEN`), making it a clean example of **encapsulation** and **domain modeling**.

---

## 🔒 Class: `cProduct
`

```harbour
CLASS cProduct

```

This class models a **product** with four key attributes:

### 👁️ Visibility: All `HIDDEN`

This means **no external code** can directly access the internal variables. Access is only allowed through **methods**.

```harbour
VAR cProduct
ID   AS CHARACTER  HIDDEN
VAR cProduct
Name AS CHARACTER  HIDDEN
VAR nUnitPrice   AS NUMERIC    HIDDEN
VAR nStockCount  AS NUMERIC    HIDDEN
```

| Variable       | Type    | Description               |
| -------------- | ------- | ------------------------- |
| `cProduct
ID`   | String  | Unique product identifier |
| `cProduct
Name` | String  | Descriptive product name  |
| `nUnitPrice`   | Numeric | Unit price of product     |
| `nStockCount`  | Numeric | Quantity in stock         |

---

## 🏗️ Constructor: `New()`

```harbour
METHOD New( cID, cName, nPrice, nStock ) CLASS cProduct

```

Uses **setters** to initialize the product to ensure **validation** rules are applied (e.g. price must be positive, name non-empty). This helps maintain a **valid object state** from the beginning.

---

## 🔎 Accessor Methods (Getters)

These methods provide **read-only access** to private attributes.

```harbour
METHOD GetProductID()
METHOD GetProductName()
METHOD GetUnitPrice()
METHOD GetStockCount()
```

---

## 🛠️ Mutator Methods (Setters)

Each setter method:

* Validates inputs
* Assigns only if valid
* Otherwise, prints an error message

### Examples:

```harbour
METHOD SetProductID( cNewID )
   IF ! Empty( cNewID ) .AND. Len( cNewID ) <= 20
```

```harbour
METHOD SetUnitPrice( nNewPrice )
   IF ValType( nNewPrice ) == 'N' .AND. nNewPrice >= 0
```

These validations prevent corrupt or invalid data from entering the object.

---

## 📦 Business Logic Methods

### 📥 `Purchase( nQuantity )`

* Adds stock
* Requires a **positive number**
* Outputs confirmation message

```harbour
::nStockCount += nQuantity
```

### 📤 `Sell( nQuantity )`

* Deducts stock
* Requires:

  * Positive number
  * Sufficient stock
* Prevents negative inventory

```harbour
IF ::nStockCount >= nQuantity
```

### 💰 `GetProductValue()`

* Calculates total stock value:

```harbour
RETURN ::nUnitPrice * ::nStockCount
```

---

## 🧪 Main Procedure: `Main()`

### 🔧 Creating Product Instances

```harbour
oLaptop := cProduct
():New( "LP-001", "Gaming Laptop", 1500.00, 10 )
```

Creates a valid product with:

* ID: `"LP-001"`
* Name: `"Gaming Laptop"`
* Price: 1500
* Stock: 10

```harbour
oMouse := cProduct
():New( "MS-001", "Wireless Mouse", -5.00, 5 )
```

This mouse has an **invalid price**, so the setter prints a warning and refuses to assign the price.

---

### 🚫 Encapsulation in Action

```harbour
oLaptop:SetProductName( "" )  // Will trigger error
```

Enforces that names cannot be empty.

```harbour
oLaptop:SetProductName( "High-Performance Laptop" )
```

This updates the name successfully.

---

### 📦 Inventory Operations

```harbour
oLaptop:Sell( 3 )   // Succeeds
oLaptop:Sell( 10 )  // Fails due to insufficient stock
```

```harbour
oMouse:Purchase( 20 )  // Increases stock
```

---

### 💲 Product Valuation

```harbour
QOut( "Laptop Value: " + LTrim( Str( oLaptop:GetProductValue(), 10, 2 ) ) )
```

Calculates the **total value of inventory** for each product:

```plaintext
unit price × stock count
```

---

## ✅ Key OOP Concepts Used

| Concept                    | Implementation                                        |
| -------------------------- | ----------------------------------------------------- |
| **Encapsulation**          | All variables are `HIDDEN`, accessed only via methods |
| **Validation**             | All setters include strict checks                     |
| **Separation of Concerns** | Business logic is separate from data access           |
| **Reusability**            | Same class works for any product                      |
| **Error Reporting**        | Uses `QOut()` for validation feedback                 |

---

## 🧩 Design Pattern

* Follows the **Domain Model Pattern** — the object represents real-world product behavior
* Includes **Active Record-like** behavior — the object encapsulates both **data and logic**

---

## 🔚 Summary

This class offers a **robust model** for managing product inventory in a Harbour-based system. Its strong use of encapsulation and validation makes it:

✅ Safe
✅ Maintainable
✅ Scalable

It would be a great base for a full inventory or point-of-sale (POS) system.

---
