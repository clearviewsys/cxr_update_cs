//%attributes = {}
//handleSaveCustomerAddress
//used for the [Customers] entry form when Save button is pressed, to create/update [Address] record 
//PRE: one customer record is selected (as a result of pressing Save button in [Customers] entry form)
//#ORDA
C_OBJECT:C1216($existingAddressEntityObj; $addressEntitySelection)

//----------------------------
//find [Address] record for [Customer], or we need to create a new one
//----------------------------
C_BOOLEAN:C305($isAddressRecordNew)
$isAddressRecordNew:=False:C215
If ([Customers:3]MainAddressID:147="")
	$isAddressRecordNew:=True:C214
Else 
	$addressEntitySelection:=ds:C1482.Addresses.query("AddressID = :1"; [Customers:3]MainAddressID:147)
	If ($addressEntitySelection.length=1)  //the previous [Address] record is found
		$existingAddressEntityObj:=$addressEntitySelection.first()
	Else   //have trouble finding previous address record, create new one
		$isAddressRecordNew:=True:C214
	End if 
End if 

//----------------------------
//if Address record is new, fill with proper values
//if Address record is existing, do a diff and decide if anything has changed. If it is, ask customer to create a new one or update existing.
//use customerAddressObj as the source of values, if it exists. Else, use [Customer] address fields instead.
//Note: customerAddressObj is set in [Customers]Entry form if the user presses "+" button in Address area of the form, enters some information and saves. 
//----------------------------
C_BOOLEAN:C305($isAddressChanged)
C_TEXT:C284($addressId)
C_OBJECT:C1216(customerAddressObj)
If ((Undefined:C82(customerAddressObj)) | (customerAddressObj=Null:C1517))
	//use [Customers] address values as the source to create/update [Address] record
	If ($isAddressRecordNew)
		$addressId:=createRecordCustomerAddress([Customers:3]CustomerID:1; "Main"; [Customers:3]AddressUnitNo:148; [Customers:3]Address:7; [Customers:3]PostalCode:10; [Customers:3]City:8; [Customers:3]Province:9; [Customers:3]CountryCode:113)
		[Customers:3]MainAddressID:147:=$addressId
	Else   //update if anything has changed
		$isAddressChanged:=($existingAddressEntityObj.CountryCode#[Customers:3]CountryCode:113) | ($existingAddressEntityObj.State#[Customers:3]Province:9) | ($existingAddressEntityObj.City#[Customers:3]City:8) | ($existingAddressEntityObj.ZipCode#[Customers:3]PostalCode:10) | ($existingAddressEntityObj.Address#[Customers:3]Address:7) | ($existingAddressEntityObj.UnitNo#[Customers:3]AddressUnitNo:148)
		If ($isAddressChanged)
			myConfirm("This customer's address has been changed. Would you like to create a new address record or update the existing one?"; "Create new"; "Update existing")
			If (OK=1)  //create a new record
				$addressId:=createRecordCustomerAddress([Customers:3]CustomerID:1; "Main"; [Customers:3]AddressUnitNo:148; [Customers:3]Address:7; [Customers:3]PostalCode:10; [Customers:3]City:8; [Customers:3]Province:9; [Customers:3]CountryCode:113)
				[Customers:3]MainAddressID:147:=$addressId
			Else   //update existing address record
				$existingAddressEntityObj.CountryCode:=[Customers:3]CountryCode:113
				$existingAddressEntityObj.State:=[Customers:3]Province:9
				$existingAddressEntityObj.City:=[Customers:3]City:8
				$existingAddressEntityObj.ZipCode:=[Customers:3]PostalCode:10
				$existingAddressEntityObj.Address:=[Customers:3]Address:7
				$existingAddressEntityObj.UnitNo:=[Customers:3]AddressUnitNo:148
				$existingAddressEntityObj.save(dk auto merge:K85:24)
			End if 
			
		End if 
	End if 
	
Else   //use customerAddressObj as the source of values, which was provided in [Addresses] Entry2 form when customer pressed "+" button and entered values
	
	If ($isAddressRecordNew)
		$addressId:=createRecordCustomerAddress([Customers:3]CustomerID:1; customerAddressObj.Type; customerAddressObj.UnitNo; customerAddressObj.Address; customerAddressObj.ZipCode; customerAddressObj.City; customerAddressObj.State; customerAddressObj.CountryCode; customerAddressObj.Latitude; customerAddressObj.Longitude)
		[Customers:3]MainAddressID:147:=$addressId
	Else 
		$isAddressChanged:=($existingAddressEntityObj.CountryCode#customerAddressObj.CountryCode) | ($existingAddressEntityObj.State#customerAddressObj.State) | ($existingAddressEntityObj.City#customerAddressObj.City) | ($existingAddressEntityObj.ZipCode#customerAddressObj.ZipCode) | ($existingAddressEntityObj.Address#customerAddressObj.Address) | ($existingAddressEntityObj.UnitNo#customerAddressObj.UnitNo)
		If ($isAddressChanged)
			myConfirm("This customer's address has been changed. Would you like to create a new address record or update the existing one?"; "Create new"; "Update existing")
			If (OK=1)  //create a new record
				$addressId:=createRecordCustomerAddress([Customers:3]CustomerID:1; customerAddressObj.Type; customerAddressObj.UnitNo; customerAddressObj.Address; customerAddressObj.ZipCode; customerAddressObj.City; customerAddressObj.State; customerAddressObj.CountryCode; customerAddressObj.Latitude; customerAddressObj.Longitude)
				[Customers:3]MainAddressID:147:=$addressId
			Else   //update existing address record
				$existingAddressEntityObj.CountryCode:=customerAddressObj.CountryCode
				$existingAddressEntityObj.State:=customerAddressObj.State
				$existingAddressEntityObj.City:=customerAddressObj.City
				$existingAddressEntityObj.ZipCode:=customerAddressObj.ZipCode
				$existingAddressEntityObj.Address:=customerAddressObj.Address
				$existingAddressEntityObj.UnitNo:=customerAddressObj.UnitNo
				$existingAddressEntityObj.Latitude:=customerAddressObj.Latitude
				$existingAddressEntityObj.Longitude:=customerAddressObj.Longitude
				$existingAddressEntityObj.save(dk auto merge:K85:24)
			End if 
			
		End if 
	End if 
	
End if 
//clear the process object
customerAddressObj:=Null:C1517