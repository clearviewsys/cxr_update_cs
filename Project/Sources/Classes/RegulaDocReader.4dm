Class extends DocReader
Class constructor($processParam : Object)
	
	If (Count parameters:C259<1)
		$processParam:=New object:C1471("scenario"; "FullProcess")
	End if 
	
	This:C1470.input:=New object:C1471
	This:C1470.input.processParam:=$processParam
	This:C1470.input.List:=New collection:C1472
	
Function addImage($image : Picture)->$result : cs:C1710.RegulaDocReader
	
	If (Count parameters:C259#1)
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
	End if 
	var $data : Object
	$data:=New object:C1471
	var $encoded : Text
	var $imageBlob : Blob
	
	PICTURE TO BLOB:C692($image; $imageBlob; "image/jpeg")
	BASE64 ENCODE:C895($imageBlob; $encoded)
	$data.ImageData:=New object:C1471("image"; $encoded)
	This:C1470.input.List.push($data)
	return This:C1470
	
	
Function processData()->$result : cs:C1710.RegulaDocReader
	ASSERT:C1129(This:C1470.input.List.length#0)
	var $url : Text
	var $content; $response : Object
	$content:=This:C1470.input
	$url:="http://regula.clearviewsys.com:8080/api/process"
	var $error : Integer
	$error:=HTTP Request:C1158(HTTP POST method:K71:2; $url; $content; $response)
	This:C1470.output:=$response
	
	var $item : Object
	
	var $data : Object
	var $image : Picture
	var $decoded : Blob
	
	For each ($item; $response.ContainerList.List)
		Case of 
			: ($item.result_type=33)  // Status
				// TODO: Status
				This:C1470.status:=New object:C1471("raw"; $item)
				
			: ($item.result_type=36)  // Text
				// MARK: Document Text Fields
				This:C1470.text:=New object:C1471("raw"; $item; "data"; New object:C1471)
				var $subItem : Object
				For each ($subItem; $item.Text.fieldList)
					OB SET:C1220(This:C1470.text.data; "field"+String:C10($subItem.fieldType); $subItem)
				End for each 
				
			: ($item.result_type=1)  // Document Image
				// MARK: Formated Document Image
				BASE64 DECODE:C896($item.RawImageContainer.image; $decoded)
				BLOB TO PICTURE:C682($decoded; $image)
				This:C1470.docImage:=New object:C1471("raw"; $item; "image"; $image)
				
			: ($item.result_type=37)  // Images
				// MARK: Extracted Images
				This:C1470.images:=New object:C1471("raw"; $item; "data"; OB Copy:C1225($item))
				
				var $field; $value : Object
				For each ($field; This:C1470.images.data.Images.fieldList)
					For each ($value; $field.valueList)
						If (OB Is defined:C1231($value; "value"))
							BASE64 DECODE:C896($value.value; $decoded)
							BLOB TO PICTURE:C682($decoded; $image)
							$value.value:=$image
						End if 
						If (OB Is defined:C1231($value; "originalValue"))
							BASE64 DECODE:C896($value.originalValue; $decoded)
							BLOB TO PICTURE:C682($decoded; $image)
							$value.originalValue:=$image
						End if 
					End for each 
				End for each 
				This:C1470.images:=$item
				
			: ($item.result_type=9)  // Document Type
				// TODO: Document Type
				This:C1470.docType:=$item
				
			: ($item.result_type=8)  // Document Type Candidate
				// TODO: Document Type Candidate
				This:C1470.docTypeCandidates:=$item
				
			: ($item.result_type=15)  // Lexical Analysis
				// TODO: Lexical Analysis
				This:C1470.lexicalAnalysis:=$item
				
			: ($item.result_type=20)  // Authenticity checks
				//TODO: Authenticity checks
				
			: ($item.result_type=33)  // Image quality
				// TODO: Image quality
				This:C1470.imageQulityCheck:=$item
				
			: ($item.result_type=85)  // Document Position
				// TODO: Document Position
				This:C1470.docPosition:=$item
				
			: ($item.result_type=18)  // Barcode Text
				// TODO: Barcode Text
				This:C1470.docBarCode:=$item
				
			: ($item.result_type=50)  // License
				// TODO: License
				This:C1470.license:=$item
				
			: ($item.result_type=49)  //Encrypted RCL
				// TODO: Encrypted RCL
				This:C1470.encryptedRCL:=$item
		End case 
	End for each 
	return This:C1470
	
Function getText($fieldType : Integer)->$result : Text
	// Check: https://docs.regulaforensics.com/develop/doc-reader-sdk/web-service/development/enums/field-type/
	var $found : Object
	$found:=This:C1470.getTextData($fieldType)
	If ($found#Null:C1517)
		return $found.value
	End if 
Function getTextData($fieldType : Integer)->$result : Object
	// Check: https://docs.regulaforensics.com/develop/doc-reader-sdk/web-service/development/enums/field-type/
	return OB Get:C1224(This:C1470.text.data; "field"+String:C10($fieldType))
	
Function getFirstName()->$result : Text
	return This:C1470.getText(regula_GivenName)
	
Function getLastName()->$result : Text
	return This:C1470.getText(regula_Surname)
	
Function getDOB()->$result : Date
	var $text : Text
	$text:=This:C1470.getText(regula_DateOfBirth)
	return Date:C102($text)
	
Function getPhone()->$result : Text
	return This:C1470.getText(regula_Phone)
	
Function getAddress()->$result : Text
	return This:C1470.getText(regula_AddressStreet)
	
Function getPostalCode()->$result : Text
	return This:C1470.getText(regula_AddressPostalCode)
	
Function getPictureIDIssueDate()->$result : Date
	var $text : Text
	$text:=This:C1470.getText(regula_DateOfIssue)
	return Date:C102($text)
	
Function getCountryOfBirth()->$result : Text
	return This:C1470.getText(regula_PlaceOfBirth)
	
Function getOccupation()->$result : Text
	return This:C1470.getText(regula_Profession)
	
Function getJobTitle()->$result : Text
	return This:C1470.getText(regula_Title)
	
Function getCompany()->$result : Text
	return This:C1470.getText(regula_CompanyName)
	
Function getAddressCountry()->$result : Text
	return This:C1470.getText(regula_AddressCountry)
	
Function getPictureIDNumber()->$result : Text
	return This:C1470.getText(regula_DocumentNumber)
	
Function getPictureIDType()->$result : Text
	return This:C1470.getText(regula_DocumentClassName)
	
Function getPictureIDExpireDate()->$result : Date
	var $text : Text
	$text:=This:C1470.getText(regula_DateOfExpiry)
	return Date:C102($text)
	
Function getPictureIDIssueState()->$result : Text
	return This:C1470.getText(regula_IssuingStateCode)
	
Function getPictureIDIssueCountury()->$result : Text
	return This:C1470.getText(regula_PlaceOfIssue)
	
Function getEthnicName()->$result : Text
	return This:C1470.getText(regula_RaceEthnicity)
	
Function getNationality()->$result : Text
	return This:C1470.getText(regula_Nationality)
	
Function getGender()->$result : Text
	return This:C1470.getText(regula_Sex)
	
Function getURL()->$result : Text
	return This:C1470.getText(regula_Url)
	
Function getAddressUnitNo()->$result : Text
	return This:C1470.getText(regula_AddressFlat)
	
Function getDocPic()->$result : Picture
	return This:C1470.docImage.image