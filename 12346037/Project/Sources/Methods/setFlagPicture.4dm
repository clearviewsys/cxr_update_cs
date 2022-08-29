//%attributes = {}
// setFlagPicture (->pictureField;$currencyCode)

C_POINTER:C301($1)
C_TEXT:C284($2)

//GET PICTURE FROM LIBRARY("flag_"+$2;$1->)
//QUERY([Flags];[Flags]CurrencyCode=$2)
//$1->:=[Flags]flag
READ ONLY:C145([Currencies:6])
CREATE SET:C116([Currencies:6]; "$curr")
QUERY:C277([Currencies:6]; [Currencies:6]CurrencyCode:1=$2)
$1->:=[Currencies:6]Flag:3
USE SET:C118("$curr")
CLEAR SET:C117("$curr")