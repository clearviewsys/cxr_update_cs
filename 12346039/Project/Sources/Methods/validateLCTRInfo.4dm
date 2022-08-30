//%attributes = {}
C_TEXT:C284($companyAddress; $companyCity; $companyState; $companyZipCode)

$companyAddress:=getKeyValue("FT.CompanyInfo.Address")
checkIfNullString(->$companyAddress; "Company Address (In Key Values)")

$companyCity:=getKeyValue("FT.CompanyInfo.City")
checkIfNullString(->$companyCity; "Company City (In Key Values)")

$companyState:=getKeyValue("FT.CompanyInfo.State")
checkIfNullString(->$companyState; "Company Province/State  (In Key Values)")

$companyZipCode:=getKeyValue("FT.CompanyInfo.ZipCode")
checkIfNullString(->$companyZipCode; "Company Zip Code  (In Key Values)")

checkIfNullString(->reportingEntityName; "Report Entity Name")
checkIfNullString(->reportingEntityCertificateID; "Report Entity Certificate ID")
checkIfNullString(->reportingEntityPKI; "Report Entity PKI")

checkIfNullString(->reportingEntityLocationNumber; "Report Entity Location Number")
checkIfNullString(->contactSurname; "Contact Surname")
checkIfNullString(->contactGivenName; "Contact Given Name")
//checkIfNullString (->contactOtherName;"Contact Other (Middle) Name";"WARNING")
checkIfNullString(->contactPhoneNumber; "Contact Phone Number")
checkIfNullString(->contactPhoneNumberExt; "Contact Phone Number Extension")
checkIfDateIsFilled(->initialdate; True:C214; "Initial Date")

checkAddErrorIf(Not:C34(BranchAdressesAreOk); "One or more branches don't have the address complete (Address, City, Province, Zipcode, Location Number")


