//%attributes = {}
// IdentityMind_loadKYCData($customer)
// load KYC data into a JSON object and validate the object
//
// Parameters:
// $errors (C_Pointer to ARRAY TEXT)
//     where the list of errors
// $customerTablePtr (C_Pointer to [Customers]
//     [Customers] selection

// === PART 1: setup ===

C_OBJECT:C1216($1; $customer)  // C_OBJECT to [Customer] entity
C_BOOLEAN:C305($0; $pass)
Case of 
	: (Count parameters:C259=1)
		$customer:=$1
	Else 
		EXECUTE METHOD:C1007("assertInvalidNumberOfParams"; *; Current method name:C684; Count parameters:C259)
End case 
ASSERT:C1129(Not:C34(Undefined:C82(IdentityMindInput)))
ASSERT:C1129(Not:C34(Undefined:C82(IdentityMindID)))

C_OBJECT:C1216($input)
$input:=New object:C1471

// === PART 2: Extract Data

C_TEXT:C284($profile)
EXECUTE METHOD:C1007("getKeyValue"; $profile; "identityMind.KYCProfileName")
If ($profile#"")
	$input.profile:=$profile
End if 

If ($customer.CustomerID#"")
	$input.man:=$customer.CustomerID
	IdentityMindID:="KYC"+$input.man
	$input.tid:=IdentityMindID
End if 

If ($customer.Email#"")
	$input.tea:=$customer.Email
End if 

If ($customer.FirstName#"")
	If ($customer.isCompany)
		$input.afn:=$customer.FirstName
	Else 
		$input.bfn:=$customer.FirstName
	End if 
End if 

If ($customer.LastName#"")
	If ($customer.isCompany)
		$input.aln:=$customer.LastName
	Else 
		$input.bln:=$customer.LastName
	End if 
End if 

If ($customer.Address#"")
	C_TEXT:C284($address)
	$address:=IdentityMind_reformatAddress($customer.Address)
	If ($customer.isCompany)
		$input.asn:=$address
	Else 
		$input.bsn:=$address
	End if 
End if 

If ($customer.CountryCode#"")
	If ($customer.isCompany)
		$input.aco:=$customer.CountryCode
	Else 
		$input.bco:=$customer.CountryCode
	End if 
End if 

If ($customer.PostalCode#"")
	If ($customer.isCompany)
		$input.az:=$customer.PostalCode
	Else 
		$input.bz:=$customer.PostalCode
	End if 
End if 

If ($customer.Province#"")
	If ($customer.isCompany)
		$input.as:=$customer.Province
	Else 
		$input.bs:=$customer.Province
	End if 
End if 

If ($customer.City#"")
	If ($customer.isCompany)
		$input.ac:=$customer.City
	Else 
		$input.bc:=$customer.City
	End if 
End if 

If ($customer.Gender#"")
	// Gender - uses M and F therefore okay
	$input.bgd:=$customer.Gender
End if 

If ($customer.HomeTel#"")
	$input.phn:=$customer.HomeTel
End if 

If ($customer.CellPhone#"")
	$input.pm:=$customer.CellPhone
End if 

If ($customer.WorkTel#"")
	$input.pw:=$customer.WorkTel
End if 

If (($customer.CreationTime#?00:00:00?) & ($customer.CreationDate#!00-00-00!))
	$input.accountCreationTime:=String:C10($customer.CreationDate; ISO date GMT:K1:10; $customer.CreationTime)
End if 

If ($customer.CompanyName#"")
	$input.amn:=$customer.CompanyName
End if 

If ($customer.BusinessPhone1#"")
	$input.aph:=$customer.BusinessPhone1
End if 

If ($customer.DOB#!00-00-00!)
	$input.dob:=String:C10(Year of:C25($customer.DOB))+"-"
	$input.dob:=$input.dob+String:C10(Month of:C24($customer.DOB))+"-"
	$input.dob:=$input.dob+String:C10(Day of:C23($customer.DOB))
End if 

//If ($customer.SIN_NO="SIN_No")
//  // sin card number - procced without a issue country
//$input.assn:=":"+$customer.SIN_NO
// End if


// === PART 3:  Insert data ===
IdentityMindInput:=$input

// === PART 4: Test data ===
ARRAY TEXT:C222($none; 0)

$0:=True:C214