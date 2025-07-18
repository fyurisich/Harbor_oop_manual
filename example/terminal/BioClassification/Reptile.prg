/**
 * Class for reptiles
 * class Reptile
 * extends Vertebrate
 */

#include "hbclass.ch"

CLASS Reptile FROM Vertebrate
   DATA scaleType
   DATA eggType
   DATA warmBlooded INIT .F.

   METHOD New( cName, cSciName, nLifespan, cHabitat, cScaleType, cEggType ) CONSTRUCTOR
   METHOD displayInfo()
   METHOD reproduce()
   METHOD move()
   METHOD InputData()
ENDCLASS

/**
 * Constructor for Reptile
 * method New
 * param {string} cName Common name
 * param {string} cSciName Scientific name
 * param {number} nLifespan Lifespan in years
 * param {string} cHabitat Habitat
 * param {string} cScaleType Type of scales
 * param {string} cEggType Type of eggs
 * returns {Self}
 */
METHOD New( cName, cSciName, nLifespan, cHabitat, cScaleType, cEggType ) CLASS Reptile
   ::Super:New( cName, cSciName, nLifespan, cHabitat )
   ::scaleType := cScaleType
   ::eggType := cEggType
RETURN Self

/**
 * Returns formatted reptile information
 * method displayInfo
 * returns {string}
 */
METHOD displayInfo() CLASS Reptile
RETURN ::Super:displayInfo() + ", Scales: " + ::scaleType + ", Egg Type: " + ::eggType

/**
 * Returns reptile reproduction description
 * method reproduce
 * returns {string}
 */
METHOD reproduce() CLASS Reptile
RETURN ::name + " lays " + ::eggType + " eggs."

/**
 * Returns reptile movement description
 * method move
 * returns {string}
 */
METHOD move() CLASS Reptile
RETURN ::name + " crawls."

/**
 * Handles input of reptile-specific data
 * method InputData
 * returns {boolean} True if data entered successfully, False otherwise
 */
METHOD InputData() CLASS Reptile

   LOCAL cScaleType := Space(50), cEggType := Space(50)

   IF ::Super:InputData()
      @ 7, 1 SAY "Scale Type: " GET cScaleType
      @ 8, 1 SAY "Egg Type: " GET cEggType
      READ
      IF !Empty( cScaleType )
         ::scaleType := AllTrim( cScaleType )
         ::eggType := AllTrim( cEggType )
         RETURN .T.
      ENDIF
   ENDIF

RETURN .F.
