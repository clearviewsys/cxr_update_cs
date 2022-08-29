If (Form event code:C388=On Load:K2:1)
	Form:C1466.emps:=ds:C1482.Customers.all()
	Form:C1466.textToSearch:=""
End if 