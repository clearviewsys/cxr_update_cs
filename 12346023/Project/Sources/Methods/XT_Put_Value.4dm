//%attributes = {}
// 10/10/2006 -- I. Barclay Berry
//Object Tools replacement using DOM XML object
// ----------------------------------------------------
// User name (OS): barclay
// Date and time: 10/10/06, 23:48:13
// ----------------------------------------------------
// Method: XT_Put_Value
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($1; $sObjectRef)
C_TEXT:C284($2; $tTagName)  //in XPath format -- root level is auto prepended
C_POINTER:C301($3; $ptrValue)  //value to store

C_TEXT:C284($tPacked)
C_LONGINT:C283($iType)
C_TEXT:C284($sElemRef)

$sObjectRef:=$1

If (XT_Is_Object($sObjectRef))  //is a valid object in memory
	$tTagname:=XT_Get_Root($sObjectRef)+$2
	$ptrValue:=$3
	
	$iType:=Type:C295($ptrValue->)
	
	$sElemRef:=DOM Find XML element:C864($sObjectRef; $tTagName)
	If (OK=1)  //element exists so just update the value
	Else   //element does not exist
		$sElemRef:=DOM Create XML element:C865($sObjectRef; $tTagName; "Type"; String:C10($iType))
	End if 
	
	
	
	Case of 
		: ($iType=Is picture:K8:10)
			
		: ($iType=Is pointer:K8:14)  //this shouldn't be b/c we dereference above
			
		: (($iType>=13) & ($iType<=22))  //all array types
			//$tPacked:=ARR_Pack_to_Text($ptrValue;"|")` <------------ NEED TO UPDATE
			$tPacked:=$ptrValue->
			DOM SET XML ELEMENT VALUE:C868($sElemRef; $tPacked)
		Else 
			DOM SET XML ELEMENT VALUE:C868($sElemRef; $ptrValue->)
	End case 
	
End if 