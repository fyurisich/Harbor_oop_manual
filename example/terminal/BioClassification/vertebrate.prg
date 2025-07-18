/**
 * Class for vertebrates
 * class Vertebrate
 * extends LivingBeing
 */

#include "hbclass.ch"

CLASS Vertebrate FROM LivingBeing
   DATA hasBackbone INIT .T.
   DATA skeletonType INIT "internal"

   METHOD New( cName, cSciName, nLifespan, cHabitat ) CONSTRUCTOR
   METHOD displayInfo()
ENDCLASS

/**
 * Constructor for Vertebrate
 * method New
 * param {string} cName Common name
 * param {string} cSciName Scientific name
 * param {number} nLifespan Lifespan in years
 * param {string} cHabitat Habitat
 * returns {Self}
 */
METHOD New( cName, cSciName, nLifespan, cHabitat ) CLASS Vertebrate
   ::Super:New( cName, cSciName, nLifespan, cHabitat )
RETURN Self

/**
 * Returns formatted vertebrate information
 * method displayInfo
 * returns {string}
 */
METHOD displayInfo() CLASS Vertebrate
RETURN ::Super:displayInfo() + ", Backbone: Yes, Skeleton: " + ::skeletonType
