//%attributes = {}
// FT_GeneratePartD1_EFTO

C_TEXT:C284($1; $fileName)
C_TEXT:C284($2; $partID)

Case of 
	: (Count parameters:C259=1)
		$partID:="D1"
		$fileName:=$1
		
	: (Count parameters:C259=2)
		
		$fileName:=$1
		$partID:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_BLOB:C604($content)

C_TEXT:C284($tmp; $surname; $givenname; $middle; $streetAddress; $city; $country)
C_TEXT:C284($state; $zipCode; $indHomePhoneNumber; $indDateOfBirth; $indOccupation)
C_TEXT:C284($account; $indTypeOtherDesc; $indNum)

C_TEXT:C284($tmp; $tmp1)
C_TEXT:C284($companyName; $surnameAndOthers; $name; $otherName; $indType)



// --------------------------------------------------------------------------------------------------------------------
// Part D1: InInformation about a third party if the client ordering the EFT is acting on behalf of a third 
// party (if applicable)
// --------------------------------------------------------------------------------------------------------------------

If ([Invoices:5]ThirdPartyisInvolved:22)
	
	// Part ID
	//$tmp:="D1"
	TEXT TO BLOB:C554($partID; $content; UTF8 text without length:K22:17; *)
	
	Case of 
			
		: ([ThirdParties:101]IsCompany:2)
			
			// Company Name
			$companyName:=FT_StringFormat(FT_Clean([ThirdParties:101]CompanyName:23); 45)
			TEXT TO BLOB:C554($companyName; $content; UTF8 text without length:K22:17; *)
			
			// surname
			$surnameAndOthers:=FT_StringFormat(" "; 45)
			TEXT TO BLOB:C554($surnameAndOthers; $content; UTF8 text without length:K22:17; *)
			
			
		: ([ThirdParties:101]IsCompany:2=False:C215)
			
			$companyName:=FT_StringFormat(" "; 45)
			TEXT TO BLOB:C554($companyName; $content; UTF8 text without length:K22:17; *)
			
			// surname
			$surname:=FT_StringFormat(FT_Clean([ThirdParties:101]LastName:3); 20)
			TEXT TO BLOB:C554($surname; $content; UTF8 text without length:K22:17; *)
			
			// Given Name
			$name:=FT_StringFormat(FT_Clean([ThirdParties:101]FirstName:4); 15)
			TEXT TO BLOB:C554($name; $content; UTF8 text without length:K22:17; *)
			
			// Other Name
			$otherName:=FT_StringFormat(FT_Clean([ThirdParties:101]OtherName:5); 10)
			TEXT TO BLOB:C554($otherName; $content; UTF8 text without length:K22:17; *)
			
			
	End case 
	
	
	// -----------------------------------------------------------
	
	// Street address
	$streetAddress:=FT_StringFormat(FT_Clean([ThirdParties:101]Address:6); 30)
	TEXT TO BLOB:C554($streetAddress; $content; UTF8 text without length:K22:17; *)
	
	// City
	$city:=FT_StringFormat(FT_Clean([ThirdParties:101]City:7); 25)
	TEXT TO BLOB:C554($city; $content; UTF8 text without length:K22:17; *)
	
	// Country
	$country:=FT_StringFormat(FT_Clean([ThirdParties:101]CountryCode:8); 2)
	TEXT TO BLOB:C554($country; $content; UTF8 text without length:K22:17; *)
	
	
	// -----------------------------------------------------------
	
	// Province/State
	$state:=FT_StringFormat(FT_Clean([ThirdParties:101]theState:29); 20)
	TEXT TO BLOB:C554($state; $content; UTF8 text without length:K22:17; *)
	
	// Postal/zip code
	$zipCode:=FT_StringFormat(FT_Clean([ThirdParties:101]ZipCode:9); 9)
	TEXT TO BLOB:C554($zipCode; $content; UTF8 text without length:K22:17; *)
	
	If ([ThirdParties:101]IsCompany:2=False:C215)
		// Individual's date of birth
		$indDateOfBirth:=FT_GetStringDate([ThirdParties:101]DOB:13)
		TEXT TO BLOB:C554($indDateOfBirth; $content; UTF8 text without length:K22:17; *)
	Else 
		// Entity: Doesn't Apply : Spaces
		TEXT TO BLOB:C554("        "; $content; UTF8 text without length:K22:17; *)
	End if 
	
	// Individual's occupation
	$indOccupation:=FT_StringFormat(FT_Clean([ThirdParties:101]Occupation:20); 30)
	TEXT TO BLOB:C554($indOccupation; $content; UTF8 text without length:K22:17; *)
	
	// Individual's identifier
	$indType:=Substring:C12([ThirdParties:101]IdType:14; 1; 1)
	TEXT TO BLOB:C554($indType; $content; UTF8 text without length:K22:17; *)
	
	If ([ThirdParties:101]IdType:14="E")
		// Id type Other description for code  'E' in $idType.  FUTURE USE
		$indTypeOtherDesc:=FT_StringFormat(FT_Clean([ThirdParties:101]IdOtherType:15); 20)
		TEXT TO BLOB:C554($indTypeOtherDesc; $content; UTF8 text without length:K22:17; *)
	Else 
		$indTypeOtherDesc:=FT_StringFormat(" "; 20)
		TEXT TO BLOB:C554($indTypeOtherDesc; $content; UTF8 text without length:K22:17; *)
	End if 
	
	AppendBlobToFile($fileName; $content)
	
	
End if 



