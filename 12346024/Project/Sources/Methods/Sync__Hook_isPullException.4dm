//%attributes = {"shared":true}
// ----------------------------------------------------
// Project Method: Sync__Hook_isPullException (method to execute)

// Allows a host database to exclude records from a remote pull.

// This is called prior to saving a pulled record.

// Access: Shared

// Parameters: 
//   $1 : Longint : Table number of the record about to be saved
// Returns: 
//   $0 : Boolean : True=Exception Don't Save, False=NOT Exception Save

// This method was automatically generated by Sync on Sep 15, 2017.
// ----------------------------------------------------

C_LONGINT:C283($1; $iTableNum)
C_BOOLEAN:C305($0)
$iTableNum:=$1

//Case of
//:($iTable=1)

//`Else

//End Case

$0:=False:C215