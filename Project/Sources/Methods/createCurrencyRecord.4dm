//%attributes = {}
// createCurrencyRecord (currencyISOCode;baseCurrency;name;country;isautoUpdate;hasCashAccount;hasChequeAccount;->flag)
// PRE: This procedure must be called after the importFlags and after assignCompanyVars
// PRE : ◊baseCurrency must be defined
C_LONGINT:C283($error; $0)
C_TEXT:C284($currencyCode; $1; $baseCurrency; $2; $currencyName; $3; $countryName; $4)
C_BOOLEAN:C305($isAutoUpdate; $5; $hasCashAccount; $6; $hasChequeAccount; $7)
C_PICTURE:C286($flag)
C_POINTER:C301($8)

$currencyCode:=$1
$baseCurrency:=$2
$currencyName:=$3
$countryName:=$4
$isAutoUpdate:=$5
$hasCashAccount:=$6
$hasChequeAccount:=$7
$flag:=$8->

QUERY:C277([Currencies:6]; [Currencies:6]ISO4217:31=$currencyCode)
If (Records in selection:C76([Currencies:6])=0)
	READ WRITE:C146([Currencies:6])
	CREATE RECORD:C68([Currencies:6])
	[Currencies:6]Flag:3:=$flag
	[Currencies:6]CurrencyCode:1:=$currencyCode
	[Currencies:6]ISO4217:31:=$currencyCode
	[Currencies:6]toISO4217:32:=$baseCurrency
	[Currencies:6]Name:2:=$currencyName
	[Currencies:6]Country:22:=$countryName
	
	[Currencies:6]AutoUpdateOurRates:21:=$isAutoUpdate
	[Currencies:6]hasCashAccount:23:=$hasCashAccount
	[Currencies:6]hasChequeAccount:24:=$hasChequeAccount
	
	[Currencies:6]RoundDigit:27:=4
	[Currencies:6]RoundDigitInverse:28:=4
	
	SAVE RECORD:C53([Currencies:6])
	UNLOAD RECORD:C212([Currencies:6])
	READ ONLY:C145([Currencies:6])
	$error:=0
Else 
	$error:=1
End if 

$0:=$error