//%attributes = {}
C_OBJECT:C1216(<>objectPrototypes)
<>objectPrototypes:=New object:C1471

C_OBJECT:C1216($object)

//---- FROM PARTY ----
$object:=New object:C1471

OB SET NULL:C1233($object; Info_FirstName)
OB SET NULL:C1233($object; Info_LastName)
OB SET NULL:C1233($object; Info_FullName)
OB SET NULL:C1233($object; Info_Address)
OB SET NULL:C1233($object; Info_City)
OB SET NULL:C1233($object; Info_State)
OB SET NULL:C1233($object; Info_PostalCode)
OB SET NULL:C1233($object; Info_CountryCode)
OB SET NULL:C1233($object; Info_Email)
OB SET NULL:C1233($object; Info_CellPhone)
OB SET NULL:C1233($object; Info_DateOfBirth)
OB SET NULL:C1233($object; Info_GovernmentID)
OB SET NULL:C1233($object; Info_GovernmentIDType)

OB SET:C1220(<>objectPrototypes; Proto_FromParty; $object)


//---- TO PARTY ----
$object:=New object:C1471

OB SET NULL:C1233($object; Info_Salutation)  //"salutation")
OB SET NULL:C1233($object; Info_FirstName)
OB SET NULL:C1233($object; Info_LastName)
OB SET NULL:C1233($object; Info_FullName)
OB SET NULL:C1233($object; Info_Address)
OB SET NULL:C1233($object; Info_City)
OB SET NULL:C1233($object; Info_State)
OB SET NULL:C1233($object; Info_PostalCode)
OB SET NULL:C1233($object; Info_CountryCode)
OB SET NULL:C1233($object; Info_Email)
OB SET NULL:C1233($object; Info_CellPhone)
OB SET NULL:C1233($object; Info_DateOfBirth)
OB SET NULL:C1233($object; Info_GovernmentID)
OB SET NULL:C1233($object; Info_GovernmentIDType)
OB SET NULL:C1233($object; Info_isCompany)  //"isCompany")
OB SET NULL:C1233($object; Info_CompanyName)  //"companyName")
OB SET NULL:C1233($object; Info_Relationship)  //"relationship")

OB SET NULL:C1233($object; Info_Gender)  //"gender")

OB SET:C1220(<>objectPrototypes; Proto_ToParty; $object)


//---- THIRD PARTY ----
$object:=New object:C1471

OB SET NULL:C1233($object; Info_DoSendToThirdParty)  //"doSendThirdParty")
OB SET NULL:C1233($object; Info_Salutation)  //"salutation")
OB SET NULL:C1233($object; Info_FirstName)
OB SET NULL:C1233($object; Info_LastName)
OB SET NULL:C1233($object; Info_FullName)
OB SET NULL:C1233($object; Info_Address)
OB SET NULL:C1233($object; Info_City)
OB SET NULL:C1233($object; Info_State)
OB SET NULL:C1233($object; Info_PostalCode)
OB SET NULL:C1233($object; Info_CountryCode)
OB SET NULL:C1233($object; Info_CountryCodeOfResidence)  //"countryCodeResidence")
OB SET NULL:C1233($object; Info_Email)  //"email")
OB SET NULL:C1233($object; Info_Occupation)  //"occupation")
OB SET NULL:C1233($object; Info_HomePhone)  //"homePhone")
OB SET NULL:C1233($object; Info_CellPhone)  //"cellPhone")
OB SET NULL:C1233($object; Info_WorkPhone)  //"workPhone")
OB SET NULL:C1233($object; Info_DateOfBirth)  //"dob")
OB SET NULL:C1233($object; Info_GovernmentID)  //"governmentId")
OB SET NULL:C1233($object; Info_GovernmentIDType)  //"governmentIdType")
OB SET NULL:C1233($object; Info_GovernmentIDCountryCode)  //"governmentIdCountryCode")
OB SET NULL:C1233($object; Info_isCompany)  //"isCompany")
OB SET NULL:C1233($object; Info_CompanyName)  //"companyName")
OB SET NULL:C1233($object; Info_CompanyType)  //"companyType")
OB SET NULL:C1233($object; Info_CompanyIncorporationNo)  //"incorporationNumber")
OB SET NULL:C1233($object; Info_Relationship)  //"relationship")

OB SET:C1220(<>objectPrototypes; Proto_ThirdParty; $object)



//---- BANK INFORMATION ----
$object:=New object:C1471

OB SET NULL:C1233($object; Bank_doTransferToBank)
OB SET NULL:C1233($object; Bank_Name)
OB SET NULL:C1233($object; Bank_AccountNo)
OB SET NULL:C1233($object; Bank_TransitCode)
OB SET NULL:C1233($object; Bank_Details)
OB SET NULL:C1233($object; Bank_InstitutionNo)
OB SET NULL:C1233($object; Bank_Swift)
OB SET NULL:C1233($object; Bank_RoutingCode)
OB SET NULL:C1233($object; Bank_Address)
OB SET NULL:C1233($object; Bank_City)
OB SET NULL:C1233($object; Bank_State)
OB SET NULL:C1233($object; Bank_PostalCode)
OB SET NULL:C1233($object; Bank_CountryCode)
OB SET NULL:C1233($object; Bank_Phone)
OB SET NULL:C1233($object; Bank_Fax)
OB SET NULL:C1233($object; Bank_AccountManager)

OB SET:C1220(<>objectPrototypes; Proto_BankInfo; $object)


//---- AML INFO ----
$object:=New object:C1471

OB SET NULL:C1233($object; AML_sourceOfFunds)
OB SET NULL:C1233($object; AML_purposeOfTransaction)
OB SET NULL:C1233($object; AML_Notes)
OB SET NULL:C1233($object; AML_toMOPCode)
OB SET NULL:C1233($object; "toMOP")
OB SET NULL:C1233($object; AML_fromMOPCode)
OB SET NULL:C1233($object; "fromMOP")

OB SET:C1220(<>objectPrototypes; Proto_AMLInfo; $object)


//--- PAYMENT INFO -----
$object:=New object:C1471
OB SET NULL:C1233($object; "bookingType")  // cxr trans type - ewire/wire/mg/

OB SET NULL:C1233($object; "gateway")  //poli or other
OB SET NULL:C1233($object; "status")

OB SET NULL:C1233($object; "deliveryMethod")
OB SET NULL:C1233($object; "deliveryMethod2")
OB SET NULL:C1233($object; "paymentMethod")
OB SET NULL:C1233($object; "paymentMethod2")
OB SET NULL:C1233($object; "amountPaid")

//OB SET NULL($object;"confirmationId")
OB SET NULL:C1233($object; "transactionId")
OB SET NULL:C1233($object; "transactionType")
OB SET NULL:C1233($object; "transactionDateTime")
OB SET NULL:C1233($object; "transactionRefNo")
//OB SET NULL($object;"BankReceiptNo")
//OB SET NULL($object;"BankReceiptDateTime")

//OB SET NULL($object;"CompletionTime")
//OB SET NULL($object;"MerchantReference")
//OB SET NULL($object;"CustomerReference")



OB SET:C1220(<>objectPrototypes; "paymentInfo"; $object)




//--- RESPONSE OBJECT ---
$object:=New object:C1471
OB SET NULL:C1233($object; "status")
OB SET NULL:C1233($object; "code")
OB SET NULL:C1233($object; "message")
OB SET NULL:C1233($object; "failedAttempts")
$object.failedAttempts:=0
$object.code:=0

OB SET:C1220(<>objectPrototypes; "response"; $object)


