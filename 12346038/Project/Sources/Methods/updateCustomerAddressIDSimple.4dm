//%attributes = {}
//Amir 16th July 2020
// performs address migration from customers table to address table
// it is meant to be run with updateTableUsingMethod (->[Customers];"updateCustomerAddressIDSimple";False) : void

// PRE: The calling method has already selected the proper [Customers] selection
// POST: if used with updateTableUsingMethod, the [Customers] table becomes read-only (beacause of updateTableUsingMethod)

//split address to unit and street address for [Customers]

//Unit test done??

If ([Customers:3]AddressUnitNo:148="")
	splitAddressToUnitStreetFields([Customers:3]Address:7; ->[Customers:3]Address:7; ->[Customers:3]AddressUnitNo:148)
End if 

//create an address record
C_TEXT:C284($addressId)
$addressId:=createRecordCustomerAddress([Customers:3]CustomerID:1; "Main"; [Customers:3]AddressUnitNo:148; [Customers:3]Address:7; [Customers:3]PostalCode:10; [Customers:3]City:8; [Customers:3]Province:9; [Customers:3]CountryCode:113)
[Customers:3]MainAddressID:147:=$addressId






