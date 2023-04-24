Case of 
		
	: (Form event code:C388=On Load:K2:1)
		FT_GetEntityAndContactInfo
		
		operationMode:=1
		//initialDate:=Current date(*)
		initialDate:=Date:C102(getKeyValue("fintrac.last.report.date"; String:C10(Current date:C33(*))))
		endDate:=initialDate
		
		QUERY:C277([Branches:70]; [Branches:70]BranchID:1=getBranchID)
		
		If (Records in selection:C76([Branches:70])>0)
			
			C_TEXT:C284($companyAddress; $companyCity; $companyState)
			$companyAddress:=setKeyValue("FT.CompanyInfo.Address"; [Branches:70]Address:3)
			$companyCity:=setKeyValue("FT.CompanyInfo.City"; [Branches:70]City:4)
			$companyState:=setKeyValue("FT.CompanyInfo.State"; [Branches:70]Province:10)
			$companyAddress:=setKeyValue("FT.CompanyInfo.ZipCode"; [Branches:70]PostalCode:11)
			
		End if 
		C_TEXT:C284($UseAMLRules; $reportNumType; reportNumber)
		$reportNumType:=getKeyValue("FT.ReportNumber"; "INVOICE")
		If ($reportNumType="INVOICE")
			reportNumber:=$reportNumType
		Else 
			reportNumber:="SEQUENCE"
		End if 
		
		$UseAMLRules:=getKeyValue("FT.UseAMLRules"; "1")
		If ($UseAMLRules="1")
			usingAMLRules:="Yes"
		Else 
			usingAMLRules:="No"
		End if 
		
End case 

