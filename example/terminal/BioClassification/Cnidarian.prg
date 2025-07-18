/**
 * Class for cnidarians
 * class Cnidarian
 * extends Invertebrate
 */

#include "hbclass.ch"

CLASS Cnidarian FROM Invertebrate
   DATA tentacleCount
   DATA stingSeverity

   METHOD New( cName, cSciName, nLifespan, cHabitat, nTentacleCount, cStingSeverity ) CONSTRUCTOR
   METHOD displayInfo()
   METHOD reproduce()
   METHOD move()
   METHOD InputData()
ENDCLASS

/**
 * Constructor for Cnidarian
 * method New
 * param {string} cName Common name
 * param {string} cSciName Scientific name
 * param {number} nLifespan Lifespan in years
 * param {string} cHabitat Habitat
 * param {number} nTentacleCount Number of tentacles
 * param {string} cStingSeverity Severity of sting
 * returns {Self}
 */
METHOD New( cName, cSciName, nLifespan, cHabitat, nTentacleCount, cStingSeverity ) CLASS Cnidarian
   ::Super:New( cName, cSciName, nLifespan, cHabitat )
   ::tentacleCount := nTentacleCount
   ::stingSeverity := cStingSeverity
RETURN Self

/**
 * Returns formatted cnidarian information
 * method displayInfo
 * returns {string}
 */
METHOD displayInfo() CLASS Cnidarian
RETURN ::Super:displayInfo() + ", Tentacles: " + Str( ::tentacleCount ) + ", Sting: " + ::stingSeverity

/**
 * Returns cnidarian reproduction description
 * method reproduce
 * returns {string}
 */
METHOD reproduce() CLASS Cnidarian
RETURN ::name + " reproduces via budding or eggs."

/**
 * Returns cnidarian movement description
 * method move
 * returns {string}
 */
METHOD move() CLASS Cnidarian
RETURN ::name + " drifts or uses tentacles."

/**
 * Handles input of cnidarian-specific data
 * method InputData
 * returns {boolean} True if data entered successfully, False otherwise
 */
METHOD InputData() CLASS Cnidarian

   LOCAL nTentacleCount := 0, cStingSeverity := Space(50)

   IF ::Super:InputData()
      @ 7, 1 SAY "Tentacle Count: " GET nTentacleCount
      @ 8, 1 SAY "Sting Severity: " GET cStingSeverity
      READ
      IF !Empty( cStingSeverity )
         ::tentacleCount := nTentacleCount
         ::stingSeverity := AllTrim( cStingSeverity )
         RETURN .T.
      ENDIF
   ENDIF

RETURN .F.
