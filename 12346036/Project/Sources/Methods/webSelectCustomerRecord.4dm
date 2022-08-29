//%attributes = {"shared":true,"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 05/21/18, 16:34:28
// ----------------------------------------------------
// Method: webSelectCustomer
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($tWebEmail)
C_OBJECT:C1216($entity)
C_TEXT:C284($tCustomerID)

$tWebEmail:=WAPI_getSession("email")  //WEBEMAILADDRESS
$tCustomerID:=WAPI_getSession("customerid")


Case of 
	: (Is new record:C668([Customers:3])) & ([Customers:3]Email:17=$tWebEmail)
		//dont change change the current selection
	: (Records in selection:C76([Customers:3])=1) & ([Customers:3]Email:17=$tWebEmail)
		//nothing else needed - don't change the read write state
	Else 
		
		Case of 
			: ($tWebEmail="") & ($tCustomerID="")
				$entity:=New object:C1471
				$entity.length:=0
				
			: ($tCustomerID#"")
				$entity:=ds:C1482.Customers.query("CustomerID IS :1"; $tCustomerID)
				
			Else   //use webemail
				$entity:=ds:C1482.Customers.query("Email IS :1"; $tWebEmail)
		End case 
		
		If ($entity.length=1)
			SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
			READ ONLY:C145([Customers:3])
			USE ENTITY SELECTION:C1513($entity)
			LOAD RECORD:C52([Customers:3])
		Else 
			REDUCE SELECTION:C351([Customers:3]; 0)
			iH_Notify(Current method name:C684; "customer not found: "+$tWebEmail+" || "+$tCustomerID; 30)
		End if 
		
End case 


webSetSyncSiteId([Customers:3]CountryOfResidenceCode:114)