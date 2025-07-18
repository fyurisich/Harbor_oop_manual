/**
 * Class for platypus with multiple inheritance
 * class Platypus
 * extends Mammal
 * extends Bird
 */

#include "hbclass.ch"

CLASS Platypus FROM Mammal, Bird
   METHOD New( cName, cSciName, nLifespan, cHabitat, cFurType, nGestation, nWingspan, cBeakType, lCanFly ) CONSTRUCTOR
   METHOD displayInfo()
   METHOD reproduce()
   METHOD move()
   METHOD InputData()
ENDCLASS

/**
 * Constructor for Platypus
 * method New
 * param {string} cName Common name
 * param {string} cSciName Scientific name
 * param {number} nLifespan Lifespan in years
 * param {string} cHabitat Habitat
 * param {string} cFurType Type of fur
 * param {number} nGestation Gestation period in months
 * param {number} nWingspan Wingspan in meters
 * param {string} cBeakType Type of beak
 * param {boolean} lCanFly Ability to fly
 * returns {Self}
 */
METHOD New( cName, cSciName, nLifespan, cHabitat, cFurType, nGestation, nWingspan, cBeakType, lCanFly ) CLASS Platypus
   ::Mammal:New( cName, cSciName, nLifespan, cHabitat, cFurType, nGestation )
   ::Bird:New( cName, cSciName, nLifespan, cHabitat, nWingspan, cBeakType, lCanFly )
RETURN Self

/**
 * Returns formatted platypus information
 * method displayInfo
 * returns {string}
 */
METHOD displayInfo() CLASS Platypus
RETURN ::Mammal:displayInfo() + ", Beak: " + ::beakType + ", Can Swim: Yes"

/**
 * Returns platypus reproduction description
 * method reproduce
 * returns {string}
 */
METHOD reproduce() CLASS Platypus
RETURN ::name + " lays eggs, unique for a mammal."

/**
 * Returns platypus movement description
 * method move
 * returns {string}
 */
METHOD move() CLASS Platypus
RETURN ::name + " swims and walks."

/**
 * Handles input of platypus-specific data
 * method InputData
 * returns {boolean} True if data entered successfully, False otherwise
 */
METHOD InputData() CLASS Platypus

   LOCAL cFurType := Space(50), nGestation := 0, nWingspan := 0, cBeakType := Space(50), lCanFly := .F.

   IF ::Mammal:InputData()
      @ 9, 1 SAY "Wingspan (meters): " GET nWingspan
      @ 10, 1 SAY "Beak Type: " GET cBeakType
      READ
      IF !Empty( cBeakType )
         ::furType := AllTrim( cFurType )
         ::gestationPeriod := nGestation
         ::wingspan := nWingspan
         ::beakType := AllTrim( cBeakType )
         ::canFly := lCanFly
         RETURN .T.
      ENDIF
   ENDIF

RETURN .F.
