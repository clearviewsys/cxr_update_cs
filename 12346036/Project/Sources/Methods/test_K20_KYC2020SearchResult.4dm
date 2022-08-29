//%attributes = {}
// test_KYC2020SearchResult
// Author: Wai-Kin Chau

C_POINTER:C301($null)
C_TEXT:C284($key; $email)
//DELETE SELECTION([KYC2020Log])

//$key:=getKeyValue ("KYC2020.APIkey")
//$email:=getKeyValue ("KYC2020.Email")

// Should returns an error: Invalid Key or email.
//setKeyValue ("KYC2020.APIkey";"")
//setKeyValue ("KYC2020.Email";"")
//K20_handleCustomerCompliance ("";$null;"Ahmend Ahmend")

//setKeyValue ("KYC2020.APIkey";$key)
//setKeyValue ("KYC2020.Email";$email)

// Should display result for Customer QSCUS1025969
//QUERY([Customers];[Customers]CustomerID="QSCUS1025969")
//K20_handleCustomerCompliance ("";->[Customers]CustomerID;makeFullName ([Customers]FirstName;[Customers]LastName))

//C_OBJECT($log)
ALL RECORDS:C47([KYC2020Log:159])
K20_displaySearchResults