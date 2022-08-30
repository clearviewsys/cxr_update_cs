//%attributes = {}
C_TEXT:C284($sql)
ARRAY TEXT:C222(popDevelopers; 0)

Case of 
		
	: (Count parameters:C259=0)
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


If (SQL_LOGIN(serverIp))
	$sql:="SELECT DISTINCT Developer "
	$sql:=$sql+"FROM DB_CodeRevisions "
	$sql:=$sql+"ORDER BY `Developer` ASC INTO :popDevelopers"
	
	Begin SQL
		EXECUTE IMMEDIATE :$sql
	End SQL
	
	popDevelopers:=1
	
	
Else 
	myAlert("The 4D Connection was not possible")
End if 

