//%attributes = {}
// getSLAExpiryDate -> date
// licensing and activation RAL
// this method can run on the server. 

C_DATE:C307($0)

READ ONLY:C145([CompanyInfo:7])
ALL RECORDS:C47([CompanyInfo:7])
FIRST RECORD:C50([CompanyInfo:7])
If (Records in selection:C76([CompanyInfo:7])=0)
	$0:=!00-00-00!
Else 
	$0:=[CompanyInfo:7]SLA_ExpiryDate:21
End if 
