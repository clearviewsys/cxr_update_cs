//%attributes = {}
// validateFIJIReportInfo
C_TEXT:C284($companyZipCode)


checkIfNullString(->reportingEntityID; "Finantial Institution Code")


checkIfNullString(->fiReportRef; "Finantial Instutution Report Reference")


checkIfNullString(->contactEntityName; "Entity Name")

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


