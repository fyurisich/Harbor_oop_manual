#include "hbclass.ch"
REQUEST DBFCDX  // Required for DBFCDX RDD support

/**
 * Main application entry point
 *
 * Initializes the inventory management system with proper environment settings,
 * verifies database existence, and launches the application menu.
 *
 * Key responsibilities:
 * - Sets up runtime environment
 * - Ensures database file exists
 * - Initializes application controller
 * - Starts main application loop
 *
 * @return void
 */
PROCEDURE main()

   // Create application controller instance
   LOCAL oApp := CAppManager():New()

   // Configure runtime environment
   SET CENTURY ON        // Enable 4-digit year display
   SET MESSAGE TO 24 CENTER  // Set message display at row 24, centered
   SET WRAP ON           // Enable menu wrapping

   // Set database driver
   dbSetDriver( "DBFCDX" )  // Use DBFCDX as default RDD

   // Verify database existence
   IF ! File( "products.dbf" )
      CreateProductTable()  // Initialize database structure if missing
   ENDIF

   // Launch application main menu
   oApp:MainMenu()

RETURN
