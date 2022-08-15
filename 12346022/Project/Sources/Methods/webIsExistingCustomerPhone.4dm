//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 12/12/20, 17:17:19
// ----------------------------------------------------
// Method: webIsExistingCustomerPhone
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($0)
C_OBJECT:C1216($entity)

//assumes [webusers] record is loaded

If ([WebUsers:14]phone:19="")
	$0:=""
Else 
	$entity:=ds:C1482.Customers.query("CellPhone == :1 OR WorkTel == :1 OR HomeTel == :1 OR BusinessPhone1 == :1 OR BusinessPhone2 == :1"; [WebUsers:14]phone:19)
	
	If ($entity.length>0)
		$0:="NOTE: Your phone number: "+[WebUsers:14]phone:19+" is registered to an existing customer."
	Else 
		$0:=""
	End if 
End if 