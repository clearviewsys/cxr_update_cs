//%attributes = {"shared":true}


// ----------------------------------------------------
// User name (OS): barclay
// Date and time: 09/09/21, 08:41:56
// ----------------------------------------------------
// Method: getFinalStatusForWebEwire
// Description
// 
//
// Parameters
// ----------------------------------------------------




C_TEXT:C284($0)

C_TEXT:C284($type)
C_OBJECT:C1216($entity)

$type:=getWebEwireType



Case of 
	: ($type="MG")
		
		
	Else   //ewire
		
		$entity:=ds:C1482.eWires.query("WebEwireID == :1"; [WebEWires:149]WebEwireID:1)
		
		Case of 
			: ($entity.length=0)
				$0:="NOT Found"
			: ($entity.length=1)
				$0:=$entity.first().Status
				
			Else 
				$0:="MULTIPLE Found"
		End case 
		
End case 