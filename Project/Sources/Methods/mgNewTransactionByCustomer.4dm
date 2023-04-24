//%attributes = {}
C_TEXT:C284($1; $transactionType)  // "Send" or "Receive"
C_OBJECT:C1216($2; $customer)  // entity from Customers
C_OBJECT:C1216($0; $transaction)
C_COLLECTION:C1488($countries)

$transactionType:=$1
$customer:=$2

$countries:=mgGetCountryCodes

If ($transactionType="Send")
	
	$transaction:=mgCreateSendObject
	
	$transaction.object.transactionType:=$transactionType
	$transaction.object.senderFirstName:=$customer.FirstName
	$transaction.object.senderLastName:=$customer.LastName
	$transaction.object.senderZipCode:=$customer.PostalCode
	$transaction.object.senderCountry:=mgCXR_CountryCode2MG($customer.CountryCode; $countries)
	$transaction.object.senderCity:=$customer.City
	$transaction.object.senderAddress:=$customer.Address
	$transaction.object.senderPhone:=$customer.CellPhone
	$transaction.object.senderEmailAddress:=$customer.Email
	$transaction.object.senderPhoneCountryCode:="1"
	$transaction.object.senderPhotoIdType:=mgCXR_ID_Type2MG($customer.PictureID_Type)
	$transaction.object.senderPhotoIdNumber:=$customer.PictureID_Number
	//$transaction.object.senderPhotoIdIssueDate:=mgGetProfixDate ($customer.PictureID_IssueDate)
	//$transaction.object.senderPhotoIdExpDate:=mgGetProfixDate ($customer.PictureID_ExpiryDate)
	$transaction.object.senderPhotoIdIssueDate:=$customer.PictureID_IssueDate
	$transaction.object.senderPhotoIdExpDate:=$customer.PictureID_ExpiryDate
	$transaction.object.senderPhotoIdCountry:=mgCXR_CountryCode2MG($customer.PictureID_CountryCode; $countries)
	// $transaction.object.senderDOB:=mgGetProfixDate ($customer.DOB)
	$transaction.object.senderDOB:=$customer.DOB
	$transaction.object.senderBirthCountry:=mgCXR_CountryCode2MG($customer.CountryOfBirthCode; $countries)
	
	// Barclay, please add this property out of this method, when used in existing Profix transactions I am getting runtime errors
	// Profix web app doesn'tt allow to pass occupation, so we are not using that 
	
	// $transaction.object.senderOccupation:=$customer.OccupationCode  // need to see about mappiing these??
	
Else 
	
	$transaction:=mgCreateReceiveObject
	
	$transaction.object.transactionType:=$transactionType
	$transaction.object.receiverZipCode:=$customer.PostalCode
	$transaction.object.receiverCountry:=mgCXR_CountryCode2MG($customer.CountryCode; $countries)
	$transaction.object.receiverCity:=$customer.City
	$transaction.object.receiverAddress:=$customer.Address
	$transaction.object.receiverPhone:=$customer.CellPhone
	$transaction.object.receiverPhoneCountryCode:="1"
	$transaction.object.receiverPhotoIdType:=mgCXR_ID_Type2MG($customer.PictureID_Type)
	$transaction.object.receiverPhotoIdNumber:=$customer.PictureID_Number
	//$transaction.object.receiverPhotoIdIssueDate:=mgGetProfixDate ($customer.PictureID_IssueDate)
	//$transaction.object.receiverPhotoIdExpDate:=mgGetProfixDate ($customer.PictureID_ExpiryDate)
	$transaction.object.receiverPhotoIdIssueDate:=$customer.PictureID_IssueDate
	$transaction.object.receiverPhotoIdExpDate:=$customer.PictureID_ExpiryDate
	$transaction.object.receiverPhotoIdCountry:=mgCXR_CountryCode2MG($customer.PictureID_CountryCode; $countries)
	// $transaction.object.receiverDOB:=mgGetProfixDate ($customer.DOB)
	$transaction.object.receiverDOB:=$customer.DOB
	$transaction.object.receiverBirthCountry:=mgCXR_CountryCode2MG($customer.CountryOfBirthCode; $countries)
	
End if 

$transaction.customerID:=$customer.CustomerID

$0:=$transaction
