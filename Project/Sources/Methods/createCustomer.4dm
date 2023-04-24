//%attributes = {}
// createCustomer (ID: text ; firstName: text ; lastName: text ; companyName: text; type: longint ; settings: object)
// create a new record in the customer table 
// the type will determine if the customer is self; insider ; walkin ; company; account ;  ignoreKYC ; 
// PRE: you are responsible to send a valid and unique CustomerID
// POST: new records will be added to Customers table
// @tiran ; started on Jan 12 / 2021 ; modified on Jan 19/2021
// see also: createDummyCustomers

/* type 
0 : individual
1 : company
2 : insider
4 : walkin
8 : account
16: ignoreKYC
32: 
*/
// ([Customers];"Entry")

C_TEXT:C284($customerID; $firstName; $lastName; $companyName)
C_LONGINT:C283($type)
C_OBJECT:C1216($from)

Case of 
		
	: (Count parameters:C259=5)
		$customerID:=$1
		$firstName:=$2
		$lastName:=$3
		$companyName:=$4
		$type:=$5
		
	: (Count parameters:C259=6)
		$customerID:=$1
		$firstName:=$2
		$lastName:=$3
		$companyName:=$4
		$type:=$5
		$from:=$6  // not working at the moment for future
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

/*
CREATE RECORD([Customers])  // create an ignore KYC persona
[Customers]UUID:=Generate UUID
[Customers]CustomerID:=$customerID
[Customers]FirstName:=$firstName
[Customers]LastName:=$lastName

[Customers]isCompany:=($type=1)
[Customers]isInsider:=($type=2)
[Customers]isWalkin:=($type=4)
[Customers]isAccount:=($type=8)
[Customers]AML_ignoreKYC:=($type=16)

[Customers]CompanyName:=$companyName
SAVE RECORD([Customers])
*/


// to check if the customer already exist 
C_LONGINT:C283(vSize)

If ($type=1)
	vSize:=ds:C1482.Customers.query("(isCompany = :1 & (CompanyName = :2 | FullName = :3))"; True:C214; $companyName; $companyName).length
Else 
	vSize:=ds:C1482.Customers.query("FirstName = :1 & LastName = :2"; $firstName; $lastName).length
End if 

If (vSize=0)
	
	C_OBJECT:C1216($customer; $status)
	$customer:=ds:C1482.Customers.new()  // new entity
	
	If ($from#Null:C1517)
		$customer.fromObject($from)  // first we assign the fields; and then we overwrite them
	End if 
	
	$customer.UUID:=Generate UUID:C1066
	$customer.CustomerID:=$customerID
	$customer.FirstName:=$firstName
	$customer.LastName:=$lastName
	$customer.CompanyName:=$companyName
	$customer.isCompany:=($type ?? 0)  // 
	$customer.isInsider:=($type ?? 1)
	$customer.isWalkin:=($type ?? 2)
	$customer.isAccount:=($type ?? 3)
	$customer.AML_ignoreKYC:=($type ?? 4)
	
	If ($customer.isCompany)
		$customer.FullName:=$companyName
	Else 
		$customer.FullName:=makeFullName($firstName; $lastName)
	End if 
	$status:=$customer.save()
End if 