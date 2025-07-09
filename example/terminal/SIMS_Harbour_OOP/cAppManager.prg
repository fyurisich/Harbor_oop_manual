#include "hbclass.ch"
#include "inkey.ch"
#include "box.ch"

/**
 * Application Controller Class
 * Manages the inventory system user interface and workflow
 */
CLASS CAppManager
   VAR oInventory AS OBJECT  /**< Inventory management instance */

   /**
    * Constructor - initializes application components
    */
   METHOD New()

   /**
    * Displays and handles main application menu
    */
   METHOD MainMenu()

   /**
    * Handles product creation workflow
    */
   METHOD AddProduct()

   /**
    * Displays product details
    */
   METHOD ViewProduct()

   /**
    * Handles product updates
    */
   METHOD UpdateProduct()

   /**
    * Processes sales transactions
    */
   METHOD RecordSale()

   /**
    * Processes purchase transactions
    */
   METHOD RecordPurchase()

   /**
    * Lists all inventory items
    */
   METHOD ListAllProducts()

ENDCLASS

/**
 * Initializes application manager
 * @return self reference
 */
METHOD New() CLASS CAppManager
   ::oInventory := cInventory():New()  // Create inventory instance
RETURN Self

/**
 * Main application menu loop
 * @return NIL
 */
METHOD MainMenu() CLASS CAppManager
   LOCAL nChoice := 0  // Menu selection storage

   DO WHILE .T.  // Infinite loop until exit
      CLS
      // Draw menu box and options
      @01,09,10,50 BOX B_DOUBLE_SINGLE
      @02,10 SAY "Simple Inventory Management System"
      @03,12 PROMPT  "Add Product"       MESSAGE ""
      @04,12 PROMPT  "View Product"
      @05,12 PROMPT  "Update Product"
      @06,12 PROMPT  "Record Sale"
      @07,12 PROMPT  "Record Purchase"
      @08,12 PROMPT  "List All Products"
      @09,12 PROMPT  "Exit"
      MENU TO nChoice  // Get user selection

      // Process menu choice
      DO CASE
            CASE nChoice == 1
                ::AddProduct()
            CASE nChoice == 2
                ::ViewProduct()
            CASE nChoice == 3
                ::UpdateProduct()
            CASE nChoice == 4
                ::RecordSale()
            CASE nChoice == 5
                ::RecordPurchase()
            CASE nChoice == 6
                ::ListAllProducts()
            CASE nChoice == 7
                EXIT  // Break loop
            OTHERWISE
                ? "Invalid option!"
                Inkey(1)  // Brief pause
      ENDCASE
   ENDDO
RETURN NIL

/**
 * Product creation interface
 * @return NIL
 */
METHOD AddProduct() CLASS CAppManager
   LOCAL id    := 0      // Product ID
   LOCAL name  := Space(40)  // Product name
   LOCAL price := 0.00   // Unit price
   LOCAL stock := 0      // Initial stock
   LOCAL oProd           // Product object

   // Display input form
   CLS
   @01,08,07,60 BOX B_DOUBLE_SINGLE
   @02,10 SAY "Enter product data"
   @03,10 SAY "ID    : " GET id    PICTURE "999999"      RANGE 1,100000
   @04,10 SAY "Name  : " GET name  PICTURE "@!"
   @05,10 SAY "Price : " GET price PICTURE "999,999.99"  RANGE 1,100000.99
   @06,10 SAY "Stock : " GET stock PICTURE "999,999,999" RANGE 1,100000000
   READ  // Get user input

   // Create product instance
   oProd := cProduct():New( id, name, price, stock )

   // Validate and save
   IF EMPTY(id) .AND. EMPTY(name) .AND. EMPTY(price) .AND. EMPTY(stock)
      ? "Not all data is complete, record not created"
   ELSE
      ::oInventory:AddProduct( oProd )
      ? "Product added!"
   ENDIF
   Inkey(1)  // Pause before returning
RETURN NIL

/**
 * Product detail viewer
 * @return NIL
 */
METHOD ViewProduct() CLASS CAppManager
   LOCAL id    := 0      // Product ID to find
   LOCAL oProd           // Found product object

   // Display search form
   CLS
   @01,08,03,30 BOX B_DOUBLE_SINGLE
   @02,10 SAY "Product ID: " GET id PICTURE "999999"
   READ  // Get search criteria

   // Retrieve and display product
   oProd := ::oInventory:FindProductByID( id )
   IF oProd != NIL
      ? "Name:", oProd:GetName(), "Price:", oProd:GetPrice(), "Stock:", oProd:GetStock()
   ELSE
      ? "Product not found."
   ENDIF
   Inkey(0)  // Wait for keypress
RETURN NIL

/**
 * Product information updater
 * @return NIL
 */
METHOD UpdateProduct() CLASS CAppManager
   LOCAL id    := 0      // Product ID
   LOCAL price := 0      // New price
   LOCAL stock := 0      // New stock
   LOCAL oProd           // Product object

   // Display update form
   CLS
   @01,08,05,40 BOX B_DOUBLE_SINGLE
   @02,10 SAY "Product ID : " GET  id    PICTURE "999999"      RANGE 1,999999
   @03,10 SAY "New Price  : " GET  price PICTURE "999,999.99"  RANGE 1,999999.99
   @04,10 SAY "New Stock  : " GET  stock PICTURE "999,999,999" RANGE 1,999999999
   READ  // Get update values

   // Find and update product
   oProd := ::oInventory:FindProductByID( id )
   IF oProd != NIL
      oProd:SetPrice( price )
      oProd:SetStock( stock )
      ::oInventory:UpdateProduct( oProd )
      ? "Updated."
   ELSE
      ? "Not found."
   ENDIF
   Inkey(1)  // Brief pause
RETURN NIL

/**
 * Sales transaction processor
 * @return NIL
 */
METHOD RecordSale() CLASS CAppManager
   LOCAL id    :=  0     // Product ID
   LOCAL qty   :=  0     // Quantity sold
   LOCAL oProd           // Product object

   // Display sales form
   CLS
   @01,08,04,40 BOX B_DOUBLE_SINGLE
   @02,10 SAY  "Product ID    : " GET id
   @03,10 SAY  "Quantity Sold : " GET qty
   READ  // Get transaction data

   // Process sale
   oProd := ::oInventory:FindProductByID( id )
   IF oProd != NIL
      oProd:AdjustStock( -qty )  // Reduce stock
      ::oInventory:UpdateProduct( oProd )
      ? "Stock updated."
   ELSE
      ? "Product not found."
   ENDIF
   Inkey(1)  // Brief pause
RETURN NIL

/**
 * Purchase transaction processor
 * @return NIL
 */
METHOD RecordPurchase() CLASS CAppManager
   LOCAL id  := 0        // Product ID
   LOCAL qty := 0        // Quantity purchased
   LOCAL oProd           // Product object

   // Display purchase form
   CLS
   @01,08,04,45 BOX B_DOUBLE_SINGLE
   @02,10 SAY "Product ID         : " GET id
   @03,10 SAY "Quantity Purchased : " GET qty
   READ  // Get transaction data

   // Process purchase
   oProd := ::oInventory:FindProductByID( id )
   IF oProd != NIL
      oProd:AdjustStock( qty )  // Increase stock
      ::oInventory:UpdateProduct( oProd )
      ? "Stock updated."
   ELSE
      ? "Product not found."
   ENDIF
   Inkey(1)  // Brief pause
RETURN NIL

/**
 * Full inventory lister
 * @return NIL
 */
METHOD ListAllProducts() CLASS CAppManager
   ::oInventory:ListProducts()  // Delegate to inventory
   Inkey(0)  // Wait for keypress
RETURN NIL

/**
 * Utility function for simple input
 * @param cPrompt Prompt to display
 * @return User input value
 */
STATIC FUNCTION Input( cPrompt )
   LOCAL cVal  // Input storage
   @ ROW(),0 SAY cPrompt get cVal
   READ
RETURN cVal
