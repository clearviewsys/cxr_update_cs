//%attributes = {}
// SQL_LOGIN ($ipAddress;$user;$password)

C_TEXT:C284($1; $ipAddress; $2; $user; $3; $password)
C_BOOLEAN:C305($0)


$user:=user4D
$password:=password4D

Case of 
		
		
	: (Count parameters:C259=1)
		$ipAddress:=$1
		
		
	: (Count parameters:C259=2)
		$ipAddress:=$1
		$user:=$2
		
	: (Count parameters:C259=3)
		
		$ipAddress:=$1
		$user:=$2
		$password:=$3
		
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
		
End case 

SQL LOGIN:C817("IP:"+$ipAddress; $user; $password; *)
$0:=(OK=1)
