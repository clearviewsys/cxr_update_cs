//%attributes = {}
// BooleanToString ( aBoolean ) -> string

// aBoolean : boolean

// returns a string "checked" or "" depeding on the value of aBoolean


C_BOOLEAN:C305($1)
C_TEXT:C284($0)
If ($1)
	$0:="CHECKED"
Else 
	$0:=""
End if 
