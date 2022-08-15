//%attributes = {"publishedWeb":true}
// Make FullName ( firstName ; lastName ) -> string

// creates a concatenated fullName

C_TEXT:C284($0; $1; $2)
C_BOOLEAN:C305(<>orderFirstNameLastName)
If (<>orderFirstNameLastName=True:C214)
	$0:=($1+" "+$2)
Else 
	$0:=($2+" "+$1)
End if 