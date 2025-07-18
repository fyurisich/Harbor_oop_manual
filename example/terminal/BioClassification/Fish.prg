/**
 * Class for fish
 * class Fish
 * extends Vertebrate
 */

#include "hbclass.ch"

CLASS Fish FROM Vertebrate
   DATA finCount
   DATA gillType
   DATA waterType

   METHOD New( cName, cSciName, nLifespan, cHabitat, nFinCount, cGillType, cWaterType ) CONSTRUCTOR
   METHOD displayInfo()
   METHOD reproduce()
   METHOD move()
   METHOD InputData()
ENDCLASS

/**
 * Constructor for Fish
 * method New
 * param {string} cName Common name
 * param {string} cSciName Scientific name
 * param {number} nLifespan Lifespan in years
 * param {string} cHabitat Habitat
 * param {number} nFinCount Number of fins
 * param {string} cGillType Type of gills
 * param {string} cWaterType Type of water habitat
 * returns {Self}
 */
METHOD New( cName, cSciName, nLifespan, cHabitat, nFinCount, cGillType, cWaterType ) CLASS Fish
   ::Super:New( cName, cSciName, nLifespan, cHabitat )
   ::finCount := nFinCount
   ::gillType := cGillType
   ::waterType := cWaterType
RETURN Self

/**
 * Returns formatted fish information
 * method displayInfo
 * returns {string}
 */
METHOD displayInfo() CLASS Fish
RETURN ::Super:displayInfo() + ", Fins: " + Str( ::finCount ) + ", Gills: " + ::gillType + ", Water: " + ::waterType

/**
 * Returns fish reproduction description
 * method reproduce
 * returns {string}
 */
METHOD reproduce() CLASS Fish
RETURN ::name + " lays eggs in " + ::waterType + " water."

/**
 * Returns fish movement description
 * method move
 * returns {string}
 */
METHOD move() CLASS Fish
RETURN ::name + " swims."

/**
 * Handles input of fish-specific data
 * method InputData
 * returns {boolean} True if data entered successfully, False otherwise
 */
METHOD InputData() CLASS Fish

   LOCAL nFinCount := 0, cGillType := Space(50), cWaterType := Space(50)

   IF ::Super:InputData()
      @ 7, 1 SAY "Fin Count: " GET nFinCount
      @ 8, 1 SAY "Gill Type: " GET cGillType
      @ 9, 1 SAY "Water Type: " GET cWaterType
      READ
      IF !Empty( cGillType )
         ::finCount := nFinCount
         ::gillType := AllTrim( cGillType )
         ::waterType := AllTrim( cWaterType )
         RETURN .T.
      ENDIF
   ENDIF

RETURN .F.
