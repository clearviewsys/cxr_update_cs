//%attributes = {}
// IdentityMind_loadTransferData(->$errors;->$registerTablePtr;->$customerTablePtr;$isTransferIn)
// load KYC data into a JSON object and validate the object
//  
// Parameters:
// $errors (C_Pointer to ARRAY TEXT)
//     where the list of errors
// registerTablePtr (C_Pointer to [Registers])
//     [Register] selection
// $customerTablePtr (C_Pointer to [Customers])
//     [Customers] selection
// $isTransferIn (C_Boolean)
//     is record is a transfer in

// === PART 1: setup ===

C_OBJECT:C1216($1; $register)
C_BOOLEAN:C305($2; $isTransferIn)
C_TEXT:C284($3; $baseCurrency)

Case of 
	: (Count parameters:C259=3)
		$register:=$1
		$isTransferIn:=$2
		$baseCurrency:=$3
	Else 
		EXECUTE METHOD:C1007("assertInvalidNumberOfParams"; *; Current method name:C684; Count parameters:C259)
End case 

ASSERT:C1129(IdentityMindEndpoint#"")

C_OBJECT:C1216($input)
$input:=New object:C1471

C_BOOLEAN:C305($willSend)
$willSend:=True:C214

// === PART 2: Extract Data

C_TEXT:C284($profile)
EXECUTE METHOD:C1007("getKeyValue"; $profile; "identityMind.TransferProfileName")
If ($profile#"")
	$input.profile:=$profile
End if 

C_OBJECT:C1216($customer)
$customer:=$register.customer

$willSend:=Not:C34($register.isTransfer)
If ($willSend)
	$willSend:=Not:C34($register.isCancelled)
End if 
If ($willSend)
	$willSend:=Not:C34($customer.isInsider)
End if 
If ($willSend)
	$willSend:=Not:C34($customer.isMSB)
End if 
If ($willSend)
	$willSend:=Not:C34($customer.isWholesaler)
End if 
If ($willSend)
	$willSend:=Not:C34($customer.isWalkin)
End if 
If ($willSend)
	$willSend:=Not:C34($customer.AML_ignoreKYC)
End if 

If ($willSend)
	If ($register.CustomerID#"")
		$input.man:=$register.CustomerID
		$input.dman:=$register.CustomerID
	End if 
	
	$input.tags:=New collection:C1472
	If (Is table number valid:C999($register.InternalTableNumber))
		C_TEXT:C284($tableName)
		$tableName:=Table name:C256($register.InternalTableNumber)
		Case of 
			: ($tableName="CashTransactions")
				$input.tags.push("cash")
			: ($tableName="Cheques")
				$input.tags.push("cheque")
			: ($tableName="Wires")
				$input.tags.push("wire")
			: ($tableName="eWires")
				$input.tags.push("eWire")
			: ($tableName="AccountInOuts")
				$input.tags.push("account")
			: ($tableName="ItemInOuts")
				$input.tags.push("item")
			Else   // Not a known table id
				$input.tags.push("other")
		End case 
	Else   // When the InternalTableID is not even a valid table id 
		$input.tags.push("other")
	End if 
	$input.tags.push($register.AccountID)
	
	If (($register.CreationTime#?00:00:00?) & ($register.CreationDate#!00-00-00!))
		$input.tti:=String:C10($register.CreationDate; ISO date GMT:K1:10; $register.CreationTime)
	End if 
	
	If ($register.RegisterID#"")
		$input.tid:=$register.RegisterID
		IdentityMindID:=$register.RegisterID
	End if 
	
	If (Not:C34($isTransferIn))
		$input.amt:=$register.DebitLocal
	Else 
		$input.amt:=$register.CreditLocal
	End if 
	
	$input.ccy:=$baseCurrency
	
	If ($customer.Email#"")
		If ($isTransferIn)
			$input.tea:=$customer.Email
		Else 
			$input.demail:=$customer.Email
		End if 
	End if 
	
	If (($customer.FirstName#"") & $isTransferIn)
		$input.bfn:=$customer.FirstName
	End if 
	
	If (($customer.LastName#"") & $isTransferIn)
		$input.bln:=$customer.LastName
	End if 
	
	If (($customer.Address#"") & $isTransferIn)
		$input.bsn:=$customer.Address
	End if 
	
	If (($customer.CountryCode#"") & $isTransferIn)
		$input.bco:=$customer.CountryCode
	End if 
	
	If (($customer.PostalCode#"") & $isTransferIn)
		$input.bz:=$customer.PostalCode
	End if 
	
	
	If (($customer.City#"") & $isTransferIn)
		$input.bc:=$customer.City
	End if 
	
	If (($customer.Province#"") & $isTransferIn)
		$input.bs:=$customer.Province
	End if 
	
	If (($customer.Gender#"") & $isTransferIn)
		$input.bgd:=$customer.Gender
	End if 
	
	If ($customer.HomeTel#"")
		If ($isTransferIn)
			$input.phn:=$customer.HomeTel
		Else 
			$input.dph:=$customer.HomeTel
		End if 
	End if 
	
	If (($customer.CellPhone#"") & $isTransferIn)
		$input.pm:=$customer.CellPhone
	End if 
	
	If (($customer.WorkTel#"") & $isTransferIn)
		$input.pw:=$customer.WorkTel
	End if 
End if 

If ($willSend)
	// === PART 3:  Insert data ===
	IdentityMindInput:=$input
Else 
	IdentityMindInput:=Null:C1517
End if 