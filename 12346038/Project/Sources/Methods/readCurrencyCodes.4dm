//%attributes = {}
// readCurrencyCode(->ticker;->country;->name;self (searchField))->boolean
// #review #old #fixed
// send self as the search Pointer

// finds a bank code or id and return other informations

// this information is fetched from a text file

C_POINTER:C301($1; $2; $3; $4)
C_TEXT:C284($temp1; $temp2)
C_TEXT:C284($param1; $param2; $param3)
C_TIME:C306($vhDocRef)

$param1:=$1->
$param2:=$2->
$param3:=$3->


Case of   // see which pointer the search must be performed on
		
		// then empty the other fields so that the searc can be done properly
		
	: ($4=$1)
		
		$2->:=""
		$3->:=""
	: ($4=$2)
		$1->:=""
		$3->:=""
	: ($4=$3)
		$1->:=""
		$2->:=""
End case 

C_TEXT:C284($currencyTicker; $Country; $currencyName; $newLine)

C_BOOLEAN:C305($found; $0)
$found:=False:C215

$vhDocRef:=Open document:C264(getSupportFilesPath+"currencies.txt"; "")  // Open a TEXT document   

If (OK=1)  // If the document was opened
	
	Repeat   // Loop until no more data 
		
		RECEIVE PACKET:C104($vhDocRef; $currencyTicker; ";")  // Read till you see a ; 
		RECEIVE PACKET:C104($vhDocRef; $country; ",")  // Do same as above for second field 
		RECEIVE PACKET:C104($vhDocRef; $currencyName; ".")  // Do same as above for second field 
		RECEIVE PACKET:C104($vhDocRef; $newLine; 1)  // Do same as above for second field 
		
		If (OK=1)  // If we are not beyond the end of the document
			
			If ((($currencyTicker=$1->) & ($currencyTicker#"")) | (($country=$2->) & ($country#"")) | (($currencyName=$3->) & ($currencyName#"")))
				$1->:=$currencyTicker
				$2->:=$country
				$3->:=$currencyName
				$found:=True:C214
			End if 
		End if 
	Until ((OK=0) | ($found=True:C214))
	CLOSE DOCUMENT:C267($vhDocRef)  // Close the document   
	
End if 

$0:=$found
If (Not:C34($found))
	$1->:=$param1
	$2->:=$param2
	$3->:=$param3
End if 