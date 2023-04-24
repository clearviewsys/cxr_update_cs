//%attributes = {}
//  Method ODBC_Logout  

C_BOOLEAN:C305($1; $forceNewLogin)


Case of 
	: (Count parameters:C259=0)
		$forceNewLogin:=True:C214
		
	: (Count parameters:C259=1)
		$forceNewLogin:=$1
	Else 
		ASSERT:C1129(False:C215; "Invalid number of parameters in function "+Current method name:C684)
End case 

// Reset the cursor
SQL CANCEL LOAD:C824

If ($forceNewLogin)
	SQL LOGOUT:C872
End if 

