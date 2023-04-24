//%attributes = {}
// commented out by @milan

//// this is method for simulating a commit to version control
//// this method is called from a Macro


//C_TEXT($sourceCode; $commitString; $1; $2; $methodPath; $methodName; $oldSourceCode)
//C_TEXT(vSubject; vComments; vReference; vMet byhodName)
//C_LONGINT($revision; $winRef)

//Case of 
//: (Count parameters=0)
//$methodPath:=Current method name
//$methodName:=Current method name
//: (Count parameters=2)
//GET MACRO PARAMETER(Full method text; $sourceCode)
//$methodPath:=$1
//$methodName:=$2
//End case 
//vSubject:=""
//vComments:=""

//// look for a previous comment and notes on the same object in the revision DB
//READ ONLY([DB_CodeRevisions])
//QUERY([DB_CodeRevisions]; [DB_CodeRevisions]MethodName=$methodName)
//ORDER BY([DB_CodeRevisions]; [DB_CodeRevisions]ID; <)  // sort descending (first record is last revision)
//If (Records in selection([DB_CodeRevisions])>0)
//FIRST RECORD([DB_CodeRevisions])
//LOAD RECORD([DB_CodeRevisions])
//RELATE ONE([DB_CodeRevisions]Story)  // load the associated issue
//vReference:=[DB_CodeRevisions]Story
//$oldSourceCode:=[DB_CodeRevisions]SourceCode
//$revision:=[DB_CodeRevisions]ID
//Else   // this method is new
//vReference:=""
//vSubject:="new method "+$methodName
//End if 

//vMethodName:=$methodName
//// open the dialog for commit
//$winRef:=openFormWindow(->[DB_CodeRevisions]; "commit")
//CLOSE WINDOW($winRef)


//If (OK=1)
//createDB_CodeRevisionRecord($methodName; $methodPath; $sourceCode; vSubject; vComments; vReference)
//Else 
//// revert to this code
////myConfirm ("Are you sure you want to revert changes and go back to this code?"+crlf+$oldSourceCode;"Revert Changes";"Save Changes")
////If (OK=1)  // revert
////myAlert ("Reverted to revision: "+String($revision)+CRLF +$oldSourceCode)
////METHOD SET CODE([DB_CodeRevisions]MethodPath;$oldSourceCode)
////myAlert ("Here is source code you discarted (another chance to copy/paste): "+CRLF +$sourceCode)
////Else 
//createDB_CodeRevisionRecord($methodName; $methodPath; $sourceCode; "undocumented commit note"; ""; vReference)
////End if 
//End if 