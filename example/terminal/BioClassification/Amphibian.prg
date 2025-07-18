/**
 * Class for amphibians
 * class Amphibian
 * extends Vertebrate
 */

#include "hbclass.ch"

CLASS Amphibian FROM Vertebrate
   DATA skinType
   DATA metamorphosisStage
   DATA warmBlooded INIT .F.

   METHOD New( cName, cSciName, nLifespan, cHabitat, cSkinType, cMetaStage ) CONSTRUCTOR
   METHOD displayInfo()
   METHOD reproduce()
   METHOD move()
   METHOD InputData()
ENDCLASS

/**
 * Constructor for Amphibian
 * method New
 * param {string} cName Common name
 * param {string} cSciName Scientific name
 * param {number} nLifespan Lifespan in years
 * param {string} cHabitat Habitat
 * param {string} cSkinType Type of skin
 * param {string} cMetaStage Metamorphosis stage
 * returns {Self}
 */
METHOD New( cName, cSciName, nLifespan, cHabitat, cSkinType, cMetaStage ) CLASS Amphibian
   ::Super:New( cName, cSciName, nLifespan, cHabitat )
   ::skinType := cSkinType
   ::metamorphosisStage := cMetaStage
RETURN Self

/**
 * Returns formatted amphibian information
 * method displayInfo
 * returns {string}
 */
METHOD displayInfo() CLASS Amphibian
RETURN ::Super:displayInfo() + ", Skin: " + ::skinType + ", Metamorphosis: " + ::metamorphosisStage

/**
 * Returns amphibian reproduction description
 * method reproduce
 * returns {string}
 */
METHOD reproduce() CLASS Amphibian
RETURN ::name + " lays eggs in water."

/**
 * Returns amphibian movement description
 * method move
 * returns {string}
 */
METHOD move() CLASS Amphibian
RETURN ::name + " swims or hops."

/**
 * Handles input of amphibian-specific data
 * method InputData
 * returns {boolean} True if data entered successfully, False otherwise
 */
METHOD InputData() CLASS Amphibian

   LOCAL cSkinType := Space(50), cMetaStage := Space(50)

   IF ::Super:InputData()
      @ 7, 1 SAY "Skin Type: " GET cSkinType
      @ 8, 1 SAY "Metamorphosis Stage: " GET cMetaStage
      READ
      IF !Empty( cSkinType )
         ::skinType := AllTrim( cSkinType )
         ::metamorphosisStage := AllTrim( cMetaStage )
         RETURN .T.
      ENDIF
   ENDIF

RETURN .F.
