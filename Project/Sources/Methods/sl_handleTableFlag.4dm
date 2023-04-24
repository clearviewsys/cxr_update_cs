//%attributes = {}
#DECLARE($screenTable : Integer; $update : Boolean; $current : Pointer)
Case of 
	: (Count parameters:C259=1)
		$update:=False:C215
		$current:=OBJECT Get pointer:C1124(Object current:K67:2)
	: (Count parameters:C259=2)
		$current:=OBJECT Get pointer:C1124(Object current:K67:2)
	: (Count parameters:C259=3)
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ($update=False:C215)
	Case of 
		: (Form event code:C388=On Load:K2:1)
			$update:=True:C214
			
		: (Form event code:C388=On Clicked:K2:4)
			sl_setScreeningForTable($screenTable; ->[SanctionLists:113]automaticFlags:11; $current->)
			$update:=True:C214
			
	End case 
End if 

If ($update)
	If ([SanctionLists:113]automaticFlags:11=0)
		[SanctionLists:113]IsEnabled:4:=False:C215
	End if 
End if 