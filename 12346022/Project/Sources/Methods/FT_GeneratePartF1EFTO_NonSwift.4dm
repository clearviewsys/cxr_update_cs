//%attributes = {}
// FT_GeneratePartF1EFTO_NonSwift

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

// Get the Customer ID related to Wire Template
QUERY:C277([WireTemplates:42]; [WireTemplates:42]WireTemplateID:1=[Wires:8]WireTemplateID:83)
//QUERY([Customers];[Customers]CustomerID=[WireTemplates]CustomerID)


Case of 
		
	: ([WireTemplates:42]BeneficiaryIsCompany:39)
		
		// Company Name
		$companyName:=FT_StringFormat(FT_Clean([WireTemplates:42]BeneficiaryFullName:9); 45)
		TEXT TO BLOB:C554($companyName; $content; UTF8 text without length:K22:17; *)
		
		// surname
		$surnameAndOthers:=FT_StringFormat(" "; 45)
		TEXT TO BLOB:C554($surnameAndOthers; $content; UTF8 text without length:K22:17; *)
		
		
	: ([WireTemplates:42]BeneficiaryIsCompany:39=False:C215)
		
		$companyName:=FT_StringFormat(" "; 45)
		TEXT TO BLOB:C554($companyName; $content; UTF8 text without length:K22:17; *)
		
		// surname
		$surname:=FT_Clean([WireTemplates:42]BeneficiaryLastName:41)
		$surname:=FT_StringFormat($surname; 20)
		TEXT TO BLOB:C554($surname; $content; UTF8 text without length:K22:17; *)
		
		// Given Name
		$name:=FT_Clean([WireTemplates:42]BeneficiaryFirstName:40)
		$name:=FT_StringFormat($name; 15)
		TEXT TO BLOB:C554($name; $content; UTF8 text without length:K22:17; *)
		
		// Other Name
		$otherName:=FT_StringFormat(" "; 10)
		TEXT TO BLOB:C554($otherName; $content; UTF8 text without length:K22:17; *)
End case 


// -----------------------------------------------------------

// Street address

$streetAddress:=FT_StringFormat(FT_Clean([WireTemplates:42]BeneficiaryAddress:19); 30)

TEXT TO BLOB:C554($streetAddress; $content; UTF8 text without length:K22:17; *)

// City
$city:=FT_StringFormat(FT_Clean([WireTemplates:42]BeneficiaryCity:24); 25)
TEXT TO BLOB:C554($city; $content; UTF8 text without length:K22:17; *)

// Country
$country:=FT_StringFormat(FT_Clean([WireTemplates:42]BeneficiaryCountryCode:27); 2)
TEXT TO BLOB:C554($country; $content; UTF8 text without length:K22:17; *)


// -----------------------------------------------------------

// Province/State
$state:=FT_StringFormat([WireTemplates:42]BeneficiaryState:25; 20)
TEXT TO BLOB:C554($state; $content; UTF8 text without length:K22:17; *)

// Postal/zip code
$zipCode:=FT_StringFormat([WireTemplates:42]BeneficiaryZIPCode:26; 9)
TEXT TO BLOB:C554($zipCode; $content; UTF8 text without length:K22:17; *)


// Beneficiary's business telephone number
$phone:=FT_StringFormat(FT_Clean([WireTemplates:42]BeneficiaryPhone:30); 20)
TEXT TO BLOB:C554($phone; $content; UTF8 text without length:K22:17; *)

If ([WireTemplates:42]BeneficiaryIsCompany:39)
	$dob:=FT_StringFormat(" "; 8)
	// Individual's (Beneficiary's) occupation
	$occupation:=FT_StringFormat(" "; 30)
	
Else 
	
	$dob:=FT_StringFormat(" "; 8)
	// Individual's (Beneficiary's) occupation
	$occupation:=FT_StringFormat(" "; 30)
	
	//  // Beneficiary's date of birth
	//If ([eWires]BeneficiaryDOB#!00-00-00!)
	//$dob:=FT_GetStringDate ([eWires]BeneficiaryDOB)
	//Else 
	//$dob:=FT_StringFormat (" ";8)
	//End if 
	//  // Individual's (Beneficiary's) occupation
	//$occupation:=FT_StringFormat ([Customers]Occupation;30)
	
End if 

TEXT TO BLOB:C554($dob; $content; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554($occupation; $content; UTF8 text without length:K22:17; *)

// Beneficiary's Account Number
$accoutnNumber:=FT_StringFormat(FT_Clean([WireTemplates:42]AccountNo:6); 30)
TEXT TO BLOB:C554($accoutnNumber; $content; UTF8 text without length:K22:17; *)

// Individual's identifier
C_TEXT:C284($indType; $indTypeOtherDesc)
//QUERY([PictureIDTypes];[PictureIDTypes]TemplateID=[Customers]PictureID_TemplateID)
//$indType:=Substring([PictureIDTypes]GovernmentCode;1;1)
//$indType:=FT_StringFormat ($indType;1)


$indType:=FT_StringFormat(" "; 1)
$indTypeOtherDesc:=FT_StringFormat(" "; 20)

//If ([Customers]isCompany)
//$indType:=FT_StringFormat (" ";1)
//$indTypeOtherDesc:=FT_StringFormat (" ";20)
//Else 
//If ($indType="E")
//  // Id type Other description for code  'E' in $idType.  FUTURE USE
//$indTypeOtherDesc:=FT_StringFormat ([PictureIDTypes]Description;20)
//Else 
//$indTypeOtherDesc:=FT_StringFormat (" ";20)
//End if 


TEXT TO BLOB:C554($indType; $content; UTF8 text without length:K22:17; *)
TEXT TO BLOB:C554($indTypeOtherDesc; $content; UTF8 text without length:K22:17; *)

AppendBlobToFile($fileName; $content)
