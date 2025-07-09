#include "hbclass.ch"
#include "dbstruct.ch"

/**
 * Inventory management class
 * Handles product storage and retrieval from DBF files
 */
CLASS CInventory
   VAR aProducts   AS ARRAY PROTECTED  /**< Internal array storing product objects */
   VAR cDbfName    AS CHARACTER        /**< DBF filename for persistent storage */

   /**
    * Constructor - initializes inventory
    */
   METHOD New()

   /**
    * Loads products from DBF file into memory
    */
   METHOD LoadFromDbf()

   /**
    * Saves in-memory products to DBF file
    */
   METHOD SaveToDbf()

   /**
    * Adds a new product to inventory
    * @param oProduct Product object to add
    */
   METHOD AddProduct( oProduct )

   /**
    * Finds product by ID
    * @param nID Product ID to search for
    * @return Product object or NIL if not found
    */
   METHOD FindProductByID( nID )

   /**
    * Updates existing product information
    * @param oProduct Product object with updated data
    */
   METHOD UpdateProduct( oProduct )

   /**
    * Removes product from inventory
    * @param nID ID of product to delete
    */
   METHOD DeleteProduct( nID )

   /**
    * Displays all products in console
    */
   METHOD ListProducts()

ENDCLASS

/**
 * Initializes new inventory instance
 * @return self reference
 */
METHOD New() CLASS CInventory
   ::cDbfName  := "products.dbf"  // Default DBF filename
   ::aProducts := {}              // Initialize empty product array
   ::LoadFromDbf()                // Load existing data
RETURN Self

/**
 * Loads products from DBF into memory array
 * @return NIL
 */
METHOD LoadFromDbf() CLASS CInventory
   LOCAL nRec, nLast
   LOCAL oProd

   // Check if DBF file exists
   IF ! File( ::cDbfName )
      RETURN NIL
   ENDIF

   // Open DBF in shared mode
   USE ( ::cDbfName ) SHARED NEW
   nLast := LastRec()  // Get total records

   // Process each record
   FOR nRec := 1 TO nLast
      IF !Deleted()  // Skip deleted records
         // Create product object from DBF fields
         oProd := cProduct():New( ID, NAME, PRICE, STOCK )
         AAdd( ::aProducts, oProd )  // Add to memory array
      ENDIF
      dbSkip()  // Move to next record
   NEXT
   USE  // Close DBF
RETURN NIL

/**
 * Persists in-memory products to DBF file
 * @return NIL
 */
METHOD SaveToDbf() CLASS CInventory
   LOCAL oProd, i

   // Open DBF exclusively for writing
   USE ( ::cDbfName ) ALIAS invent NEW EXCLUSIVE
   dbSetOrder( 1 )  // Set primary index
   ZAP  // Clear existing data

   // Write all products to DBF
   FOR i := 1 TO Len( ::aProducts )
      oProd := ::aProducts[ i ]

      // Check for duplicate IDs
      IF invent->(!DBSEEK( oProd:GetID() ))
         APPEND BLANK  // Add new record
            // Update fields with product data
            REPLACE ID    WITH oProd:GetID()
            REPLACE NAME  WITH oProd:GetName()
            REPLACE PRICE WITH oProd:GetPrice()
            REPLACE STOCK WITH oProd:GetStock()
      ENDIF
   NEXT
   USE  // Close DBF

RETURN NIL

/**
 * Adds product to inventory and saves to DBF
 * @param oProduct Product object to add
 * @return NIL
 */
METHOD AddProduct( oProduct ) CLASS CInventory
   AAdd( ::aProducts, oProduct )  // Add to memory array
   ::SaveToDbf()                  // Persist changes
RETURN NIL

/**
 * Locates product by ID using linear search
 * @param nID Product ID to find
 * @return Product object or NIL
 */
METHOD FindProductByID( nID ) CLASS CInventory
   LOCAL oProd

   // Iterate through products
   FOR EACH oProd IN ::aProducts
      IF oProd:GetID() == nID
         RETURN oProd  // Return matching product
      ENDIF
   NEXT

RETURN NIL  // Return NIL if not found

/**
 * Updates existing product data
 * @param oProduct Product object with new data
 * @return NIL
 */
METHOD UpdateProduct( oProduct ) CLASS CInventory
   LOCAL i, oOld

   // Find and replace product by ID
   FOR i := 1 TO Len( ::aProducts )
      oOld := ::aProducts[ i ]
      IF oOld:GetID() == oProduct:GetID()
         ::aProducts[ i ] := oProduct  // Update in memory
         EXIT
      ENDIF
   NEXT
   ::SaveToDbf()  // Persist changes

RETURN NIL

/**
 * Removes product from inventory
 * @param nID ID of product to remove
 * @return NIL
 */
METHOD DeleteProduct( nID ) CLASS CInventory
   LOCAL i, oProd

   // Search backwards for safe array manipulation
   FOR i := Len( ::aProducts ) TO 1 STEP -1
      oProd := ::aProducts[ i ]

      IF oProd:GetID() == nID
         ADel( ::aProducts, i )  // Remove from array
         ASize( ::aProducts, Len( ::aProducts ) - 1 )  // Resize array
         EXIT
      ENDIF
   NEXT
   ::SaveToDbf()  // Persist changes

RETURN NIL

/**
 * Displays all products in console
 * @return NIL
 */
METHOD ListProducts() CLASS CInventory
   LOCAL oProd

   IF Len( ::aProducts ) == 0
      ? "There are no records"  // Empty inventory message
      Inkey(1)                 // Brief pause
   ELSE
      // Display each product's details
      FOR EACH oProd IN ::aProducts
         ? "ID:", oProd:GetID(), "Name:", oProd:GetName(), ;
           "Price:", oProd:GetPrice(), "Stock:", oProd:GetStock()
      NEXT
   ENDIF

RETURN NIL

