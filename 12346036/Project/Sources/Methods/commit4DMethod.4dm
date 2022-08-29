//%attributes = {}
// this is method for simulating a commit to version control
// this method is called from a Macro


C_TEXT:C284($sourceCode; $commitString; $1; $2; $methodPath; $methodName; $oldSourceCode)
C_TEXT:C284(vSubject; vComments; vReference; vMethodName)
C_LONGINT:C283($revision; $winRef)

Case of 
	: (Count parameters:C259=0)
		$methodPath:=Current method name:C684
		$methodName:=Current method name:C684
	: (Count parameters:C259=2)
		GET MACRO PARAMETER:C997(Full method text:K5:17; $sourceCode)
		$methodPath:=$1
		$methodName:=$2
End case 
vSubject:=""
vComments:=""

// look for a previous comment and notes on the same object in the revision DB
READ ONLY:C145([DB_CodeRevisions:103])
QUERY:C277([DB_CodeRevisions:103]; [DB_CodeRevisions:103]MethodName:11=$methodName)
ORDER BY:C49([DB_CodeRevisions:103]; [DB_CodeRevisions:103]ID:1; <)  // sort descending (first record is last revision)
If (Records in selection:C76([DB_CodeRevisions:103])>0)
	FIRST RECORD:C50([DB_CodeRevisions:103])
	LOAD RECORD:C52([DB_CodeRevisions:103])
	RELATE ONE:C42([DB_CodeRevisions:103]Story:3)  // load the associated issue
	vReference:=[DB_CodeRevisions:103]Story:3
	$oldSourceCode:=[DB_CodeRevisions:103]SourceCode:5
	$revision:=[DB_CodeRevisions:103]ID:1
Else   // this method is new
	vReference:=""
	vSubject:="new method "+$methodName
End if 

vMethodName:=$methodName
// open the dialog for commit
$winRef:=openFormWindow(->[DB_CodeRevisions:103]; "commit")
CLOSE WINDOW:C154($winRef)


If (OK=1)
	createDB_CodeRevisionRecord($methodName; $methodPath; $sourceCode; vSubject; vComments; vReference)
Else 
	// revert to this code
	//myConfirm ("Are you sure you want to revert changes and go back to this code?"+crlf+$oldSourceCode;"Revert Changes";"Save Changes")
	//If (OK=1)  // revert
	//myAlert ("Reverted to revision: "+String($revision)+CRLF +$oldSourceCode)
	//METHOD SET CODE([DB_CodeRevisions]MethodPath;$oldSourceCode)
	//myAlert ("Here is source code you discarted (another chance to copy/paste): "+CRLF +$sourceCode)
	//Else 
	createDB_CodeRevisionRecord($methodName; $methodPath; $sourceCode; "undocumented commit note"; ""; vReference)
	//End if 
End if 