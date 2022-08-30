//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 04/22/18, 08:17:14
// ----------------------------------------------------
// Method: webGetWebUser
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($1; $tKey)

C_TEXT:C284($0)

C_POINTER:C301($ptrField)
C_LONGINT:C283($iType)

//TRACE

If (Count parameters:C259>=1)
	$tKey:=$1
	
	If (Substring:C12($tKey; 1; 1)="/")
		$tKey:=Substring:C12($tKey; 2; Length:C16($tKey))
	End if 
Else 
	$tKey:=""
End if 


QUERY:C277([WebUsers:14]; [WebUsers:14]webUsername:1=webUserName)


If (Records in selection:C76([WebUsers:14])=1)
	
	$ptrField:=WAPI_txt2Field($tKey)
	
	If (Not:C34(Is nil pointer:C315($ptrField)))
		$iType:=Type:C295($ptrField->)
		
		If ($iType=Is text:K8:3) | ($iType=Is alpha field:K8:1) | ($iType=Is string var:K8:2)
			$0:=$ptrField->
		Else 
			$0:=String:C10($ptrField->)
		End if 
		
		
	Else 
		$0:=""
	End if 
	
Else 
	$0:=""
End if 

