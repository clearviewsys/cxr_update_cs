// Reads an image document use the method createDocReader to create a general version
Function getFirstName()->$result : Text
	return ""
	
Function getLastName()->$result : Text
	return ""
	
Function getDOB()->$result : Date
	return !00-00-00!
	
Function getPhone()->$result : Text
	return ""
	
Function getAddress()->$result : Text
	return ""
	
Function getCity()->$result
	return ""
	
Function getPostalCode()->$result : Text
	return ""
	
	// Country_obs
	// WorkTel, CellPhone, SIN_NO
	
Function getPictureIDIssueDate()->$result : Date
	return !00-00-00!
	
Function getEmail()->$result : Text
	return ""
	
Function getCountryOfBirth()->$result : Text
	return ""
	
	// PitureID_GovernmentCode
Function getOccupation()->$result : Text
	return ""
	
	// CitizenshipCountryCode
Function getJobTitle()->$result : Text
	return ""
	
	// DocumentsVerificationDate
	
Function getCompany()->$result : Text
	return ""
	
	// Comments
	
Function getAddressCountry()->$result : Text
	return ""  // TODO
	
Function getPictureIDNumber()->$result : Text
	return ""
	
Function getPictureIDType()->$result : Text
	return ""
	
Function getPictureIDExpireDate()->$result : Date
	return !00-00-00!
	
Function getPictureIDIssueState()->$result : Text
	return ""
	
Function getPictureIDIssueCountury()->$result : Text
	return ""
	
Function getEthnicName()->$result : Text
	return ""
	
Function getPreferredLanguage()->$result : Text
	return ""
	
Function getNationality()->$result : Text
	return ""
	
Function getCountryCode()->$result : Text
	return ""
	
Function getPictureIDAuthority()->$result : Text
	return ""
	
Function getPictureIDCountryCode()->$result : Text
	return ""
	
Function getGender()->$result : Text
	return ""
	
Function getURL()->$result : Text
	return ""
	
Function getAddressUnitNo()->$result : Text
	return ""
	
Function getDocPic()->$result : Picture
	
Function addImage($image : Picture)->$result : cs:C1710.DocReader
	return This:C1470
Function processData()->$result : cs:C1710.DocReader
	return This:C1470
	
Function fillCustomerData->$result : cs:C1710.DocReader
	This:C1470.pickFilled(->[Customers:3]FirstName:3; This:C1470.getFirstName())
	This:C1470.pickFilled(->[Customers:3]LastName:4; This:C1470.getLastName())
	This:C1470.pickFilled(->[Customers:3]DOB:5; This:C1470.getDOB())
	This:C1470.pickFilled(->[Customers:3]HomeTel:6; This:C1470.getPhone())
	This:C1470.pickFilled(->[Customers:3]Address:7; This:C1470.getAddress())
	This:C1470.pickFilled(->[Customers:3]City:8; This:C1470.getCity())
	This:C1470.pickFilled(->[Customers:3]PostalCode:10; This:C1470.getPostalCode())
	This:C1470.pickFilled(->[Customers:3]PictureID_IssueDate:16; This:C1470.getPictureIDIssueDate())
	This:C1470.pickFilled(->[Customers:3]Email:17; This:C1470.getEmail())
	This:C1470.pickFilled(->[Customers:3]CountryOfBirthCode:18; This:C1470.getCountryOfBirth())
	This:C1470.pickFilled(->[Customers:3]Occupation:21; This:C1470.getOccupation())
	This:C1470.pickFilled(->[Customers:3]JobTitle:23; This:C1470.getJobTitle())
	This:C1470.pickFilled(->[Customers:3]CompanyName:42; This:C1470.getCompany())
	This:C1470.pickFilled(->[Customers:3]PictureID_Number:69; This:C1470.getPictureIDNumber())
	This:C1470.pickFilled(->[Customers:3]PictureID_Type:70; This:C1470.getPictureIDType())
	This:C1470.pickFilled(->[Customers:3]PictureID_ExpiryDate:71; This:C1470.getPictureIDExpireDate())
	This:C1470.pickFilled(->[Customers:3]PictureID_IssueState:72; This:C1470.getPictureIDIssueState())
	This:C1470.pickFilled(->[Customers:3]PictureID_IssueCountry:73; This:C1470.getPictureIDIssueCountury())
	This:C1470.pickFilled(->[Customers:3]UNICODE_EthnicName:74; This:C1470.getEthnicName())
	This:C1470.pickFilled(->[Customers:3]PreferredLanguage:84; This:C1470.getPreferredLanguage())
	This:C1470.pickFilled(->[Customers:3]Nationality:91; This:C1470.getNationality())
	This:C1470.pickFilled(->[Customers:3]CountryCode:113; This:C1470.getCountryCode())
	This:C1470.pickFilled(->[Customers:3]PictureID_Authority:116; This:C1470.getPictureIDAuthority())
	This:C1470.pickFilled(->[Customers:3]PictureID_CountryCode:118; This:C1470.getPictureIDCountryCode())
	This:C1470.pickFilled(->[Customers:3]Gender:120; This:C1470.getGender())
	This:C1470.pickFilled(->[Customers:3]URL:137; This:C1470.getURL())
	This:C1470.pickFilled(->[Customers:3]AddressUnitNo:148; This:C1470.getAddressUnitNo())
	
Function pickFilled($previous : Pointer; $new)
	var $hasNew : Boolean
	Case of 
		: (Value type:C1509($new)=Is text:K8:3)
			$hasNew:=$new#""
		: (Value type:C1509($new)=Is date:K8:7)
			$hasNew:=$new#!00-00-00!
	End case 
	
	If ($hasNew)
		// if ($previous#"")
		// end if
		$previous->:=$new
	End if 
	