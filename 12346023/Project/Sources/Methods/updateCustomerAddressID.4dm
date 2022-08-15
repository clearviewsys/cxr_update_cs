//%attributes = {}
//Amir
// updates main address (in Addresses table) for Customers
// this method is used in [Customers] entry form when saved
// it can also be run with updateTableUsingMethod (->[Customers];"updateCustomerAddressID";False) : void

// PRE: The calling method has already selected the proper [Customers] selection
// POST: if used with updateTableUsingMethod, the [Customers] table becomes read-only (beacause of updateTableUsingMethod)


C_TEXT:C284($addressId)
C_OBJECT:C1216($splittedStreetAddress)

$splittedStreetAddress:=splitAddressToUnitAndStreet([Customers:3]Address:7)
If ([Customers:3]MainAddressID:147#"")
	
	QUERY:C277([Addresses:147]; [Addresses:147]AddressID:18=[Customers:3]MainAddressID:147)
	If (Records in selection:C76([Addresses:147])=1)
		//Check if anything for address has changed, then update
		C_BOOLEAN:C305($shouldUpdateAddress)
		$shouldUpdateAddress:=([Addresses:147]CountryCode:7#[Customers:3]CountryCode:113) | ([Addresses:147]City:4#[Customers:3]City:8) | ([Addresses:147]ZipCode:6#[Customers:3]PostalCode:10) | ([Addresses:147]State:5#[Customers:3]Province:9) | ([Addresses:147]Address:3#$splittedStreetAddress.streetAddress) | ([Addresses:147]UnitNo:15#$splittedStreetAddress.unitNumber)
		If ($shouldUpdateAddress)
			READ WRITE:C146([Addresses:147])
			[Addresses:147]Type:1:="Old-Main"
			SAVE RECORD:C53([Addresses:147])
			UNLOAD RECORD:C212([Addresses:147])
			$addressId:=createRecordCustomerAddress([Customers:3]CustomerID:1; "Main"; $splittedStreetAddress.unitNumber; $splittedStreetAddress.streetAddress; [Customers:3]PostalCode:10; [Customers:3]City:8; [Customers:3]Province:9; [Customers:3]CountryCode:113)
			[Customers:3]MainAddressID:147:=$addressId
		End if 
	Else 
		//if we dont find that adress, create a new one
		$addressId:=createRecordCustomerAddress([Customers:3]CustomerID:1; "Main"; $splittedStreetAddress.unitNumber; $splittedStreetAddress.streetAddress; [Customers:3]PostalCode:10; [Customers:3]City:8; [Customers:3]Province:9; [Customers:3]CountryCode:113)
		[Customers:3]MainAddressID:147:=$addressId
	End if 
Else 
	$addressId:=createRecordCustomerAddress([Customers:3]CustomerID:1; "Main"; $splittedStreetAddress.unitNumber; $splittedStreetAddress.streetAddress; [Customers:3]PostalCode:10; [Customers:3]City:8; [Customers:3]Province:9; [Customers:3]CountryCode:113)
	[Customers:3]MainAddressID:147:=$addressId
End if 






