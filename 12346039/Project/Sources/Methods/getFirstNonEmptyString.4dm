//%attributes = {}
//makeMainPhone (phone1; phone2;phon3)
C_TEXT:C284($1; $2; $3; $0)

If ($1="")
	If ($2="")
		If ($3="")
			$0:=""
		Else 
			$0:=$3
		End if 
	Else 
		$0:=$2
	End if 
Else 
	$0:=$1
End if 
