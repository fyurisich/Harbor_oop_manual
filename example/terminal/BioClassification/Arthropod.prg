/**
 * Class for arthropods
 * class Arthropod
 * extends Invertebrate
 */

#include "hbclass.ch"

CLASS Arthropod FROM Invertebrate
   DATA legCount
   DATA exoskeletonMaterial

   METHOD New( cName, cSciName, nLifespan, cHabitat, nLegCount, cExoMaterial ) CONSTRUCTOR
   METHOD displayInfo()
   METHOD reproduce()
   METHOD move()
   METHOD InputData()
ENDCLASS

/**
 * Constructor for Arthropod
 * method New
 * param {string} cName Common name
 * param {string} cSciName Scientific name
 * param {number} nLifespan Lifespan in years
 * param {string} cHabitat Habitat
 * param {number} nLegCount Number of legs
 * param {string} cExoMaterial Exoskeleton material
 * returns {Self}
 */
METHOD New( cName, cSciName, nLifespan, cHabitat, nLegCount, cExoMaterial ) CLASS Arthropod
   ::Super:New( cName, cSciName, nLifespan, cHabitat )
   ::legCount := nLegCount
   ::exoskeletonMaterial := cExoMaterial
RETURN Self

/**
 * Returns formatted arthropod information
 * method displayInfo
 * returns {string}
 */
METHOD displayInfo() CLASS Arthropod
RETURN ::Super:displayInfo() + ", Legs: " + Str( ::legCount ) + ", Exoskeleton: " + ::exoskeletonMaterial

/**
 * Returns arthropod reproduction description
 * method reproduce
 * returns {string}
 */
METHOD reproduce() CLASS Arthropod
RETURN ::name + " lays eggs."

/**
 * Returns arthropod movement description
 * method move
 * returns {string}
 */
METHOD move() CLASS Arthropod
RETURN ::name + " crawls with " + Str( ::legCount ) + " legs."

/**
 * Handles input of arthropod-specific data
 * method InputData
 * returns {boolean} True if data entered successfully, False otherwise
 */
METHOD InputData() CLASS Arthropod

   LOCAL nLegCount := 0, cExoMaterial := Space(50)

   IF ::Super:InputData()
      @ 7, 1 SAY "Leg Count: " GET nLegCount
      @ 8, 1 SAY "Exoskeleton Material: " GET cExoMaterial
      READ
      IF !Empty( cExoMaterial )
         ::legCount := nLegCount
         ::exoskeletonMaterial := AllTrim( cExoMaterial )
         RETURN .T.
      ENDIF
   ENDIF

RETURN .F.
