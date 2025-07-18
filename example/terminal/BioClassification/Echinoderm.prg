/**
 * Class for echinoderms
 * class Echinoderm
 * extends Invertebrate
 */

#include "hbclass.ch"

CLASS Echinoderm FROM Invertebrate
   DATA radialSymmetryCount
   DATA waterVascularSystem

   METHOD New( cName, cSciName, nLifespan, cHabitat, nRadialCount, cWaterSystem ) CONSTRUCTOR
   METHOD displayInfo()
   METHOD reproduce()
   METHOD move()
   METHOD InputData()
ENDCLASS

/**
 * Constructor for Echinoderm
 * method New
 * param {string} cName Common name
 * param {string} cSciName Scientific name
 * param {number} nLifespan Lifespan in years
 * param {string} cHabitat Habitat
 * param {number} nRadialCount Number of radial symmetry axes
 * param {string} cWaterSystem Type of water vascular system
 * returns {Self}
 */
METHOD New( cName, cSciName, nLifespan, cHabitat, nRadialCount, cWaterSystem ) CLASS Echinoderm
   ::Super:New( cName, cSciName, nLifespan, cHabitat )
   ::radialSymmetryCount := nRadialCount
   ::waterVascularSystem := cWaterSystem
RETURN Self

/**
 * Returns formatted echinoderm information
 * method displayInfo
 * returns {string}
 */
METHOD displayInfo() CLASS Echinoderm
RETURN ::Super:displayInfo() + ", Radial Symmetry: " + Str( ::radialSymmetryCount ) + ", Water Vascular: " + ::waterVascularSystem

/**
 * Returns echinoderm reproduction description
 * method reproduce
 * returns {string}
 */
METHOD reproduce() CLASS Echinoderm
RETURN ::name + " releases gametes into water."

/**
 * Returns echinoderm movement description
 * method move
 * returns {string}
 */
METHOD move() CLASS Echinoderm
RETURN ::name + " moves using water vascular system."

/**
 * Handles input of echinoderm-specific data
 * method InputData
 * returns {boolean} True if data entered successfully, False otherwise
 */
METHOD InputData() CLASS Echinoderm

   LOCAL nRadialCount := 0, cWaterSystem := Space(50)

   IF ::Super:InputData()
      @ 7, 1 SAY "Radial Symmetry Count: " GET nRadialCount
      @ 8, 1 SAY "Water Vascular System: " GET cWaterSystem
      READ
      IF !Empty( cWaterSystem )
         ::radialSymmetryCount := nRadialCount
         ::waterVascularSystem := AllTrim( cWaterSystem )
         RETURN .T.
      ENDIF
   ENDIF

RETURN .F.
