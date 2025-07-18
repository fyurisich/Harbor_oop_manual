/*
This Harbour program demonstrates object-oriented programming concepts through a biological
classification system. It models living beings with inheritance (vertebrates/invertebrates
and specific species) and polymorphism (different move()/reproduce() behaviors).
The system includes a menu interface to create, display, and manage organisms, showing their
hierarchical relationships. It also implements multiple inheritance with the Platypus class
combining Mammal and Bird traits.
The program initializes with sample data.
*/

#include "hbclass.ch"

/**
 * Main program entry point
 * function Main
 * returns {NIL}
 */
FUNCTION Main

   LOCAL oSystem := BioClassificationSystem():New()
   oSystem:Run()

RETURN NIL
