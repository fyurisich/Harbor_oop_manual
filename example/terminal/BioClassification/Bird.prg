/**
 * Class for birds
 * class Bird
 * extends Vertebrate
 */

#include "hbclass.ch"

CLASS Bird FROM Vertebrate
   DATA wingspan
   DATA beakType
   DATA canFly
   DATA warmBlooded INIT .T.

   METHOD New( cName, cSciName, nLifespan, cHabitat, nWingspan, cBeakType, lCanFly ) CONSTRUCTOR
   METHOD displayInfo()
   METHOD reproduce()
   METHOD move()
   METHOD InputData()
ENDCLASS

/**
 * Constructor for Bird
 * method New
 * param {string} cName Common name
 * param {string} cSciName Scientific name
 * param {number} nLifespan Lifespan in years
 * param {string} cHabitat Habitat
 * param {number} nWingspan Wingspan in meters
 * param {string} cBeakType Type of beak
 * param {boolean} lCanFly Ability to fly
 * returns {Self}
 */
METHOD New( cName, cSciName, nLifespan, cHabitat, nWingspan, cBeakType, lCanFly ) CLASS Bird
   ::Super:New( cName, cSciName, nLifespan, cHabitat )
   ::wingspan := nWingspan
   ::beakType := cBeakType
   ::canFly := lCanFly
RETURN Self

/**
 * Returns formatted bird information
 * method displayInfo
 * returns {string}
 */
METHOD displayInfo() CLASS Bird
RETURN ::Super:displayInfo() + ", Wingspan: " + Str( ::wingspan ) + "m, Beak: " + ::beakType + ", Can Fly: " + IIF( ::canFly, "Yes", "No" )

/**
 * Returns bird reproduction description
 * method reproduce
 * returns {string}
 */
METHOD reproduce() CLASS Bird
RETURN ::name + " lays eggs."

/**
 * Returns bird movement description
 * method move
 * returns {string}
 */
METHOD move() CLASS Bird
RETURN ::name + IIF( ::canFly, " flies.", " walks.")

/**
 * Handles input of bird-specific data
 * method InputData
 * returns {boolean} True if data entered successfully, False otherwise
 */
METHOD InputData() CLASS Bird

   LOCAL nWingspan := 0, cBeakType := Space(50), lCanFly := .T.

   IF ::Super:InputData()
      @ 7, 1 SAY "Wingspan (meters): " GET nWingspan
      @ 8, 1 SAY "Beak Type: " GET cBeakType
      @ 9, 1 SAY "Can Fly (Y/N): " GET lCanFly PICTURE "Y"
      READ
      IF !Empty( cBeakType )
         ::wingspan := nWingspan
         ::beakType := AllTrim( cBeakType )
         ::canFly := lCanFly
         RETURN .T.
      ENDIF
   ENDIF

RETURN .F.
