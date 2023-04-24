//%attributes = {}
// CAB_SingleQuery ($sqlQuery)

C_TEXT:C284($1; $sqlQuery)

ARRAY TEXT:C222($arrModuleId; 0)
ARRAY TEXT:C222($arrModuleDesc; 0)

Case of 
	: (Count parameters:C259=1)
		$sqlQuery:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


odbc_login(True:C214)  // Force Login

SQL EXECUTE:C820($sqlQuery; ArrCodes; ArrDesc)

If (OK=1)
	
	If (Not:C34(SQL End selection:C821))
		SQL LOAD RECORD:C822(SQL all records:K49:10)
		SQL CANCEL LOAD:C824
		odbc_logout(True:C214)
	End if 
	
End if 

