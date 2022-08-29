//%attributes = {}

//  // ------------------------------------------------------------------------------
//  // Method: FT_PartD1_FromCustomer : 
//  // Information about the individual conducting the transaction that is not a 
//  // deposit into a business account (if applicable)
//  // 
//  // Parameters: 
//  //   see above
//  //
//  // Return:
//  //   None
//  // ------------------------------------------------------------------------------
//  // Jaime Alvarez, 10/07/2021
//  // ------------------------------------------------------------------------------


//C_TEXT($1)  // Report file path (include file name)      


//C_TEXT($2)  // Part ID
//C_LONGINT($3)  // Part sequence number

//C_TEXT($4)  // Surname
//C_TEXT($5)  // Given name
//C_TEXT($6)  // Other name/initial
////C_TEXT($7)  // Entity client number

//C_TEXT($8)  // Street address
//C_TEXT($9)  // City
//C_TEXT($10)  // Country
//C_TEXT($11)  // Province/State
//C_TEXT($12)  // Postal/zip code

////C_TEXT($13)  // Country of residence
//C_TEXT($14)  // Home telephone number
//C_TEXT($15)  // Individual's identifier ex.: A: Driver's licence, B Birth certificate
//C_TEXT($16)  // Id type Other description for code  'E' in $idType
//C_TEXT($17)  // Id Number
//C_TEXT($18)  // Country of issue
//C_TEXT($19)  // Province/State of issue
//C_TEXT($20)  // Individual's date of birth
//C_TEXT($21)  // Individual's occupation
//C_TEXT($22)  // Individual's business telephone number
//C_TEXT($23)  // Individual's business telephone extension number

//C_BLOB($content)
//C_TEXT($partId;$partSeqNum;$surname;$givenName;$otherName;$clientNumber;$streetAddress;$city;$country;$state;$zipCode)
//C_TEXT($countryOfResidence;$indHomePhoneNumber;$indType;$indTypeOtherDesc;$indNum;$indIssueCountry;$indIssueState)
//C_TEXT($indDateOfBirth;$indOccupation;$indBussinesPhonev;$indBussinesPhone;$indBussinesPhoneExt;$otherPhoneNumber;$otherPhoneExtNumber)

//// Part ID
//$partId:=FT_StringFormat ($2;2)
//TEXT TO BLOB($partId;$content;UTF8 text without length;*)

//  // Part sequence number
//$partSeqNum:=FT_NumberFormat ($3;0;2;"0";"RJ")
//TEXT TO BLOB($partSeqNum;$content;UTF8 text without length;*)

//  // Surname
//$surname:=FT_StringFormat ($4;20)
//TEXT TO BLOB($surname;$content;UTF8 text without length;*)

//  // -----------------------------------------------------------

//  // Given name
//$givenName:=FT_StringFormat ($5;15)
//TEXT TO BLOB($givenName;$content;UTF8 text without length;*)

//  // Other name/initial
//$otherName:=FT_StringFormat ($6;10)
//TEXT TO BLOB($otherName;$content;UTF8 text without length;*)

//  
//  // -----------------------------------------------------------


//  // Street address
//$streetAddress:=FT_StringFormat ($8;30)
//TEXT TO BLOB($streetAddress;$content;UTF8 text without length;*)

//  // City
//$city:=FT_StringFormat ($9;25)
//TEXT TO BLOB($city;$content;UTF8 text without length;*)

//  // Country
//$country:=FT_StringFormat ($10;2)
//TEXT TO BLOB($country;$content;UTF8 text without length;*)


//  // -----------------------------------------------------------

//  // Province/State
//$state:=FT_StringFormat ($11;20)
//TEXT TO BLOB($state;$content;UTF8 text without length;*)

//  // Postal/zip code
//$zipCode:=FT_StringFormat ($12;9)
//TEXT TO BLOB($zipCode;$content;UTF8 text without length;*)
//  
//  // Home telephone number
//$indHomePhoneNumber:=FT_StringFormat ($14;20)
//TEXT TO BLOB($indHomePhoneNumber;$content;UTF8 text without length;*)

//  // Other telephone number
//$otherPhoneNumber:=FT_StringFormat ($14;20)
//TEXT TO BLOB($indHomePhoneNumber;$content;UTF8 text without length;*)

//  // Other telephone extension number
//$otherPhoneExtNumber:=FT_StringFormat ($14;9;" ";"RJ")
//TEXT TO BLOB($otherPhoneExtNumber;$content;UTF8 text without length;*)

//  // Individual's date of birth
//$indDateOfBirth:=FT_StringFormat ($20;8)
//TEXT TO BLOB($indDateOfBirth;$content;UTF8 text without length;*)


//  // Individual's identifier
//$indType:=FT_StringFormat ($15;1)
//TEXT TO BLOB($indType;$content;UTF8 text without length;*)

//  // Id type Other description for code  'E' in $idType
//$indTypeOtherDesc:=FT_StringFormat ($16;20)
//TEXT TO BLOB($indTypeOtherDesc;$content;UTF8 text without length;*)

//  // ID number
//$indNum:=FT_StringFormat ($17;20)
//TEXT TO BLOB($indNum;$content;UTF8 text without length;*)

//  // Country of residence
//C_TEXT($indCountryOfResidence)
//$indCountryOfResidence:=FT_StringFormat ($18;2)
//TEXT TO BLOB($indCountryOfResidence;$content;UTF8 text without length;*)

//  // Country of Citizenship
//C_TEXT($indCountryOfCitizenship)
//$indCountryOfCitizenship:=FT_StringFormat ($18;2)
//TEXT TO BLOB($indCountryOfCitizenship;$content;UTF8 text without length;*)


//  // Country of issue
//C_TEXT($indCountryOfissue)
//$indCountryOfissue:=FT_StringFormat ($18;2)
//TEXT TO BLOB($indCountryOfissue;$content;UTF8 text without length;*)


//  // Province/State of issue
//$indIssueState:=FT_StringFormat ($19;20)
//TEXT TO BLOB($indIssueState;$content;UTF8 text without length;*)

//  // Individual's occupation
//$indOccupation:=FT_StringFormat ($21;30)
//TEXT TO BLOB($indOccupation;$content;UTF8 text without length;*)

//  // Individual's Employer
//C_TEXT($indEmployer)
//$indEmployer:=FT_StringFormat ($21;35)
//TEXT TO BLOB($indEmployer;$content;UTF8 text without length;*)

//  // Individual's Employer Address
//C_TEXT($indEmployerAddress)
//$indEmployerAddress:=FT_StringFormat ($21;30)
//TEXT TO BLOB($indEmployerAddress;$content;UTF8 text without length;*)

//  // Individual's Employer Address City
//C_TEXT($indEmployerAddressCity)
//$indEmployerAddressCity:=FT_StringFormat ($21;25)
//TEXT TO BLOB($indEmployerAddressCity;$content;UTF8 text without length;*)

//  // Individual's Employer Address Country Code
//C_TEXT($indEmployerAddressCountry)
//$indEmployerAddressCountry:=FT_StringFormat ($21;2)
//TEXT TO BLOB($indEmployerAddressCity;$content;UTF8 text without length;*)

//  // Individual's Employer Address Province/State
//C_TEXT($indEmployerAddressState)
//$indEmployerAddressState:=FT_StringFormat ($19;20)
//TEXT TO BLOB($indEmployerAddressState;$content;UTF8 text without length;*)

//  // Individual's Employer  Address Postal/zip code
//C_TEXT($indEmployerAddressZip)
//$indEmployerAddressZip:=FT_StringFormat ($12;9)
//TEXT TO BLOB($indEmployerAddressZip;$content;UTF8 text without length;*)
//  

//  // Employer's telephone number

//If ($indBussinesPhone#"")
//$indBussinesPhone:=FT_StringFormat ($22;20)
//Else 
//$indBussinesPhone:=FT_StringFormat (" ";20)
//End if 

//TEXT TO BLOB($indBussinesPhone;$content;UTF8 text without length;*)


//  // Individual's business telephone extension number


//If ($indBussinesPhoneExt#"")
//$indBussinesPhoneExt:=FT_StringFormat ($23;10;"0";"RJ")
//Else 
//$indBussinesPhoneExt:=FT_StringFormat (" ";10;" ";"RJ")
//End if 


//TEXT TO BLOB($indBussinesPhoneExt;$content;UTF8 text without length;*)

//  // Relationship to individual

//C_TEXT($indRelationship)
//$indRelationship:=FT_StringFormat ($12;1)
//TEXT TO BLOB($indRelationship;$content;UTF8 text without length;*)

//If ($indRelationship#"J")
//$indRelationship:=FT_StringFormat ($12;20)
//Else 
//$indRelationship:=FT_StringFormat (" ";20)
//End if 

//TEXT TO BLOB($indRelationship;$content;UTF8 text without length;*)


//AppendBlobToFile ($1;$content)








