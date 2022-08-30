If (Form event code:C388=On Load:K2:1)
	Form:C1466.customers:=ds:C1482.Customers.query("FullName = 'a@'").orderBy("FullName")
	
End if 

handleListboxColumnsSettings(Self:C308; ->[Customers:3]; "sample"; "listbox")
