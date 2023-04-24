//%attributes = {}
// handleGenerateCABReports

C_TEXT:C284(ReportsCountryCode)
ARRAY TEXT:C222(arrFTRegisterID; 0)
CLEAR VARIABLE:C89(xmlFile)

checkInit
validateCABReportInfo


If (isValidationConfirmed)
	
	// Please set the Key/value "AML.Reporting.CountryCode" to your DB COUNTRYCODE
	// This is for testing only. ie. if we are using a NZ database for generating Fintrac Reports
	
	If (keyValue_getValue("AML.Reporting.CountryCode")="")
		keyValue_setValue("AML.Reporting.CountryCode"; <>COUNTRYCODE)
	End if 
	
	ReportsCountryCode:=keyValue_getValue("AML.Reporting.CountryCode")
	
	Case of 
			
		: (cboReportType=1)
			CAB_STR_report
			
			QUERY WITH ARRAY:C644([Registers:10]RegisterID:1; arrFTRegisterID)
			QUERY WITH ARRAY:C644([Invoices:5]InvoiceID:1; arrFTInvoiceNumber)
			
	End case 
	
	
End if 

