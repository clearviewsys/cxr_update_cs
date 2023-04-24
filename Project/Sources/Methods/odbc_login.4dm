//%attributes = {}
//  Method ODBC_Login  
//  Logs into the SQL database via ODBC

// $1 = Force New Login: true: Reuse connection, false: Create a new connection

C_TEXT:C284($connectionName; $userName; $password)
C_BOOLEAN:C305($1; $forceNewLogin)  // Indicates if execute SQL LOGIN Statement (sometimes is not necessary)


// CAB Server: 10.1.101.112:1521/CBS_UAT

$connectionName:="ODBC:"+getKeyValue("odbc.dsn.name"; "CAB")
$userName:=getKeyValue("odbc.username"; "CSVUSER")
$password:=getKeyValue("odbc.password"; "CABCSVUSER")

Case of 
		
	: (Count parameters:C259=0)
		
		$forceNewLogin:=True:C214
		
		
	: (Count parameters:C259=1)
		
		$forceNewLogin:=$1
		
	Else 
		ASSERT:C1129(False:C215; "Invalid number of parameters in function "+Current method name:C684)
End case 

If ($forceNewLogin)
	SQL LOGIN:C817($connectionName; $userName; $password)
	
	If (OK=0)
		DELAY PROCESS:C323(Current process:C322; 120)  // Wait some time
		SQL LOGIN:C817($connectionName; $userName; $password)  // Try a new login
		If (OK=0)
			ALERT:C41("The App. was unable to login into the database, please check if the ODBC Connection is working")
		End if 
	End if 
End if   // If ($forceNewLogin)

