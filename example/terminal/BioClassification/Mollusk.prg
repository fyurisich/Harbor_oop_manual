/**
 * Class for mollusks
 * class Mollusk
 * extends Invertebrate
 */

#include "hbclass.ch"

CLASS Mollusk FROM Invertebrate
   DATA shellType
   DATA footType

   METHOD New( cName, cSciName, nLifespan, cHabitat, cShellType, cFootType ) CONSTRUCTOR
   METHOD displayInfo()
   METHOD reproduce()
   METHOD move()
   METHOD InputData()
ENDCLASS

/**
 * Constructor for Mollusk
 * method New
 * param {string} cName Common name
 * param {string} cSciName Scientific name
 * param {number} nLifespan Lifespan in years
 * param {string} cHabitat Habitat
 * param {string} cShellType Type of shell
 * param {string} cFootType Type of foot
 * returns {Self}
 */
METHOD New( cName, cSciName, nLifespan, cHabitat, cShellType, cFootType ) CLASS Mollusk
   ::Super:New( cName, cSciName, nLifespan, cHabitat )
   ::shellType := cShellType
   ::footType := cFootType
RETURN Self

/**
 * Returns formatted mollusk information
 * method displayInfo
 * returns {string}
 */
METHOD displayInfo() CLASS Mollusk
RETURN ::Super:displayInfo() + ", Shell: " + ::shellType + ", Foot: " + ::footType

/**
 * Returns mollusk reproduction description
 * method reproduce
 * returns {string}
 */
METHOD reproduce() CLASS Mollusk
RETURN ::name + " lays eggs."

/**
 * Returns mollusk movement description
 * method move
 * returns {string}
 */
METHOD move() CLASS Mollusk
RETURN ::name + " moves using " + ::footType + " foot."

/**
 * Handles input of mollusk-specific data
 * method InputData
 * returns {boolean} True if data entered successfully, False otherwise
 */
METHOD InputData() CLASS Mollusk

   LOCAL cShellType := Space(50), cFootType := Space(50)

   IF ::Super:InputData()
      @ 7, 1 SAY "Shell Type: " GET cShellType
      @ 8, 1 SAY "Foot Type: " GET cFootType
      READ
      IF !Empty( cShellType )
         ::shellType := AllTrim( cShellType )
         ::footType := AllTrim( cFootType )
         RETURN .T.
      ENDIF
   ENDIF

RETURN .F.
