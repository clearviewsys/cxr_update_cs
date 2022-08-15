//%attributes = {}
//Method: addUsedPassword
//Purpose: Checks if a password has been used before, adds to the list
//// of used passwords if not
//Parameters: $password = Password to check (string)
//Returns: True if password is valid and has been added to the list of
///.previous passwords, false otherwise 

// Unit test written by @Zoya

C_TEXT:C284($1; $password)
C_BOOLEAN:C305($0)
C_OBJECT:C1216($options)

Case of 
	: (Count parameters:C259=1)
		$password:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$0:=False:C215

If (checkUsedPassword($password))
	$0:=False:C215
Else 
	READ WRITE:C146([UserPasswords:145])
	CREATE RECORD:C68([UserPasswords:145])
	
	$options:=New object:C1471("algorithm"; "bcrypt"; "cost"; "10")
	
	[UserPasswords:145]Password:1:=Generate password hash:C1533($password; $options)
	
	
	SAVE RECORD:C53([UserPasswords:145])
	UNLOAD RECORD:C212([UserPasswords:145])
	$0:=True:C214
End if 