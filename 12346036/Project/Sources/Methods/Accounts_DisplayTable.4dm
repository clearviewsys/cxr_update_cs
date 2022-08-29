//%attributes = {"publishedWeb":true}
// Project Method: Accounts_DisplayTable

// Searching for answers? Be sure to check out the "About..." menu located in the
// Apple menu (Macintosh) or the Help menu (Windows). There you can find online
// help for this example database, as well as a listing of numerous 4D resources
// available to you.

// Method created by Dave Batton, DataCraft

// A modified version of the orignal Shell_DisplayTable method designed just
//   to show the [Accounts] table.  This is needed because we want to go directly
//   into a record, not call MODIFY SELECTION.
// If the table has already been displayed in a process by this method, it is
//   brought to the front.  Otherwise a new process is created to display the
//   table.


Shell_DoProcess("Accounts_DisplayTable2"; "Accounts")