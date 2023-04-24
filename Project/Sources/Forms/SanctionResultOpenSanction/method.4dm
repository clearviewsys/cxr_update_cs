Case of 
	: (Form event code:C388=On Load:K2:1)
		sl_handleOpenSanctionResult
End case 

OBJECT SET ENABLED:C1123(*; "b_load"; \
Form:C1466.details.total.value#Form:C1466.details.results.length)