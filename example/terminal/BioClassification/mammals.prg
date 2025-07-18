/**
 * Class for mammals
 * class Mammal
 * extends Vertebrate
 */

#include "hbclass.ch"

CLASS Mammal FROM Vertebrate
   DATA furType
   DATA gestationPeriod
   DATA warmBlooded INIT .T.

   METHOD New( cName, cSciName, nLifespan, cHabitat, cFurType, nGestation ) CONSTRUCTOR
   METHOD displayInfo()
   METHOD reproduce()
   METHOD move()
   METHOD InputData()
ENDCLASS

/**
 * Constructor for Mammal
 * method New
 * param {string} cName Common name
 * param {string} cSciName Scientific name
 * param {number} nLifespan Lifespan in years
 * param {string} cHabitat Habitat
 * param {string} cFurType Type of fur
 * param {number} nGestation Gestation period in months
 * returns {Self}
 */
METHOD New( cName, cSciName, nLifespan, cHabitat, cFurType, nGestation ) CLASS Mammal
   ::Super:New( cName, cSciName, nLifespan, cHabitat )
   ::furType := cFurType
   ::gestationPeriod := nGestation
RETURN Self

/**
 * Returns formatted mammal information
 * method displayInfo
 * returns {string}
 */
METHOD displayInfo() CLASS Mammal
RETURN ::Super:displayInfo() + ", Fur: " + ::furType + ", Gestation: " + Str( ::gestationPeriod ) + " months"

/**
 * Returns mammal reproduction description
 * method reproduce
 * returns {string}
 */
METHOD reproduce() CLASS Mammal
RETURN ::name + " gives live birth after " + Str( ::gestationPeriod ) + " months."

/**
 * Returns mammal movement description
 * method move
 * returns {string}
 */
METHOD move() CLASS Mammal
RETURN ::name + " walks or runs on land."

/**
 * Handles input of mammal-specific data
 * method InputData
 * returns {boolean} True if data entered successfully, False otherwise
 */
METHOD InputData() CLASS Mammal

   LOCAL cFurType := Space(50), nGestation := 0

   IF ::Super:InputData()
      @ 7, 1 SAY "Fur Type: " GET cFurType
      @ 8, 1 SAY "Gestation Period (months): " GET nGestation
      READ
      IF !Empty( cFurType )
         ::furType := AllTrim( cFurType )
         ::gestationPeriod := nGestation
         RETURN .T.
      ENDIF
   ENDIF

RETURN .F.
