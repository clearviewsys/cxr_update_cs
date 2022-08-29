//%attributes = {}
// ----------------------------------------------------
// User name (OS): Jonathan Le
// Date and time: 04/02/04, 09:26:45
// ----------------------------------------------------
// Method: BKP_XML_PopulateVariables
// Description
// 
// All we do in this method is parse the DOM tree passed in
// then we obtain the fully qualified element name and its value
// and place these values into containers.  These containers called
// InfoValues and InfoLabels are later parsed and their values are assigned
// to the appropriate variables.
//
// Parameters\ 
// $1 - the top element from which we start parsing
// $2 - the relative XPath of the node we are trying to find in the top element $1
// ----------------------------------------------------
C_TEXT:C284($1; $tParentElem)
C_TEXT:C284($2; $tXPath)
C_LONGINT:C283($0)
C_TEXT:C284($tCurElem; $tCurName; $tCurValue; $tFQName)
C_TEXT:C284($tChildElem; $tChildName; $tChildValue)
C_BOOLEAN:C305($bHaveSubElements)

$tParentElem:=$1

If (Count parameters:C259>1)
	$tXPath:=$2
Else 
	$tXPath:=""
End if 

// parses based on current Backup.XML schema
$tCurElem:=DOM Get first child XML element:C723($tParentElem; $tCurName; $tCurValue)
While (OK=1)
	
	// we are at the top level, get the element level
	$bHaveSubElements:=False:C215
	$tChildElem:=DOM Get first child XML element:C723($tCurElem; $tChildName; $tChildValue)
	
	// get the Fully qualified name
	$tFQName:=Replace string:C233($tXPath+"/"+$tCurName; "/Backup/"; "")
	
	// keep inserting fully qualified names and values
	While (OK=1)
		
		$bHaveSubElements:=True:C214
		$tFQName:=$tFQName+"/"+$tChildName
		
		// we don't care about the item count, we're using DOM with XPath!
		If (Find in array:C230(aInfoLabels; $tFQName)#-1)
			
			// if it already exists, just separate the existing value with the new value by a carriage return
			aInfoValues{Find in array:C230(aInfoLabels; $tFQName)}:=aInfoValues{Find in array:C230(aInfoLabels; $tFQName)}+Char:C90(13)+$tChildValue
			
		Else 
			
			// if it does not exist, insert it
			APPEND TO ARRAY:C911(aInfoLabels; $tFQName)
			APPEND TO ARRAY:C911(aInfoValues; $tChildValue)
			
		End if 
		$tChildElem:=DOM Get next sibling XML element:C724($tChildElem; $tChildName; $tChildValue)
		
		$tFQName:=Replace string:C233($tXPath+"/"+$tCurName; "/Backup/"; "")
	End while 
	
	// add the top element if there were no subelements
	If (Not:C34($bHaveSubElements))
		APPEND TO ARRAY:C911(aInfoLabels; $tFQName)
		APPEND TO ARRAY:C911(aInfoValues; $tCurValue)
	End if 
	
	// get the next element
	$tCurElem:=DOM Get next sibling XML element:C724($tCurElem; $tCurName; $tCurValue)
End while 

If (Size of array:C274(aInfoLabels)>0)
	// success
	$0:=0
Else 
	// failed loading prefs
	$0:=-1
End if 