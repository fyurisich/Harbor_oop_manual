/**
 * Class for annelids
 * class Annelid
 * extends Invertebrate
 */

#include "hbclass.ch"

CLASS Annelid FROM Invertebrate
   DATA segmentCount
   DATA bodyLength

   METHOD New( cName, cSciName, nLifespan, cHabitat, nSegmentCount, nBodyLength ) CONSTRUCTOR
   METHOD displayInfo()
   METHOD reproduce()
   METHOD move()
   METHOD InputData()
ENDCLASS

/**
 * Constructor for Annelid
 * method New
 * param {string} cName Common name
 * param {string} cSciName Scientific name
 * param {number} nLifespan Lifespan in years
 * param {string} cHabitat Habitat
 * param {number} nSegmentCount Number of body segments
 * param {number} nBodyLength Body length in centimeters
 * returns {Self}
 */
METHOD New( cName, cSciName, nLifespan, cHabitat, nSegmentCount, nBodyLength ) CLASS Annelid
   ::Super:New( cName, cSciName, nLifespan, cHabitat )
   ::segmentCount := nSegmentCount
   ::bodyLength := nBodyLength
RETURN Self

/**
 * Returns formatted annelid information
 * method displayInfo
 * returns {string}
 */
METHOD displayInfo() CLASS Annelid
RETURN ::Super:displayInfo() + ", Segments: " + Str( ::segmentCount ) + ", Length: " + Str( ::bodyLength ) + "cm"

/**
 * Returns annelid reproduction description
 * method reproduce
 * returns {string}
 */
METHOD reproduce() CLASS Annelid
RETURN ::name + " reproduces via segmentation or eggs."

/**
 * Returns annelid movement description
 * method move
 * returns {string}
 */
METHOD move() CLASS Annelid
RETURN ::name + " crawls with segmented body."

/**
 * Handles input of annelid-specific data
 * method InputData
 * returns {boolean} True if data entered successfully, False otherwise
 */
METHOD InputData() CLASS Annelid

   LOCAL nSegmentCount := 0, nBodyLength := 0

   IF ::Super:InputData()
      @ 7, 1 SAY "Segment Count: " GET nSegmentCount
      @ 8, 1 SAY "Body Length (cm): " GET nBodyLength
      READ
      ::segmentCount := nSegmentCount
      ::bodyLength := nBodyLength
      RETURN .T.
   ENDIF

RETURN .F.
