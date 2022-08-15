//%attributes = {}
// 10/10/2006 -- I. Barclay Berry
//Object Tools replacement using DOM XML object
// ----------------------------------------------------
// User name (OS): barclay
// Date and time: 10/10/06, 23:47:47
// ----------------------------------------------------
// Method: XT_Get_Value
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($1; $sObjectRef)
C_TEXT:C284($2; $tTagName)  //in XPath format
C_POINTER:C301($3; $ptrValue)  //value to store

C_LONGINT:C283($0; $iError)

C_TEXT:C284($tPacked)
C_LONGINT:C283($iType)
C_TEXT:C284($sElemRef)

$sObjectRef:=$1

$iError:=0

If (XT_Is_Object($sObjectRef))  //is a valid object in memory
	
	$tTagName:=Replace string:C233($2; Char:C90(Space:K15:42); "_")  // Sep 5, 2012 10:14:18 -- I.Barclay Berry ADDED can't have spaces in name
	
	$tTagname:=XT_Get_Root($sObjectRef)+$tTagName
	$ptrValue:=$3
	
	$iType:=Type:C295($ptrValue->)
	
	$sElemRef:=DOM Find XML element:C864($sObjectRef; $tTagName)
	If (OK=1)  //element exists so just update the value
		Case of 
			: ($iType=Is picture:K8:10)  //convert to blob
				
			: ($iType=Is pointer:K8:14)  //this shouldn't be b/c we dereference above
				
			: ($iType=Array 2D:K8:24)
				//not supported
			: (($iType>=13) & ($iType<=22))  //all array types
				DOM GET XML ELEMENT VALUE:C731($sElemRef; $tPacked)
				//ARR_ConvertText_to_Array($tPacked;$ptrValue;"|") `<------------- NEED TO UPDATE 
			Else 
				DOM GET XML ELEMENT VALUE:C731($sElemRef; $ptrValue->)
		End case 
		
	Else 
		$iError:=-1  //element not found
		
		
		// added by: Barclay Berry (3/28/15) - clear the value
		Case of 
			: ($iType=Is longint:K8:6) | ($iType=Is real:K8:4) | ($iType=Is integer:K8:5)
				$ptrValue->:=0
			: ($iType=Is picture:K8:10)
			: ($iType=Is pointer:K8:14)
			: ($iType=Array 2D:K8:24)
			Else 
				$ptrValue->:=""
		End case 
		
	End if 
	
Else 
	$iError:=-2  //not a valid xml object
End if 

$0:=$iError