//%attributes = {}
// handleGenerateLCTRButton

C_TEXT:C284(ReportsCountryCode)
ARRAY TEXT:C222(arrFTRegisterID; 0)
CLEAR VARIABLE:C89(xmlFile)

checkInit
validateLCTRInfo


If (isValidationConfirmed)
	
	// Please set the Key/value "AML.Reporting.CountryCode" to your DB COUNTRYCODE
	// This is for testing only. ie. if we are using a NZ database for generating Fintrac Reports
	
	If (keyValue_getValue("AML.Reporting.CountryCode")="")
		keyValue_setValue("AML.Reporting.CountryCode"; <>COUNTRYCODE)
	End if 
	
	ReportsCountryCode:=keyValue_getValue("AML.Reporting.CountryCode")
	
	Case of 
		: (cboReportTypeFT=1)
			FT_LCTR_Report
			QUERY WITH ARRAY:C644([Registers:10]RegisterID:1; arrFTRegisterID)
			
		: (cboReportTypeFT=2)  // Ewires IN Transactions NS
			FT_EFTI_report
			
		: (cboReportTypeFT=3)  // Ewires OUT Transactions NS
			FT_EFTO_report
			
		: (cboReportTypeFT=4)  // Wires IN Transactions NS
			//FT_EFTO_report_NonSwift 
			FT_EFT_Report_NonSwift(False:C215)
			
		: (cboReportTypeFT=5)  // Wires OUT Transactions NS
			FT_EFT_Report_NonSwift(True:C214)
			
		: (cboReportTypeFT=6)
			FT_STR_report
	End case 
	
	
End if 

