C_TEXT:C284(<>applicationUser)
C_TEXT:C284(vSubjectLine; vHelpRequest; vHeaderLine)
C_LONGINT:C283(cbUrgent)

If (Form event code:C388=On Load:K2:1)
	cbUrgent:=0
	vHeaderLine:=getApplicationUser+" "+String:C10(Current date:C33)+" at "+String:C10(Current time:C178)+" "+<>TimeZone+". Phone:  "+<>companyTel1+" "+<>companyEmail+". version: "+getCurrentVersion
End if 

If (cbUrgent=1)
	vSubjectLine:="URGENT help request by "+<>companyName+" in "+<>companyCity+" "+<>companyCountry
Else 
	vSubjectLine:="Support request by "+<>companyName+" in "+<>companyCity+" "+<>companyCountry
End if 