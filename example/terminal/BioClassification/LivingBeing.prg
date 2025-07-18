/**
 * Base class for all living beings
 * class LivingBeing
 */

#include "hbclass.ch"

CLASS LivingBeing
   DATA name
   DATA scientificName
   DATA lifespan
   DATA habitat

   METHOD New( cName, cSciName, nLifespan, cHabitat ) CONSTRUCTOR
   METHOD displayInfo()
   METHOD reproduce()
   METHOD move()
   METHOD InputData()
ENDCLASS

/**
 * Constructor for LivingBeing
 * method New
 * param {string} cName Common name of the organism
 * param {string} cSciName Scientific name of the organism
 * param {number} nLifespan Average lifespan in years
 * param {string} cHabitat Natural habitat of the organism
 * returns {Self}
 */
METHOD New( cName, cSciName, nLifespan, cHabitat ) CLASS LivingBeing
   ::name := cName
   ::scientificName := cSciName
   ::lifespan := nLifespan
   ::habitat := cHabitat
RETURN Self

/**
 * Returns formatted string with organism information
 * @method displayInfo
 * @returns {string}
 */
METHOD displayInfo() CLASS LivingBeing
RETURN "Name: " + ::name + ", Scientific: " + ::scientificName + ;
       ", Lifespan: " + Str( ::lifespan ) + ", Habitat: " + ::habitat

/**
 * Returns reproduction description
 * method reproduce
 * returns {string}
 */
METHOD reproduce() CLASS LivingBeing
RETURN ::name + " reproduces."

/**
 * Returns movement description
 * method move
 * returns {string}
 */
METHOD move() CLASS LivingBeing
RETURN ::name + " moves."

/**
 * Handles input of organism data
 * method InputData
 * returns {boolean} True if data entered successfully, False otherwise
 */
METHOD InputData() CLASS LivingBeing

   LOCAL cName := Space(50), cSciName := Space(50), cHabitat := Space(50), nLifespan := 0

   CLS
   @ 1, 1 SAY "Enter Organism Data"
   @ 3, 1 SAY "Name: " GET cName
   @ 4, 1 SAY "Scientific Name: " GET cSciName
   @ 5, 1 SAY "Lifespan (years): " GET nLifespan
   @ 6, 1 SAY "Habitat: " GET cHabitat
   READ

   IF !Empty( cName )
      ::name := AllTrim( cName )
      ::scientificName := AllTrim( cSciName )
      ::lifespan := nLifespan
      ::habitat := AllTrim( cHabitat )
      RETURN .T.
   ENDIF

RETURN .F.
