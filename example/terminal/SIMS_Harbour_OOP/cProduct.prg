#include "hbclass.ch"

/**
 * Product entity class
 * Encapsulates product attributes and business logic
 */
CLASS CProduct
   VAR nID       AS NUMERIC   PROTECTED   /**< Unique product identifier */
   VAR cName     AS CHARACTER PROTECTED   /**< Product name/description */
   VAR nPrice    AS NUMERIC   PROTECTED   /**< Unit price (numeric value) */
   VAR nStock    AS NUMERIC   PROTECTED   /**< Current inventory quantity */

   /**
    * Product constructor
    * @param nID Product ID
    * @param cName Product name
    * @param nPrice Unit price
    * @param nStock Initial stock quantity
    */
   METHOD New( nID, cName, nPrice, nStock )

   /** @return Product ID (numeric) */
   METHOD GetID()     INLINE ::nID

   /** @return Product name (string) */
   METHOD GetName()   INLINE ::cName

   /** @return Current unit price (numeric) */
   METHOD GetPrice()  INLINE ::nPrice

   /** @return Current stock quantity (numeric) */
   METHOD GetStock()  INLINE ::nStock

   /**
    * Updates product price with validation
    * @param nNewPrice New price value
    */
   METHOD SetPrice( nNewPrice )

   /**
    * Updates stock quantity with validation
    * @param nNewStock New stock value
    */
   METHOD SetStock( nNewStock )

   /**
    * Adjusts stock by relative amount
    * @param nDelta Quantity to add/subtract
    */
   METHOD AdjustStock( nDelta )

ENDCLASS

/**
 * Constructs new product instance
 * @param nID Unique product identifier
 * @param cName Descriptive product name
 * @param nPrice Unit price
 * @param nStock Initial inventory quantity
 * @return self reference
 */
METHOD New( nID, cName, nPrice, nStock ) CLASS CProduct
   ::nID    := nID      // Set product ID
   ::cName  := cName    // Set product name
   ::nPrice := nPrice   // Set unit price
   ::nStock := nStock   // Set initial stock
RETURN Self

/**
 * Updates product price with type validation
 * @param nNewPrice New price value (must be numeric)
 * @return NIL
 */
METHOD SetPrice( nNewPrice ) CLASS CProduct
   // Only update if parameter is numeric
   IF ValType( nNewPrice ) == "N"
      ::nPrice := nNewPrice
   ENDIF
RETURN NIL

/**
 * Updates stock quantity with type validation
 * @param nNewStock New stock value (must be numeric)
 * @return NIL
 */
METHOD SetStock( nNewStock ) CLASS CProduct
   // Only update if parameter is numeric
   IF ValType( nNewStock ) == "N"
      ::nStock := nNewStock
   ENDIF
RETURN NIL

/**
 * Adjusts inventory by relative amount
 * @param nDelta Positive/Negative quantity adjustment
 * @return NIL
 */
METHOD AdjustStock( nDelta ) CLASS CProduct
   ::nStock += nDelta  // Apply stock delta
RETURN NIL
