/**
 * Main system class to manage the biological classification application
 * class BioClassificationSystem
 * property {Array} aOrganisms Array containing all organism objects
 */

#include "hbclass.ch"

CLASS BioClassificationSystem
   DATA aOrganisms

   METHOD New() CONSTRUCTOR
   METHOD Run()
   METHOD CreateOrganism()
   METHOD DisplayOrganisms()
   METHOD DisplayHierarchy()
ENDCLASS

/**
 * Constructor for BioClassificationSystem
 * Initializes the organism array and adds sample data
 * method New
 * returns {Self}
 */
METHOD New() CLASS BioClassificationSystem
   ::aOrganisms := {}

   // Initialize with sample data
   AAdd( ::aOrganisms, Mammal():New( "Lion", "Panthera leo", 15, "Savanna", "Short", 9 ) )
   AAdd( ::aOrganisms, Bird():New( "Eagle", "Haliaeetus leucocephalus", 20, "Mountains", 2.2, "Hooked", .T. ) )
   AAdd( ::aOrganisms, Platypus():New( "Platypus", "Ornithorhynchus anatinus", 17, "Rivers", "Short", 1.5, 0.4, "Flat", .F. ) )
RETURN Self

/**
 * Main application loop displaying menu and handling user choices
 * method Run
 * returns {NIL}
 */
METHOD Run() CLASS BioClassificationSystem

   LOCAL nChoice

   DO WHILE .T.
      CLS
      @ 1, 1 SAY "Biological Classification System"
      @ 3, 1 SAY "1. Create New Organism"
      @ 4, 1 SAY "2. Display Organism Info"
      @ 5, 1 SAY "3. Display Inheritance Hierarchy"
      @ 6, 1 SAY "4. Exit"
      @ 8, 1 SAY "Select an option: "
      nChoice := Val(Chr(Inkey(0)))

      DO CASE
         CASE nChoice == 1
            ::CreateOrganism()
         CASE nChoice == 2
            ::DisplayOrganisms()
         CASE nChoice == 3
            ::DisplayHierarchy()
         CASE nChoice == 4
            EXIT
      ENDCASE
   ENDDO

RETURN NIL

/**
 * Creates a new organism based on user selection
 * method CreateOrganism
 * returns {NIL}
 */
METHOD CreateOrganism() CLASS BioClassificationSystem

   LOCAL nChoice, oOrganism

   CLS
   @  1, 1 SAY    "Create New Organism"
   @  3, 1 PROMPT " 1. Mammal"
   @  4, 1 PROMPT " 2. Bird"
   @  5, 1 PROMPT " 3. Reptile"
   @  6, 1 PROMPT " 4. Amphibian"
   @  7, 1 PROMPT " 5. Fish"
   @  8, 1 PROMPT " 6. Arthropod"
   @  9, 1 PROMPT " 7. Mollusk"
   @ 10, 1 PROMPT " 8. Annelid"
   @ 11, 1 PROMPT " 9. Echinoderm"
   @ 12, 1 PROMPT "10. Cnidarian"
   @ 13, 1 PROMPT "11. Platypus"
   @ 14, 1 PROMPT "12. Exit"
   MENU TO nChoice

   IF nChoice >= 1 .AND. nChoice <= 11
      DO CASE
         CASE nChoice == 1
            oOrganism := Mammal():New()
         CASE nChoice == 2
            oOrganism := Bird():New()
         CASE nChoice == 3
            oOrganism := Reptile():New()
         CASE nChoice == 4
            oOrganism := Amphibian():New()
         CASE nChoice == 5
            oOrganism := Fish():New()
         CASE nChoice == 6
            oOrganism := Arthropod():New()
         CASE nChoice == 7
            oOrganism := Mollusk():New()
         CASE nChoice == 8
            oOrganism := Annelid():New()
         CASE nChoice == 9
            oOrganism := Echinoderm():New()
         CASE nChoice == 10
            oOrganism := Cnidarian():New()
         CASE nChoice == 11
            oOrganism := Platypus():New()
      ENDCASE

      IF oOrganism:InputData()
         AAdd( ::aOrganisms, oOrganism )
         @ 20, 1 SAY "Organism added. Press any key..."
      ELSE
         @ 20, 1 SAY "Creation cancelled. Press any key..."
      ENDIF
      InKey(0)
   ENDIF

RETURN NIL

/**
 * Displays information for all organisms
 * method DisplayOrganisms
 * returns {NIL}
 */
METHOD DisplayOrganisms() CLASS BioClassificationSystem

   LOCAL nRow := 2, oOrganism

   CLS
   @ 1, 1 SAY "Organism Information"
   FOR EACH oOrganism IN ::aOrganisms
      @ nRow, 1 SAY oOrganism:displayInfo()
      nRow++
   NEXT
   @ nRow + 1, 1 SAY "Press any key to return..."
   InKey(0)

RETURN NIL

/**
 * Displays the inheritance hierarchy of organism classes
 * method DisplayHierarchy
 * returns {NIL}
 */
METHOD DisplayHierarchy() CLASS BioClassificationSystem
   CLS
   @  1, 1 SAY "Inheritance Hierarchy"
   @  3, 1 SAY "LivingBeing"
   @  4, 3 SAY "|-- Vertebrate"
   @  5, 5 SAY "|-- Mammal"
   @  6, 7 SAY "|-- Platypus"
   @  7, 5 SAY "|-- Bird"
   @  8, 7 SAY "|-- Platypus"
   @  9, 5 SAY "|-- Reptile"
   @ 10, 5 SAY "|-- Amphibian"
   @ 11, 5 SAY "|-- Fish"
   @ 12, 3 SAY "|-- Invertebrate"
   @ 13, 5 SAY "|-- Arthropod"
   @ 14, 5 SAY "|-- Mollusk"
   @ 15, 5 SAY "|-- Annelid"
   @ 16, 5 SAY "|-- Echinoderm"
   @ 17, 5 SAY "|-- Cnidarian"
   @ 19, 1 SAY "Press any key to return..."
   InKey(0)

RETURN NIL
