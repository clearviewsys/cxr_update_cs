//%attributes = {}
// checkIfValidDOB (dob;titleOfField)


C_DATE:C307($1; $DOB)
C_TEXT:C284($2; $FieldLabel)
C_LONGINT:C283($age)

$DOB:=$1
$FieldLabel:=$2

$age:=Year of:C25(Current date:C33)-Year of:C25($DOB)


If ($DOB#!00-00-00!)
	
	Case of 
			
		: ($age<=0)
			checkAddError($FieldLabel+" is not a valid date of birth")
		: (($age>0) & ($age<=12))
			checkAddError($FieldLabel+" is very young.")
		: (($age>12) & ($age<18))
			checkAddWarning($FieldLabel+" seems too young")
		: (($age>90) & ($age<130))
			checkAddWarning($FieldLabel+" seems too old.")
		: ($age>130)
			checkAddError($FieldLabel+" is too old")
	End case 
End if 
