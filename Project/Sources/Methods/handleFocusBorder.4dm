//%attributes = {}
// hanldeFocusBorder( objectName)

C_TEXT:C284($1)

Case of 
	: (Form event code:C388=On Getting Focus:K2:7)
		OBJECT SET VISIBLE:C603(*; $1; True:C214)
	: (Form event code:C388=On Losing Focus:K2:8)
		OBJECT SET VISIBLE:C603(*; $1; False:C215)
		
End case 