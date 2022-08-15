//%attributes = {}
// createDummyCustomers
// this method creates some nonesense dummy records in the Customers table
// use this method inside a 'START TRANSACTION' and 'Cancel Transaction' and to test different customers
// feel free to add more customers
// POST: There will be new records added to the Customers table; 
// PRE: 
// @tiran
//@Zoya Feb 2021
// this methods creates 20 new customers( if they do not already exist). 
// all CustomerID starts with _ 

/*
_normal_
_INSIDER_
_WALKING_
_SELF_
_ACCT_
_NOKYC_
_ONHOLD_
_SUSPICIOUS_

*/
//isCustomerSelfOrWalkIn
C_OBJECT:C1216($obj)
C_LONGINT:C283($httpResponse; $httpStatus)
$obj:=New object:C1471

$obj.isWalkin:=True:C214
createCustomer("_WALKIN"; "Walkin2"; "Customer2"; "ACME Inc."; 4; $obj)
createCustomer("_WALKIN_"; "Walkin"; "Customer"; "ACME Inc."; 4)  // walkin customer

$obj:=New object:C1471

$obj.isWalkin:=True:C214
createCustomer("_NewWALKIN"; "New"; "Walkin"; "test new walk in"; 4; $obj)


$obj:=New object:C1471
$obj.isInsider:=True:C214
createCustomer("_self"; "Self John2"; ""; "ACME Inc."; 2; $obj)  // a self customer



C_TEXT:C284(URLPic4_t)
URLPic4_t:="https://www.alberta.ca/assets/publications/DL-Sam-Sample-AB-DL-Face-V8b-Sam-Sample.jpg"
//ARRAY TEXT(HeaderNames_at; 0)
//ARRAY TEXT(HeaderValues_at; 0)
C_PICTURE:C286(Pic4_i)
//C_OBJECT($response)
gError:=0
ON ERR CALL:C155("getJSONError")
$httpStatus:=HTTP Get:C1157(URLPic4_t; Pic4_i)
ON ERR CALL:C155("")

If ($httpStatus=200)
	$obj:=New object:C1471
	$obj.DOB:=!1971-11-20!
	$obj.HomeTel:=7781234567
	$obj.Address:="24 My Place Street"
	$obj.City:="Anywhere"
	$obj.Salutation:="Mr."
	$obj.Province:="AB"
	$obj.PostalCode:="T5J 2M6"
	$obj.Country_obs:="CA"
	$obj.Occupation:="Testing"
	$obj.WorkTel:=6041234567
	$obj.CellPhone:=8881234567
	$obj.PictureID_Image:=Pic4_i
	$obj.PictureID_TemplateID:="DL"
	$obj.PictureID_Number:="1234562"
	$obj.PictureID_ExpiryDate:=!2023-11-20!
	$obj.Email:="samsample.testcard@testtestcustomer.com"
	
	createCustomer("_SmplSam"; "Sam"; "Sample"; ""; 0; $obj)
	
	//$httpResponse:=HTTP Get(URLPic4_t; Pic4_i; HeaderNames_at; HeaderValues_at)
Else 
	//$errorCode->:="Error code: "+String(gError)
	//ALERT("Error code: "+String(gError))
End if 

C_TEXT:C284(URLPic5_t)
URLPic5_t:="https://i.pinimg.com/564x/c8/71/dd/c871dd2221f4169b66119fca7e98eaa1.jpg"
//ARRAY TEXT(HeaderNames_at; 0)
//ARRAY TEXT(HeaderValues_at; 0)
C_PICTURE:C286(Pic5_i)
ON ERR CALL:C155("getJSONError")
$httpResponse:=HTTP Get:C1157(URLPic5_t; Pic5_i)
ON ERR CALL:C155("")

If ($httpResponse=200)
	$obj:=New object:C1471
	$obj.DOB:=!1966-09-05!
	$obj.HomeTel:=7781234567
	$obj.Address:="123 Any Street"
	$obj.City:="Toronto"
	$obj.Salutation:="Mr."
	$obj.Province:="ON"
	$obj.PostalCode:="M0M 0M0"
	$obj.Country_obs:="CA"
	$obj.Occupation:="ID Testing"
	$obj.WorkTel:=6041234567
	$obj.CellPhone:=8881234567
	$obj.PictureID_Image:=Pic5_i
	$obj.PictureID_TemplateID:="DL"
	$obj.PictureID_Number:="D61014070660905"
	$obj.PictureID_ExpiryDate:=!2023-04-23!
	$obj.Email:="johndoe.testcard@testtestcustomer.com"
	
	createCustomer("_NORMAL_"; "Average John"; "Doe"; ""; 0; $obj)  // average John ; normal customer
	createCustomer("_INSIDER_"; "Insider John"; "Doe"; "ACME Inc."; 2; $obj)  // an insider of ACME
	
	createCustomer("_self_"; "Self John"; ""; "ACME Inc."; 2; $obj)  // a self customer
	createCustomer("_ACCT_"; "John"; "Doe"; "External ACME Inc."; 8; $obj)  // account
	createCustomer("_NOKYC_"; "John No KYC"; "Doe"; ""; 16; $obj)
	createCustomer("_INNOKYC_"; "Insider John"; "NO KYC Doe"; ""; 18; $obj)
	createCustomer("_RepeatedJohn"; "John"; "Doe"; "External ACME Inc."; 8; $obj)  // Existing, should not add
	createCustomer("_ExistFName"; "John"; "AnyLastName"; ""; 0; $obj)  // exsiting first name , new last name
End if 

createCustomer("_COMP_"; ""; ""; "ACME Inc."; 1)  // company
createCustomer("_COMP_"; ""; ""; "ACME Inc."; 1)  // Repeated, should not add

//Getting a picture ID using a URL
C_TEXT:C284(URLPic_t)
URLPic_t:="https://globalnews.ca/wp-content/uploads/2020/07/20271071_web1_20200123-bpd-service-card-combined-bcg.jpg?quality=85&strip=all&w=1200"
//ARRAY TEXT(HeaderNames_at; 0)
//ARRAY TEXT(HeaderValues_at; 0)
C_PICTURE:C286(Pic_i)
ON ERR CALL:C155("getJSONError")
$httpResponse:=HTTP Get:C1157(URLPic_t; Pic_i)
ON ERR CALL:C155("")

If ($httpResponse=200)
	// Creating some cusotmers with full details
	$obj:=New object:C1471
	$obj.DOB:=!1987-04-06!
	$obj.HomeTel:=7781234567
	$obj.Address:="910 Government Street"
	$obj.City:="Victoria"
	$obj.Salutation:="Ms."
	$obj.Province:="BC"
	$obj.PostalCode:="V8W 3Y8"
	$obj.Country_obs:="CA"
	$obj.Occupation:="Testing"
	$obj.WorkTel:=6041234567
	$obj.CellPhone:=8881234567
	$obj.PictureID_Image:=Pic_i
	$obj.PictureID_TemplateID:="DL"
	$obj.PictureID_Number:="1234562"
	$obj.PictureID_ExpiryDate:=!2017-11-30!
	$obj.Email:="sample.testcard@testtestcustomer.com"
	createCustomer("_SmplTestCard"; "Sample"; "Test Card"; ""; 0; $obj)
End if 


C_TEXT:C284(URLPic2_t)
URLPic2_t:="https://www.canada.ca/content/canadasite/en/immigration-refugees-citizenship/corporate/publications-manuals/operational-bulletins-manuals/identity-management/date/travel/_jcr_content/par/mwsadaptiveimage/image.img.jpg/1534516161467.jpg"
//ARRAY TEXT(HeaderNames_at; 0)
//ARRAY TEXT(HeaderValues_at; 0)
C_PICTURE:C286(Pic2_i)
ON ERR CALL:C155("getJSONError")
$httpResponse:=HTTP Get:C1157(URLPic2_t; Pic2_i)
ON ERR CALL:C155("")

If ($httpResponse=200)
	$obj:=New object:C1471
	$obj.DOB:=!1985-01-01!
	$obj.HomeTel:=7781234567
	$obj.Address:="910 Government Street"
	$obj.City:="Toronoto"
	$obj.Salutation:="Ms."
	$obj.Province:="Ontario"
	$obj.PostalCode:="V8W 3Y8"
	$obj.Country_obs:="CA"
	$obj.Occupation:="PassportTesting"
	$obj.WorkTel:=6041234567
	$obj.CellPhone:=8881234567
	$obj.PictureID_Image:=Pic2_i
	$obj.PictureID_TemplateID:="Passport"
	$obj.PictureID_Number:="ZE000509"
	$obj.PictureID_ExpiryDate:=!2023-01-14!
	$obj.Email:="testsara.samplemartin@testtestcustomer.com"
	createCustomer("_DummySMartin"; "Sara"; "Martin"; ""; 0; $obj)
End if 

$obj:=New object:C1471
//[Customers]AML_isWhitelisted
//[Customers]AML_WhitelistExpiryDate
$obj.AML_isWhitelisted:=True:C214
$obj.AML_WhitelistExpiryDate:=!00-00-00!  // no date specified
C_TEXT:C284(URLPic3_t)
URLPic3_t:="https://media.istockphoto.com/vectors/vector-illustration-of-open-passport-template-document-for-travel-vector-id1090425080?s=612x612"

//ARRAY TEXT(HeaderNames_at; 0)
//ARRAY TEXT(HeaderValues_at; 0)
C_PICTURE:C286(Pic3_i)

ON ERR CALL:C155("getJSONError")
$httpResponse:=HTTP Get:C1157(URLPic3_t; Pic3_i)
ON ERR CALL:C155("")

If ($httpResponse=200)
	$obj:=New object:C1471
	$obj.DOB:=!2000-01-01!
	$obj.HomeTel:=7781234567
	$obj.Address:="123 ABC Ave."
	$obj.City:="Toronoto"
	$obj.Salutation:="Mr."
	$obj.Province:="Ontario"
	$obj.PostalCode:="V8W 3Y8"
	$obj.Country_obs:="CA"
	$obj.Occupation:="Whitlisting"
	$obj.WorkTel:=6041234567
	$obj.CellPhone:=8881234567
	$obj.PictureID_Image:=Pic3_i
	$obj.PictureID_TemplateID:="Passport"
	$obj.PictureID_Number:="ZE000509"
	$obj.PictureID_ExpiryDate:=Current date:C33-1
	$obj.Email:="testWhiteliste@testWhite.com"
	createCustomer("_ZeroDateWhite"; "White Listed John"; "No Date Doe"; "N/A"; 0; $obj)
	
	
	
	//C_OBJECT($objjj)
	$obj:=New object:C1471
	//[Customers]AML_isWhitelisted
	//[Customers]AML_WhitelistExpiryDate
	$obj.AML_isWhitelisted:=True:C214
	$obj.DOB:=!2000-01-01!
	$obj.HomeTel:=7781234567
	$obj.Address:="123 ABC Ave."
	$obj.City:="Toronoto"
	$obj.Salutation:="Mr."
	$obj.Province:="Ontario"
	$obj.PostalCode:="V8W 3Y8"
	$obj.Country_obs:="CA"
	$obj.Occupation:="Whitlisting"
	$obj.WorkTel:=6041234567
	$obj.CellPhone:=8881234567
	$obj.PictureID_Image:=Pic3_i
	$obj.PictureID_TemplateID:="Passport"
	$obj.PictureID_Number:="ZE000509"
	$obj.PictureID_ExpiryDate:=Current date:C33+1
	$obj.Email:="testWhiteliste@testWhite.com"
	createCustomer("_NoDateWhite"; "White Listed Jack"; "No Date entered"; "N/A"; 0; $obj)
	
	
	//[Customers]isOnHold
	//C_OBJECT($obj)
	$obj:=New object:C1471
	//[Customers]isOnHold
	$obj.isOnHold:=True:C214
	$obj.DOB:=!2000-01-01!
	$obj.HomeTel:=7781234567
	$obj.Address:="123 ABC Ave."
	$obj.City:="Toronoto"
	$obj.Salutation:="Mr."
	$obj.Province:="Ontario"
	$obj.PostalCode:="V8W 3Y8"
	$obj.Country_obs:="CA"
	$obj.Occupation:="Whitlisting"
	$obj.WorkTel:=6041234567
	$obj.CellPhone:=8881234567
	$obj.PictureID_Image:=Pic3_i
	$obj.PictureID_TemplateID:="Passport"
	$obj.PictureID_Number:="ZE000509"
	$obj.PictureID_ExpiryDate:=Current date:C33
	$obj.Email:="testWhiteliste@testWhite.com"
	createCustomer("_ONHOLD_"; "Johnny"; "Doe On Hold"; ""; 0; $obj)
	
	
	
	//[Customers]AML_isSuspicious
	$obj:=New object:C1471
	$obj.AML_isSuspicious:=True:C214
	$obj.DOB:=!2000-01-01!
	$obj.HomeTel:=7781234567
	$obj.Address:="123 ABC Ave."
	$obj.City:="Toronoto"
	$obj.Salutation:="Mr."
	$obj.Province:="Ontario"
	$obj.PostalCode:="V8W 3Y8"
	$obj.Country_obs:="CA"
	$obj.Occupation:="Whitlisting"
	$obj.WorkTel:=6041234567
	$obj.CellPhone:=8881234567
	$obj.PictureID_Image:=Pic3_i
	$obj.PictureID_TemplateID:="Passport"
	$obj.PictureID_Number:="ZE000509"
	$obj.PictureID_ExpiryDate:=Current date:C33-1
	$obj.Email:="testWhiteliste@testWhite.com"
	createCustomer("_Suspicious_"; "Suspicious John"; "Doe"; ""; 0; $obj)
	
	
	
	//[Customers]AML_isSuspicious
	$obj:=New object:C1471
	$obj.AML_isSuspicious:=True:C214
	$obj.AML_RiskRating:=4
	$obj.DOB:=!2000-01-01!
	$obj.HomeTel:=7781234567
	$obj.Address:="123 ABC Ave."
	$obj.City:="Toronoto"
	$obj.Salutation:="Mr."
	$obj.Province:="Ontario"
	$obj.PostalCode:="V8W 3Y8"
	$obj.Country_obs:="CA"
	$obj.Occupation:="Whitlisting"
	$obj.WorkTel:=6041234567
	$obj.CellPhone:=8881234567
	$obj.PictureID_Image:=Pic3_i
	$obj.PictureID_TemplateID:="Passport"
	$obj.PictureID_Number:="ZE000509"
	$obj.PictureID_ExpiryDate:=Current date:C33
	$obj.Email:="testWhiteliste@testWhite.com"
	createCustomer("_HOSUSHR_"; "Suspicious John"; "On Hold Doe"; "N/A"; 0; $obj)  // on hold ; suspicious ; and high risk
	
	
	
	// create a whitelisted customer that is not expired
	// create the expiry date dynamically
	//C_OBJECT($obj2)
	$obj:=New object:C1471
	$obj.AML_isWhitelisted:=True:C214
	$obj.AML_WhitelistExpiryDate:=Current date:C33+1  // expires tomorrow
	$obj.DOB:=!2000-01-01!
	$obj.HomeTel:=7781234567
	$obj.Address:="123 ABC Ave."
	$obj.City:="Toronoto"
	$obj.Salutation:="Mr."
	$obj.Province:="Ontario"
	$obj.PostalCode:="V8W 3Y8"
	$obj.Country_obs:="CA"
	$obj.Occupation:="Whitlisting"
	$obj.WorkTel:=6041234567
	$obj.CellPhone:=8881234567
	$obj.PictureID_Image:=Pic3_i
	$obj.PictureID_TemplateID:="Passport"
	$obj.PictureID_Number:="ZE000509"
	$obj.PictureID_ExpiryDate:=Current date:C33-1
	$obj.Email:="testWhiteliste@testWhite.com"
	createCustomer("_WListNoEXP"; "White Listed John"; "Not Expired Doe"; ""; 0; $obj)
	
	
	
	//C_OBJECT($obj)
	$obj:=New object:C1471
	//[Customers]AML_isWhitelisted
	//[Customers]AML_WhitelistExpiryDate
	$obj.AML_isWhitelisted:=True:C214
	$obj.AML_WhitelistExpiryDate:=Current date:C33  // expires today
	$obj.DOB:=!2000-01-01!
	$obj.HomeTel:=7781234567
	$obj.Address:="123 ABC Ave."
	$obj.City:="Toronoto"
	$obj.Salutation:="Mr."
	$obj.Province:="Ontario"
	$obj.PostalCode:="V8W 3Y8"
	$obj.Country_obs:="CA"
	$obj.Occupation:="Whitlisting"
	$obj.WorkTel:=6041234567
	$obj.CellPhone:=8881234567
	$obj.PictureID_Image:=Pic3_i
	$obj.PictureID_TemplateID:="Passport"
	$obj.PictureID_Number:="ZE000509"
	$obj.PictureID_ExpiryDate:=Current date:C33-1
	$obj.Email:="testWhiteliste@testWhite.com"
	createCustomer("_WListEXPToday"; "White Listed John"; "Expired Doe"; "N/A"; 0; $obj)
	
	
	
	//[Customers]CustomerID
	// create a whitelisted customer that is expired
	//C_OBJECT($obj3)
	$obj:=New object:C1471
	//[Customers]AML_isWhitelisted
	//[Customers]AML_WhitelistExpiryDate
	$obj.AML_isWhitelisted:=True:C214
	$obj.AML_WhitelistExpiryDate:=Current date:C33-1  // expired yesterday
	$obj.DOB:=!2000-01-01!
	$obj.HomeTel:=7781234567
	$obj.Address:="123 ABC Ave."
	$obj.City:="Toronoto"
	$obj.Salutation:="Mr."
	$obj.Province:="Ontario"
	$obj.PostalCode:="V8W 3Y8"
	$obj.Country_obs:="CA"
	$obj.Occupation:="Whitlisting"
	$obj.WorkTel:=6041234567
	$obj.CellPhone:=8881234567
	$obj.PictureID_Image:=Pic3_i
	$obj.PictureID_TemplateID:="Passport"
	$obj.PictureID_Number:="ZE000509"
	$obj.PictureID_ExpiryDate:=Current date:C33-1
	$obj.Email:="testWhiteliste@testWhite.com"
	createCustomer("_WListEXP"; "White John"; "Expired Doe"; "N/A"; 0; $obj)
End if 

CLEAR VARIABLE:C89(Pic_i)
CLEAR VARIABLE:C89(Pic2_i)
CLEAR VARIABLE:C89(Pic3_i)
CLEAR VARIABLE:C89(Pic4_i)
CLEAR VARIABLE:C89(Pic5_i)



//C_OBJECT($obj4)
//$obj4:=New object
//$obj4.AML_isWhitelisted:=False
////$obj4.AML_WhitelistExpiryDate:=newDate(0; 0; 0)
//createCustomer("_Not-WHITE-LISTED_"; "NOT WHITE-Listed John"; "Doe"; "N/A"; 0; $obj4)

//createCustomer()

//createSanctionListCustomers
//C_OBJECT($obj5)
//$obj5:=New object
//$obj5.AML_isWhitelisted:=False
//$obj5.AML_hasPositiveMatchOnSL:=True
//createCustomer("_ON-SANCTION_"; "Dellosa"; "Redendo Cain"; ""; 0; $obj5)


// 