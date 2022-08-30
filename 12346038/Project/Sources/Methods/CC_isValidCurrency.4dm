//%attributes = {"shared":true}
//**************************************************************
//Method to check if a given pair of currency codes are valid 
//codes for the Currency Cloud Platform
//
//Required Parameters:
//@Error (Pointer): Pointer to text variable
//@Currency pair (String): concatenated currency codes or two 
//            parameters containing individual currency codes 
//@Auth (String): authKey
//
//Outputs:
//On Success: True
//On Failure: False
//**************************************************************

C_TEXT:C284($buyCurrency; $sellCurrency; $authKey; $status; $2; $3)
C_BOOLEAN:C305($0)
C_POINTER:C301($pError; $pArray; $1)

ARRAY TEXT:C222($curArray; 0)
$pArray:=->$curArray

ASSERT:C1129(Is nil pointer:C315($1)=False:C215)
$pError:=$1
Case of 
	: (Count parameters:C259=3)
		C_TEXT:C284($currencyPair)
		
		$currencyPair:=$2
		$authKey:=$3
		
		$buyCurrency:=Substring:C12($currencyPair; 1; 3)
		$sellCurrency:=Substring:C12($currencyPair; 4; 3)
		
	: (Count parameters:C259=4)
		
		$buyCurrency:=$2
		$sellCurrency:=$3
		$authKey:=$4
		
End case 

$status:=CC_getAvailableCurrencies($pError; $pArray; $authKey)

If ((Find in array:C230($curArray; String:C10($buyCurrency))#-1) & (Find in array:C230($curArray; String:C10($sellCurrency))#-1))
	$0:=True:C214
Else 
	$0:=False:C215
End if 
