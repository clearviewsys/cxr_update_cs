//%attributes = {}
C_LONGINT:C283($0)
C_TEXT:C284($error)
C_POINTER:C301($1; $pError; $pArray)

$error:=""
$pError:=->$error
$pArray:=$1

If ((isUserAdministrator) | (isUserManager))
	CC_findBalancesDetail($pError; $pArray; \
		getKeyValue("currencyCloud.user"); \
		getKeyValue("currencyCloud.pass"))
Else 
	CC_findBalances($pError; $pArray; \
		getKeyValue("currencyCloud.user"); \
		getKeyValue("currencyCloud.pass"))
End if 

If ($error="")
	$0:=200
	$pArray->:=1
Else 
	$0:=400
	myAlert("Error retrieveing accounts, please check your Currency Cloud credentials")
End if 