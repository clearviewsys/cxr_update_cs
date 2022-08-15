//%attributes = {}
// getLocalizedString (string) -> translatedstring

C_TEXT:C284($string1; $string2; $0; $1)
$string1:=$1
$string2:=$1

ARRAY TEXT:C222($arrEN; 1)
ARRAY TEXT:C222($arrFR; 1)
ARRAY TEXT:C222($arrSP; 1)
ARRAY TEXT:C222($arrGR; 1)
//_____________________________________________________

APPEND TO ARRAY:C911($arrEN; "Paid to customer")
APPEND TO ARRAY:C911($arrFR; "Remis au client")

APPEND TO ARRAY:C911($arrEN; "Sold to customer")
APPEND TO ARRAY:C911($arrFR; "Vendu au client")

APPEND TO ARRAY:C911($arrEN; "Given to customer")
APPEND TO ARRAY:C911($arrFR; "Donné au client")

APPEND TO ARRAY:C911($arrEN; "Bought from customer")
APPEND TO ARRAY:C911($arrFR; "Acheté du client")

APPEND TO ARRAY:C911($arrEN; "Invoice No")
APPEND TO ARRAY:C911($arrFR; "Facture No")

APPEND TO ARRAY:C911($arrEN; "Local Currency")
APPEND TO ARRAY:C911($arrFR; "Devises locales")

APPEND TO ARRAY:C911($arrEN; "Received from customer")
APPEND TO ARRAY:C911($arrFR; "Reçu du client")

APPEND TO ARRAY:C911($arrEN; "Transferred to")
APPEND TO ARRAY:C911($arrFR; "Transferé au compte")

APPEND TO ARRAY:C911($arrEN; "Transferred from")
APPEND TO ARRAY:C911($arrFR; "Transferé du compte")

APPEND TO ARRAY:C911($arrEN; "Walk-in Customer")
APPEND TO ARRAY:C911($arrFR; "Client comptoir")

APPEND TO ARRAY:C911($arrEN; "Updated on")
APPEND TO ARRAY:C911($arrFR; "Mis à jour le")

//_____________________________________________________
C_LONGINT:C283($index)
C_TEXT:C284($string2)
$index:=Find in array:C230($arrEN; $string1)
If ($index>0)
	Case of 
		: (getDefaultLanguage=1)  // french
			$string2:=$arrFR{$index}
			
		: (getDefaultLanguage=2)  // spanish
			//$string2:=$arrSP{$index}
		: (getDefaultLanguage=3)  // german
			//$string2:=$arrGR{$index}
		Else 
			$string2:=$string1
	End case 
Else 
	$string1:=$string2
End if 

$0:=$string2