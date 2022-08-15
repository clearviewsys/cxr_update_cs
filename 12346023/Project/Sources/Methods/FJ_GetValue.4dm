//%attributes = {}
//Unit Test written @Zoya 07 March 2021
C_TEXT:C284($1; $strValue; $2; $fieldDesc; $0)

Case of 
	: (Count parameters:C259=1)
		$strValue:=$1
		$fieldDesc:=""
		
	: (Count parameters:C259=2)
		$strValue:=$1
		$fieldDesc:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


If ($strValue="")
	$0:=" *MISSING* "+$fieldDesc
Else 
	$0:=$strValue
End if 

