#include "hmg.ch"
#include "hbclass.ch"

/*
 * PROCEDURE Main()
 *
 * Initializes the main application window and creates two custom progress bar controls.
 *
 * Purpose:
 *   This is the entry point of the application. It defines the main window, creates two instances of the MyProgressbar class,
 *   positions them within the window, and adds a button that triggers the DoProgress procedure to update the progress bars.
 *   The purpose is to demonstrate the usage of the custom MyProgressbar control within an HMG Extended application.
 *   This allows developers to see how to integrate custom controls into their HMG applications.
 *
 * Notes:
 *   The MyProgressbar class is defined later in the code.
 *   The DoProgress procedure is responsible for incrementing the progress bar values.
 */
PROCEDURE Main()

   LOCAL oControl1, oControl2

   DEFINE WINDOW MAIN ROW 0 COL 0 WIDTH 600 HEIGHT 400 TITLE "Custom Progress Bar Control" WINDOWTYPE MAIN

      oControl1 := MyProgressbar():New()
      WITH OBJECT oControl1
         :SetPos( 80, 10, 500, 50 )
         :BackColor := YELLOW
         :Create()
      ENDWITH

      oControl2 := MyProgressbar():New()
      WITH OBJECT oControl2
         :Caption := "testing"
         :SetPos( 160, 10, 500, 50 )
         :BackColor := BLUE
         :Create()
      ENDWITH

      DEFINE BUTTON Button_1
         PARENT Main
         ROW 30
         COL 10
         CAPTION 'Click Me!'
         ACTION DoProgress( oControl1, oControl2 )
      END BUTTON

   END WINDOW

   CENTER WINDOW Main
   ACTIVATE WINDOW Main

RETURN

/*
 * PROCEDURE DoProgress(oControl1, oControl2)
 *
 * Increments the value of two MyProgressbar objects until they reach their maximum value.
 *
 * Parameters:
 *   oControl1 (OBJECT): The first MyProgressbar object to update.
 *   oControl2 (OBJECT): The second MyProgressbar object to update.
 *
 * Returns:
 *   None
 *
 * Purpose:
 *   This procedure is called when the "Click Me!" button is pressed. It iteratively increases the nValue property of the two
 *   MyProgressbar objects (oControl1 and oControl2) by 10 in each iteration until the value reaches the maximum value (nMax).
 *   It also calls the SetPercentage() method to update the percentage display and uses InkeyGUI(100) to introduce a small delay,
 *   allowing the user to visually observe the progress bar updates. This demonstrates how to dynamically update a custom control
 *   based on user interaction.
 *
 * Notes:
 *   The InkeyGUI(100) function pauses the execution for 100 milliseconds, preventing the loop from running too quickly and
 *   allowing the UI to update.
 */
PROCEDURE DoProgress( oControl1, oControl2 )

   IF oControl1:nValue == oControl1:nMax
      oControl1:Refresh()
      oControl2:Refresh()
   ENDIF

   WHILE oControl1:nValue < oControl1:nMax
      oControl1:SetValue( oControl1:nValue + 10 )
      oControl1:SetPercentage()
      oControl2:SetValue( oControl2:nValue + 10 )
      InkeyGUI( 100 )
   END

RETURN

/*
 * CLASS MyProgressbar
 *
 * Defines a custom progress bar control.
 *
 * Instance Variables:
 *   Name (STRING): The unique name of the window containing the progress bar.
 *   nRow (NUMERIC): The row position of the progress bar within its parent window.
 *   nCol (NUMERIC): The column position of the progress bar within its parent window.
 *   nWidth (NUMERIC): The width of the progress bar.
 *   nHeight (NUMERIC): The height of the progress bar.
 *   Caption (STRING): The caption displayed on the progress bar.
 *   BackColor (COLOR): The background color of the progress bar.
 *   nMax (NUMERIC): The maximum value of the progress bar (default: 480).
 *   nValue (NUMERIC): The current value of the progress bar (default: 0).
 *   Parent (STRING): The name of the parent window.
 *
 * Methods:
 *   New(): Constructor for the class.
 *   Create(): Creates the progress bar window and label.
 *   Refresh(): Resets the progress bar to zero and redraws it.
 *   SetPos(r, c, w, h): Sets the position and size of the progress bar.
 *   SetValue(n): Sets the current value of the progress bar.
 *   SetPercentage(): Updates the percentage display on the progress bar.
 *   Paint(): Updates the width of the progress bar label to visually represent the progress.
 *
 * Purpose:
 *   This class encapsulates the logic for creating and managing a custom progress bar control. It provides methods for setting the position,
 *   value, and percentage display of the progress bar. The Paint() method is responsible for visually updating the progress bar by
 *   adjusting the width of the label based on the current value. This allows developers to easily reuse a progress bar component
 *   in different parts of their application.
 *
 * Notes:
 *   The progress bar is implemented using a window containing a label. The width of the label is adjusted to represent the progress.
 *   The nMax variable defines the maximum value that the progress bar can reach.
 */
CREATE CLASS MyProgressbar

   VAR Name
   VAR nRow
   VAR nCol
   VAR nWidth
   VAR nHeight
   VAR Caption
   VAR BackColor
   VAR nMax INIT 480
   VAR nValue INIT 0
   VAR Parent

   METHOD Create()
   METHOD Refresh()
   METHOD SetPos( r, c, w, h ) INLINE ::nRow := r, ::nCol := c, ::nWidth := w, ::nHeight := h
   METHOD SetValue( n ) INLINE ::nValue := iif( ::nValue >= ::nMax, ::nMax, n ), ::Paint()
   METHOD SetPercentage() INLINE SetProperty( ::Name, "label_1", "value", hb_ntos( ::nValue / ::nMax * 100 ) + " %" )
   METHOD Paint()

ENDCLASS

/*
 * METHOD Create() CLASS MyProgressbar
 *
 * Creates the window and label that make up the progress bar control.
 *
 * Purpose:
 *   This method is responsible for creating the HMG window and label controls that visually represent the progress bar.
 *   It dynamically generates a unique name for the window using HMG_GetUniqueName(). The window is created as a PANEL type.
 *   A label is then created within the window, which will be used to display the progress bar and percentage.
 *   The use of a PANEL window allows the label to be contained within a defined area.
 *
 * Notes:
 *   The ::Name variable stores the unique name of the window, which is used to reference the window later.
 *   The label's width is initially set to 1, and its width is dynamically updated in the Paint() method to reflect the progress.
 */
METHOD Create() CLASS MyProgressbar

   ::Name := HMG_GetUniqueName( "W" )

   DEFINE WINDOW ( ::Name ) ;
         ROW ::nRow ;
         COL ::nCol ;
         WIDTH ::nWidth ;
         HEIGHT ::nHeight ;
         WINDOWTYPE PANEL

      DEFINE LABEL LABEL_1
         ROW 10
         COL 10
         VALUE ::Caption
         BORDER .T.
         WIDTH 1
         HEIGHT 25
         BACKCOLOR ::BackColor
         CENTERALIGN .T.
         VCENTERALIGN .T.
      END LABEL

   END WINDOW

RETURN NIL

/*
 * METHOD Refresh() CLASS MyProgressbar
 *
 * Hides the progress bar window, resets the progress value to zero, and then shows the window again.
 *
 * Purpose:
 *   This method provides a way to reset the progress bar to its initial state. It first hides the window to prevent visual artifacts
 *   during the reset process. Then, it sets the nValue property to 0, effectively resetting the progress. Finally, it shows the window
 *   again, making the reset progress bar visible. This is useful when you need to reuse the progress bar for a new task.
 *
 * Notes:
 *   Hiding the window before resetting the value ensures a smooth visual transition.
 */
METHOD Refresh() CLASS MyProgressbar

   DoMethod( ::Name, "Hide" )
   ::nValue := 0

   SHOW WINDOW ( ::Name )

RETURN NIL

/*
 * METHOD Paint() CLASS MyProgressbar
 *
 * Updates the width of the label to visually represent the progress bar's current value.
 *
 * Purpose:
 *   This method is called to update the visual representation of the progress bar. It sets the width of the label control
 *   (named "label_1" within the progress bar's window) to the current value of ::nValue. This effectively makes the label
 *   grow or shrink, visually indicating the progress. The width of the label is directly proportional to the current value,
 *   providing a clear visual representation of the progress.
 *
 * Notes:
 *   The SetProperty() function is used to modify the "width" property of the label control.
 *   The width of the label is directly proportional to the current value of the progress bar.
 */
METHOD Paint() CLASS MyProgressbar

   SetProperty( ::Name, "label_1", "width", ::nValue )

RETURN NIL
