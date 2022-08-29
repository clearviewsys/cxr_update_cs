//%attributes = {}

//opens up a new address form for entering address, can also use search function of Canada post API.

C_OBJECT:C1216(customerAddressObj)  //represents an [Address] entity model, but not saved in database
If (customerAddressObj=Null:C1517)  //create it only once, re-use it in subsequent edits
	C_BOOLEAN:C305($shouldUseCustomerAddressValues)
	$shouldUseCustomerAddressValues:=False:C215
	customerAddressObj:=New object:C1471()
	customerAddressObj.RecordId:=[Customers:3]CustomerID:1
	customerAddressObj.TableNo:=Table:C252(->[Customers:3])
	If ([Customers:3]MainAddressID:147#"")
		//if there is [Addresses] record for this customer, initialize form with that. Else, use [Customers] address values
		//#ORDA
		
		C_OBJECT:C1216($existingAddress; $addressEs)
		
		$addressEs:=ds:C1482.Addresses.query("AddressID = :1 and TableNo = :2"; [Customers:3]MainAddressID:147; Table:C252(->[Customers:3]))
		If ($addressEs.length=1)
			$existingAddress:=$addressEs.first()
			customerAddressObj.Type:=$existingAddress.Type  //type of address
			customerAddressObj.CountryCode:=$existingAddress.CountryCode
			customerAddressObj.State:=$existingAddress.State
			customerAddressObj.City:=$existingAddress.City
			customerAddressObj.ZipCode:=$existingAddress.ZipCode
			customerAddressObj.Address:=$existingAddress.Address
			customerAddressObj.UnitNo:=$existingAddress.UnitNo
			customerAddressObj.Latitude:=$existingAddress.Latitude
			customerAddressObj.Longitude:=$existingAddress.Longitude
		Else 
			$shouldUseCustomerAddressValues:=True:C214
		End if 
		
	Else 
		$shouldUseCustomerAddressValues:=True:C214
	End if 
	
	If ($shouldUseCustomerAddressValues)
		customerAddressObj.Type:=""  //type of address
		customerAddressObj.CountryCode:=[Customers:3]CountryCode:113
		customerAddressObj.State:=[Customers:3]Province:9
		customerAddressObj.City:=[Customers:3]City:8
		customerAddressObj.ZipCode:=[Customers:3]PostalCode:10
		customerAddressObj.Address:=[Customers:3]Address:7
		customerAddressObj.UnitNo:=[Customers:3]AddressUnitNo:148
		customerAddressObj.Latitude:=0
		customerAddressObj.Longitude:=0
	End if 
	
End if 

C_BOOLEAN:C305($shouldUpdateAddressValues)
$shouldUpdateAddressValues:=openNewAddressObjectForm(customerAddressObj)
If ($shouldUpdateAddressValues)  //save was pressed
	//updating values shown in customer form. The update to database happens when Save button of [Customers]Entry form is pressed.
	[Customers:3]CountryCode:113:=customerAddressObj.CountryCode
	[Customers:3]Province:9:=customerAddressObj.State
	[Customers:3]City:8:=customerAddressObj.City
	[Customers:3]PostalCode:10:=customerAddressObj.ZipCode
	[Customers:3]Address:7:=customerAddressObj.Address
	[Customers:3]AddressUnitNo:148:=customerAddressObj.UnitNo
Else 
	customerAddressObj:=Null:C1517  //cancell was pressed. Clear the object.
End if 
