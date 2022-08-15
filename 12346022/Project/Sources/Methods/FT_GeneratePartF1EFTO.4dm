//%attributes = {}
// FT_GeneratePartF1EFTO

C_TEXT:C284($1; $fileName)

Case of 
	: (Count parameters:C259=1)
		$fileName:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_BLOB:C604($content)

C_TEXT:C284($tmp; $tmp1; $dob; $occupation; $accoutnNumber; $idType; $idDesc; $phone)
C_TEXT:C284($companyName; $surname; $surnameAndOthers; $streetAddress; $city; $country; $state; $zipCode)
C_TEXT:C284($name; $otherName)


// -----------------------------------------------------------------------------------------------------------
// Part F: Information about the beneficiary client(i.e., individual or entity to whose benefit the payment is made)
// This part is for information about the individual or entity to whose benefit the(or will be made)0
// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


// Part ID
$tmp:="F1"
TEXT TO BLOB:C554($tmp; $content; UTF8 text without length:K22:17; *)

Case of 
		
	: ([eWires:13]isBeneficiaryCompany:93)
		
		// Company Name
		$companyName:=FT_StringFormat(FT_Clean([eWires:13]BeneficiaryCompanyName:92); 45)
		TEXT TO BLOB:C554($companyName; $content; UTF8 text without length:K22:17; *)
		
		// surname
		$surnameAndOthers:=FT_StringFormat(" "; 45)
		TEXT TO BLOB:C554($surnameAndOthers; $content; UTF8 text without length:K22:17; *)
		
		
	: ([eWires:13]isBeneficiaryCompany:93=False:C215)
		
		$companyName:=FT_StringFormat(" "; 45)
		TEXT TO BLOB:C554($companyName; $content; UTF8 text without length:K22:17; *)
		
		// surname
		$surname:=FT_GetLastName(FT_Clean([eWires:13]BeneficiaryFullName:5))
		$surname:=FT_StringFormat($surname; 20)
		TEXT TO BLOB:C554($surname; $content; UTF8 text without length:K22:17; *)
		
		// Given Name
		$name:=FT_GetFirstName(FT_Clean([eWires:13]BeneficiaryFullName:5))
		$name:=FT_StringFormat($name; 15)
		TEXT TO BLOB:C554($name; $content; UTF8 text without length:K22:17; *)
		
		// Other Name
		$otherName:=FT_StringFormat(" "; 10)
		TEXT TO BLOB:C554($otherName; $content; UTF8 text without length:K22:17; *)
		
		
End case 



If (Position:C15("SELF"; [Links:17]Relationship:26)=0)  // WARNING: The Beneficiary is SELF, Information is comming from customers
	
	
	// -----------------------------------------------------------
	
	// Street address
	$streetAddress:=FT_StringFormat(FT_Clean([eWires:13]BeneficiaryAddress:59); 30)
	TEXT TO BLOB:C554($streetAddress; $content; UTF8 text without length:K22:17; *)
	
	// City
	$city:=FT_StringFormat(FT_Clean([eWires:13]BeneficiaryCity:60); 25)
	TEXT TO BLOB:C554($city; $content; UTF8 text without length:K22:17; *)
	
	// Country
	$country:=FT_StringFormat(FT_Clean([eWires:13]toCountryCode:112); 2)
	TEXT TO BLOB:C554($country; $content; UTF8 text without length:K22:17; *)
	
	
	// -----------------------------------------------------------
	
	QUERY:C277([Links:17]; [Links:17]LinkID:1=[eWires:13]LinkID:8)
	
	// Province/State
	$state:=FT_StringFormat(" "; 20)
	$state:=FT_StringFormat([Links:17]Province:60; 20)
	TEXT TO BLOB:C554($state; $content; UTF8 text without length:K22:17; *)
	
	// Postal/zip code
	$zipCode:=FT_StringFormat(" "; 9)
	$zipCode:=FT_StringFormat([Links:17]PostalCode:61; 9)
	TEXT TO BLOB:C554($zipCode; $content; UTF8 text without length:K22:17; *)
	
	
	// Beneficiary's business telephone number
	$phone:=FT_StringFormat(FT_Clean([eWires:13]BeneficiaryCellPhone:61); 20)
	TEXT TO BLOB:C554($phone; $content; UTF8 text without length:K22:17; *)
	
	If ([eWires:13]isBeneficiaryCompany:93)
		$dob:=FT_StringFormat(" "; 8)
	Else 
		
		// Beneficiary's date of birth
		If ([eWires:13]BeneficiaryDOB:110#!00-00-00!)
			$dob:=FT_GetStringDate([eWires:13]BeneficiaryDOB:110)
		Else 
			$dob:=FT_StringFormat(" "; 8)
		End if 
	End if 
	
	
	
	TEXT TO BLOB:C554($dob; $content; UTF8 text without length:K22:17; *)
	
	
	// Individual's (Beneficiary's) occupation
	If ([Links:17]isCompany:43)
		$occupation:=FT_StringFormat(" "; 30)
	Else 
		$occupation:=FT_StringFormat(FT_Clean([Links:17]occupation:46); 30)
	End if 
	
	TEXT TO BLOB:C554($occupation; $content; UTF8 text without length:K22:17; *)
	
	// Beneficiary's Account Number
	$accoutnNumber:=FT_StringFormat(FT_Clean([eWires:13]BeneficiaryBankAccountNo:66); 30)
	TEXT TO BLOB:C554($accoutnNumber; $content; UTF8 text without length:K22:17; *)
	
	
	
	// Individual's identifier
	C_TEXT:C284($indType; $indTypeOtherDesc)
	QUERY:C277([PictureIDTypes:92]; [PictureIDTypes:92]TemplateID:1=[Links:17]PictureIDType:34)
	$indType:=Substring:C12([PictureIDTypes:92]GovernmentCode:15; 1; 1)
	
	If ([Links:17]isCompany:43)
		$indType:=" "
	Else 
		$indType:=FT_StringFormat($indType; 1)
	End if 
	
	TEXT TO BLOB:C554($indType; $content; UTF8 text without length:K22:17; *)
	
	If ($indType="E")
		// Id type Other description for code  'E' in $idType.  FUTURE USE
		$indTypeOtherDesc:=FT_StringFormat([PictureIDTypes:92]Description:14; 20)
		TEXT TO BLOB:C554($indTypeOtherDesc; $content; UTF8 text without length:K22:17; *)
	Else 
		$indTypeOtherDesc:=FT_StringFormat(" "; 20)
		TEXT TO BLOB:C554($indTypeOtherDesc; $content; UTF8 text without length:K22:17; *)
		
	End if 
	
Else   // Beficiary is SELF: Informationn from Customers
	
	
	// -----------------------------------------------------------
	
	// Street address
	$streetAddress:=FT_StringFormat(FT_Clean([Customers:3]AddressUnitNo:148+"-"+[Customers:3]Address:7); 30)
	TEXT TO BLOB:C554($streetAddress; $content; UTF8 text without length:K22:17; *)
	
	// City
	$city:=FT_StringFormat(FT_Clean([Customers:3]City:8); 25)
	TEXT TO BLOB:C554($city; $content; UTF8 text without length:K22:17; *)
	
	// Country
	$country:=FT_StringFormat(FT_Clean([Customers:3]CountryCode:113); 2)
	TEXT TO BLOB:C554($country; $content; UTF8 text without length:K22:17; *)
	
	
	// -----------------------------------------------------------
	
	// Province/State
	$state:=FT_StringFormat(FT_Clean([Customers:3]Province:9); 20)
	TEXT TO BLOB:C554($state; $content; UTF8 text without length:K22:17; *)
	
	// Postal/zip code
	$zipCode:=FT_StringFormat([Customers:3]PostalCode:10; 9)
	TEXT TO BLOB:C554($zipCode; $content; UTF8 text without length:K22:17; *)
	
	
	// Beneficiary's business telephone number
	$phone:=FT_StringFormat(FT_Clean([Customers:3]HomeTel:6); 20)
	TEXT TO BLOB:C554($phone; $content; UTF8 text without length:K22:17; *)
	
	If ([Customers:3]isCompany:41)
		$dob:=FT_StringFormat(" "; 8)
	Else 
		
		// Beneficiary's date of birth
		If ([Customers:3]DOB:5#!00-00-00!)
			$dob:=FT_GetStringDate([Customers:3]DOB:5)
		Else 
			$dob:=FT_StringFormat(" "; 8)
		End if 
	End if 
	
	
	QUERY:C277([Links:17]; [Links:17]LinkID:1=[eWires:13]LinkID:8)
	
	TEXT TO BLOB:C554($dob; $content; UTF8 text without length:K22:17; *)
	
	
	// Individual's (Beneficiary's) occupation
	If ([Customers:3]isCompany:41)
		$occupation:=FT_StringFormat(" "; 30)
	Else 
		$occupation:=FT_StringFormat(FT_Clean([Customers:3]Occupation:21); 30)
	End if 
	
	TEXT TO BLOB:C554($occupation; $content; UTF8 text without length:K22:17; *)
	
	// Beneficiary's Account Number
	$accoutnNumber:=FT_StringFormat(FT_Clean([eWires:13]BeneficiaryBankAccountNo:66); 30)
	TEXT TO BLOB:C554($accoutnNumber; $content; UTF8 text without length:K22:17; *)
	
	
	
	// Individual's identifier
	C_TEXT:C284($indType; $indTypeOtherDesc)
	QUERY:C277([PictureIDTypes:92]; [PictureIDTypes:92]TemplateID:1=[Customers:3]PictureID_TemplateID:15)
	$indType:=Substring:C12([PictureIDTypes:92]GovernmentCode:15; 1; 1)
	
	If ([Customers:3]isCompany:41)
		$indType:=" "
	Else 
		$indType:=FT_StringFormat($indType; 1)
	End if 
	
	TEXT TO BLOB:C554($indType; $content; UTF8 text without length:K22:17; *)
	
	If ($indType="E")
		// Id type Other description for code  'E' in $idType.  FUTURE USE
		$indTypeOtherDesc:=FT_StringFormat([PictureIDTypes:92]Description:14; 20)
		TEXT TO BLOB:C554($indTypeOtherDesc; $content; UTF8 text without length:K22:17; *)
	Else 
		$indTypeOtherDesc:=FT_StringFormat(" "; 20)
		TEXT TO BLOB:C554($indTypeOtherDesc; $content; UTF8 text without length:K22:17; *)
		
	End if 
	
End if 

AppendBlobToFile($fileName; $content)

