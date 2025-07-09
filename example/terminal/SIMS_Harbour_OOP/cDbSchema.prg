/**
 * Creates the product database table structure
 *
 * This procedure initializes the physical database file (DBF) with the required
 * structure for product storage. It creates:
 * - ID field as numeric identifier
 * - NAME field for product description
 * - PRICE field with decimal precision
 * - STOCK field for inventory tracking
 *
 * Additionally creates a unique index on the ID field to enforce data integrity.
 *
 * @return void
 */
PROCEDURE CreateProductTable()

   // Define DBF structure array
   // Format: {FieldName, FieldType, FieldLength, DecimalPlaces}
   LOCAL aStruct := {{ "ID",    "N", 6, 0 },;    // Numeric ID (6 digits, 0 decimals)
                     { "NAME",  "C", 40, 0 },;   // Character name (40 chars)
                     { "PRICE", "N", 10, 2 },;   // Numeric price (10 digits, 2 decimals)
                     { "STOCK", "N", 10, 0 }}    // Numeric stock (10 digits)

   // Create physical DBF file with defined structure
   DBCreate( "products.dbf", aStruct )

   // Open the newly created table
   USE products NEW SHARED
      // Create unique index on ID field to prevent duplicates
      INDEX ON id TAG id UNIQUE
   DbCloseArea()

   // Provide user feedback
   ? "Table 'products.dbf' created."

RETURN
