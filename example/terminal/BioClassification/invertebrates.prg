/**
 * Class for invertebrates
 * class Invertebrate
 * extends LivingBeing
 */

#include "hbclass.ch"

CLASS Invertebrate FROM LivingBeing
   DATA hasBackbone INIT .F.
   DATA skeletonType INIT "external or none"

   METHOD New( cName, cSciName, nLifespan, cHabitat ) CONSTRUCTOR
   METHOD displayInfo()
ENDCLASS

/**
 * Constructor for Invertebrate
 * method New
 * param {string} cName Common name
 * param {string} cSciName Scientific name
 * param {number} nLifespan Lifespan in years
 * param {string} cHabitat Habitat
 * returns {Self}
 */
METHOD New( cName, cSciName, nLifespan, cHabitat ) CLASS Invertebrate
   ::Super:New( cName, cSciName, nLifespan, cHabitat )
RETURN Self

/**
 * Returns formatted invertebrate information
 * method displayInfo
 * returns {string}
 */
METHOD displayInfo() CLASS Invertebrate
RETURN ::Super:displayInfo() + ", Backbone: No, Skeleton: " + ::skeletonType
