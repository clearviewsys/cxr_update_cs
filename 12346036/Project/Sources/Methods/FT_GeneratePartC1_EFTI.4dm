//%attributes = {}


// -------------------------------------------------------------------------------------------------------
// Method: FT_GeneratePartC1_EFTI: 
// This part is for information about the reporting entity sending the payment instructions.
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 5/4/2019
// ------------------------------------------------------------------------------

C_TEXT:C284($1; $fileName)

Case of 
	: (Count parameters:C259=1)
		$fileName:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_BLOB:C604($content)
C_LONGINT:C283($p)
C_TEXT:C284($tmp; $tmp1; $surname; $name)
C_TEXT:C284($companyName; $surnameAndOthers; $streetAddress; $city; $country; $state; $zipCode)
// -----------------------------------------------------------------------------------------------------------
// Part E: Part E – Information about the receiver of the EFT (i.e., the individual or entity that receives 
// the payment instructions)
// This part is for information about the individual or entity to which you are sending the payment instructions.
// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


// Part ID
$tmp1:="C1"
TEXT TO BLOB:C554($tmp1; $content; UTF8 text without length:K22:17; *)

If (getKeyValue("FT.reportingUseAgents"; "1")="1")
	
	QUERY:C277([Accounts:9]; [Accounts:9]AccountID:1=[eWires:13]AccountID:30)
	QUERY:C277([Agents:22]; [Agents:22]AgentID:1=[Accounts:9]AgentID:16)
	
	$p:=Position:C15("/"; [Agents:22]Notes:9)
	
	If ($p=0)  // No slashes (position:0) = is a Company
		
		$companyName:=FT_StringFormat([Agents:22]FullName:6; 45)
		TEXT TO BLOB:C554($companyName; $content; UTF8 text without length:K22:17; *)
		
		$surnameAndOthers:=FT_StringFormat(" "; 35)
		TEXT TO BLOB:C554($surnameAndOthers; $content; UTF8 text without length:K22:17; *)
		
	Else   //
		$companyName:=FT_StringFormat(" "; 45)
		TEXT TO BLOB:C554($companyName; $content; UTF8 text without length:K22:17; *)
		
		$surname:=FT_StringFormat(Substring:C12([Agents:22]Notes:9; 1; $p-1); 20)
		TEXT TO BLOB:C554($surname; $content; UTF8 text without length:K22:17; *)
		
		$name:=FT_StringFormat(Substring:C12([Agents:22]Notes:9; $p+1; Length:C16([Agents:22]Notes:9)); 15)
		TEXT TO BLOB:C554($name; $content; UTF8 text without length:K22:17; *)
		
	End if 
	
	// Other Name
	$surnameAndOthers:=FT_StringFormat(" "; 10)
	TEXT TO BLOB:C554($surnameAndOthers; $content; UTF8 text without length:K22:17; *)
	
	// -----------------------------------------------------------
	
	// Street address
	$streetAddress:=FT_Clean([Agents:22]Address:10)
	$streetAddress:=FT_StringFormat($streetAddress; 30)
	TEXT TO BLOB:C554($streetAddress; $content; UTF8 text without length:K22:17; *)
	
	// City
	$city:=FT_Clean([Agents:22]City:3)
	$city:=FT_StringFormat($city; 25)
	TEXT TO BLOB:C554($city; $content; UTF8 text without length:K22:17; *)
	
	// Country
	$country:=FT_Clean([Agents:22]CountryCode:21)
	$country:=FT_StringFormat($country; 2)
	TEXT TO BLOB:C554($country; $content; UTF8 text without length:K22:17; *)
	
	
	// -----------------------------------------------------------
	// Province/State
	
	$state:=FT_Clean([Agents:22]Province:4)
	$state:=FT_StringFormat($state; 20)
	TEXT TO BLOB:C554($state; $content; UTF8 text without length:K22:17; *)
	
	
	
	// Postal/zip code
	$zipCode:=FT_Clean([Agents:22]PostalCode:22)
	$zipCode:=FT_StringFormat($zipCode; 9)
	TEXT TO BLOB:C554($zipCode; $content; UTF8 text without length:K22:17; *)
	
Else 
	
	$companyName:=FT_StringFormat(reportingEntityName; 45)
	TEXT TO BLOB:C554($companyName; $content; UTF8 text without length:K22:17; *)
	
	
	// surname
	$surnameAndOthers:=FT_StringFormat(" "; 45)
	TEXT TO BLOB:C554($surnameAndOthers; $content; UTF8 text without length:K22:17; *)
	
	READ ONLY:C145([CompanyInfo:7])
	ALL RECORDS:C47([CompanyInfo:7])
	FIRST RECORD:C50([CompanyInfo:7])
	
	// -----------------------------------------------------------
	// Street address
	$streetAddress:=getKeyValue("FT.CompanyInfo.Address")
	$streetAddress:=FT_StringFormat($streetAddress; 30)
	TEXT TO BLOB:C554($streetAddress; $content; UTF8 text without length:K22:17; *)
	
	// City
	$city:=getKeyValue("FT.CompanyInfo.City")
	$city:=FT_StringFormat($city; 25)
	TEXT TO BLOB:C554($city; $content; UTF8 text without length:K22:17; *)
	
	// Country
	$country:=FT_StringFormat([eWires:13]fromCountryCode:111; 2)
	TEXT TO BLOB:C554($country; $content; UTF8 text without length:K22:17; *)
	
	// -----------------------------------------------------------
	// Province/State
	$state:=getKeyValue("FT.CompanyInfo.State")
	$state:=FT_StringFormat($state; 20)
	TEXT TO BLOB:C554($state; $content; UTF8 text without length:K22:17; *)
	
	// Postal/zip code
	$zipCode:=getKeyValue("FT.CompanyInfo.ZipCode")
	$zipCode:=FT_StringFormat($zipCode; 9)
	TEXT TO BLOB:C554($zipCode; $content; UTF8 text without length:K22:17; *)
End if 

AppendBlobToFile($fileName; $content)


