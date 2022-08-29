//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay
// Date and time: 06/14/18, 16:04:32
// ----------------------------------------------------
// Method: pick_CommonList
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($1; $tListType)
C_POINTER:C301($2; $ptrFieldToFill)  //field in calling form
C_LONGINT:C283($3; vPickView)

C_POINTER:C301($4; $ptrFieldToPick)  //field in [CommonLists] to return
//If (False)  //probably remove these 2 parameters --> 
//C_POINTER($4;$ptrSearchField)  //field in [CommonLists] to query on
//C_TEXT($5;$tSearchValue)  //starting value to search [CommonLists] 
//Else 
//C_LONGINT($4;vPickView)  //<--- define views with different column options --ilb_default_def
//End if 

C_TEXT:C284(vPickSearchText)
C_TEXT:C284(vPickListName)
C_LONGINT:C283(vPickRecNum)
C_LONGINT:C283(vPickView)

$tListType:=$1
$ptrFieldToFill:=$2

If (Count parameters:C259>=3)
	vPickView:=$3
Else 
	vPickView:=PickView_All
End if 

If (Count parameters:C259>=4)
	$ptrFieldToPick:=$4
Else 
	$ptrFieldToPick:=->[CommonLists:84]ItemName:2
End if 





//If (False)  //can probably do without these parameters
//If (Count parameters>=4)
//$ptrSearchField:=$4
//Else 
//$ptrSearchField:=$ptrFieldToPick
//End if 
//
//If (Count parameters>=5)
//$tSearchValue:=$5
//Else 
//$tSearchValue:=$ptrFieldToFill->
//End if 
//
//Else 
//If (Count parameters>=4)
//vPickView:=$4
//Else 
//vPickView:=PickView_All
//End if 
//End if 

C_TEXT:C284($pickForm)
C_POINTER:C301($ptrTable; $ptrSearchField)
$pickForm:="PICK"
$ptrTable:=->[CommonLists:84]

vPickListName:=$tListType

READ ONLY:C145($ptrTable->)

If (Form event code:C388=On Clicked:K2:4)  //user invoking the pick so let them look at all
	QUERY:C277($ptrTable->; [CommonLists:84]ListName:1=$tListType; *)
	QUERY:C277($ptrTable->;  & ; $ptrSearchField->="@")
Else 
	QUERY:C277($ptrTable->; [CommonLists:84]ListName:1=$tListType; *)
	QUERY:C277($ptrTable->;  & ; $ptrSearchField->=$ptrFieldToFill->+"@")
End if 

If (Records in selection:C76([CommonLists:84])=1)
	vPickRecNum:=Record number:C243($ptrTable->)
	$ptrFieldToFill->:=$ptrFieldToPick->  //just fill in the field witht he found value
Else 
	vPickRecNum:=-1  //init to not found
	
	C_LONGINT:C283($winRef)
	$winRef:=Open form window:C675($ptrTable->; $pickForm; Plain window:K34:13; Horizontally centered:K39:1; Vertically centered:K39:4)
	
	vPickSearchText:=$ptrFieldToFill->  //set the search text in the dialog box
	DIALOG:C40($ptrTable->; $pickForm)
	
	If (OK=1)
		
		If (vPickRecNum>-1)
			GOTO RECORD:C242($ptrTable->; vPickRecNum)
		Else   //we've got a problem so return nothing
			UNLOAD RECORD:C212($ptrTable->)
			REDUCE SELECTION:C351($ptrTable->; 0)
		End if 
		
		$ptrFieldToFill->:=$ptrFieldToPick->
		
	Else   //user cancelled
		UNLOAD RECORD:C212($ptrTable->)
		REDUCE SELECTION:C351($ptrTable->; 0)
	End if 
End if 