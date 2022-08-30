//%attributes = {}
C_TEXT:C284($password)
C_LONGINT:C283($i)
C_OBJECT:C1216($options)

$options:=New object:C1471("algorithm"; "bcrypt"; "cost"; "10")

ALL RECORDS:C47([Users:25])
READ WRITE:C146([Users:25])

For ($i; 1; Records in selection:C76([Users:25]))
	If ([Users:25]isHashed:36=False:C215)
		$password:=[Users:25]Password:4
		[Users:25]Password:4:=Generate password hash:C1533($password; $options)
		[Users:25]isHashed:36:=True:C214
		SAVE RECORD:C53([Users:25])
		NEXT RECORD:C51([Users:25])
	End if 
End for 
UNLOAD RECORD:C212([Users:25])
READ ONLY:C145([Users:25])