//%attributes = {}


// -------------------------------------------------------------------------------------------------------
// Method: FT_GeneratePartE1_EFTO_NS: 
// This part is for information about the reporting entity sending the payment instructions.
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 5/4/2019
// ------------------------------------------------------------------------------

C_TEXT:C284($1; $fileName; $2; $partID)

Case of 
	: (Count parameters:C259=1)
		$fileName:=$1
		$partID:="E1"
		
	: (Count parameters:C259=2)
		$fileName:=$1
		$partID:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


C_BLOB:C604($content)
C_TEXT:C284($tmp; $tmp1)
C_TEXT:C284($companyName; $surnameAndOthers; $streetAddress; $city; $country; $state; $zipCode)


// -----------------------------------------------------------------------------------------------------------
// Part E: Part E – Information about the receiver of the EFT (i.e., the individual or entity that receives 
// the payment instructions)
// This part is for information about the individual or entity to which you are sending the payment instructions.
// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


// Part ID
TEXT TO BLOB:C554($partID; $content; UTF8 text without length:K22:17; *)

READ ONLY:C145([Accounts:9])
READ ONLY:C145([WireTemplates:42])

// If Customers are registering the ordering party in Wires the key value "FT.UseOrderingPartyInWires"  must be true

//If (getKeyValue ("FT.UseOrderingPartyInWires";"true")="false")
Case of 
		
	: (($partID="E1") | (($partID="C1") & (getKeyValue("FT.UseOrderingPartyInWires"; "false")="false")))
		
		QUERY:C277([Accounts:9]; [Accounts:9]AccountID:1=[Wires:8]CXR_AccountID:11)
		QUERY:C277([WireTemplates:42]; [Wires:8]WireTemplateID:83=[Wires:8]WireTemplateID:83)
		
		//$companyName:=FT_StringFormat ([Agents]FullName;45)
		$companyName:=FT_StringFormat([WireTemplates:42]BankName:3; 45)
		TEXT TO BLOB:C554($companyName; $content; UTF8 text without length:K22:17; *)
		
		
		// surname
		$surnameAndOthers:=FT_StringFormat(" "; 45)
		TEXT TO BLOB:C554($surnameAndOthers; $content; UTF8 text without length:K22:17; *)
		
		// -----------------------------------------------------------
		
		// Street address
		$streetAddress:=FT_Clean([WireTemplates:42]BankAddress:10)
		$streetAddress:=FT_StringFormat($streetAddress; 30)
		TEXT TO BLOB:C554($streetAddress; $content; UTF8 text without length:K22:17; *)
		
		// City
		$city:=FT_Clean([WireTemplates:42]BankCity:11)
		$city:=FT_StringFormat($city; 25)
		TEXT TO BLOB:C554($city; $content; UTF8 text without length:K22:17; *)
		
		// Country
		$country:=FT_Clean([WireTemplates:42]BankCountryCode:35)
		$country:=FT_StringFormat($country; 2)
		TEXT TO BLOB:C554($country; $content; UTF8 text without length:K22:17; *)
		
		
		// -----------------------------------------------------------
		// Province/State
		
		$state:=FT_Clean([WireTemplates:42]BankState:22)
		$state:=FT_StringFormat($state; 20)
		TEXT TO BLOB:C554($state; $content; UTF8 text without length:K22:17; *)
		
		// Postal/zip code
		$zipCode:=FT_Clean([WireTemplates:42]BankZIPCode:23)
		$zipCode:=FT_StringFormat($zipCode; 9)
		TEXT TO BLOB:C554($zipCode; $content; UTF8 text without length:K22:17; *)
		
	Else 
		
		// Customer is using "FT.UseOrderingPartyInWires" en true
		// This means the originator part C1 is in the wires record
		
		If ([Wires:8]OriginatorIdentifier:35#"")  // is a Company
			
			$companyName:=FT_StringFormat([Wires:8]OriginatorIdentifier:35; 45)
			TEXT TO BLOB:C554($companyName; $content; UTF8 text without length:K22:17; *)
			
			// surname
			$surnameAndOthers:=FT_StringFormat(" "; 45)
			TEXT TO BLOB:C554($surnameAndOthers; $content; UTF8 text without length:K22:17; *)
			
		Else   // Is an Individual
			
			$companyName:=FT_StringFormat(" "; 45)
			TEXT TO BLOB:C554($companyName; $content; UTF8 text without length:K22:17; *)
			
			// surname
			$surnameAndOthers:=FT_StringFormat([Wires:8]OriginatorFullName:34; 45)
			TEXT TO BLOB:C554($surnameAndOthers; $content; UTF8 text without length:K22:17; *)
		End if 
		
		// -----------------------------------------------------------
		
		// Street address
		$streetAddress:=FT_Clean([Wires:8]OriginatorAddress:36)
		$streetAddress:=FT_StringFormat($streetAddress; 30)
		TEXT TO BLOB:C554($streetAddress; $content; UTF8 text without length:K22:17; *)
		
		// City
		$city:=FT_Clean([Wires:8]OriginatorCity:37)
		$city:=FT_StringFormat($city; 25)
		TEXT TO BLOB:C554($city; $content; UTF8 text without length:K22:17; *)
		
		// Country
		$country:=FT_Clean([Wires:8]OriginatorCountry:39)
		$country:=FT_StringFormat($country; 2)
		TEXT TO BLOB:C554($country; $content; UTF8 text without length:K22:17; *)
		
		
		// -----------------------------------------------------------
		// Province/State
		
		$state:=FT_Clean([Wires:8]OriginatorState:38)
		$state:=FT_StringFormat($state; 20)
		TEXT TO BLOB:C554($state; $content; UTF8 text without length:K22:17; *)
		
		// Postal/zip code
		$zipCode:=FT_Clean([Wires:8]OriginatorZIP:40)
		$zipCode:=FT_StringFormat($zipCode; 9)
		TEXT TO BLOB:C554($zipCode; $content; UTF8 text without length:K22:17; *)
		
End case 

AppendBlobToFile($fileName; $content)