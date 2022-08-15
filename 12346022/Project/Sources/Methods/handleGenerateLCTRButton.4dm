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
			
		: (cboReportTypeFT=2)
			FT_EFTI_report
			
		: (cboReportTypeFT=3)
			FT_EFTO_report
			
		: (cboReportTypeFT=4)
			FT_EFTO_report_NonSwift
			
		: (cboReportTypeFT=5)
			FT_STR_report
	End case 
	
	
End if 

