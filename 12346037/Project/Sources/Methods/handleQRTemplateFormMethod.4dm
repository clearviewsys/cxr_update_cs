//%attributes = {}
Case of 
	: (Form event code:C388=On Load:K2:1)
		SET AUTOMATIC RELATIONS:C310(True:C214; False:C215)
	: (Form event code:C388=On Close Box:K2:21)
		SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
		CANCEL:C270
		
	Else 
		
End case 