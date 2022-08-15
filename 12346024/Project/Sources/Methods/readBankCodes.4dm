//%attributes = {}
// readBankCodes(->bankId;->bankCode;->bankName;->vURL;self)->boolean
// finds a bank code or id and return other informations
// this information is fetched from a text file
// #OLD #review 

C_POINTER:C301($1; $2; $3; $4; $5)
C_BOOLEAN:C305($found; $0)
C_TEXT:C284($param1; $param2; $param3)
C_TEXT:C284($bankID; $bankCode; $bankName; $bankURL; $newLine)
C_TIME:C306($vhDocRef)

$param1:=$1->
$param2:=$2->
$param3:=$3->

Case of   // see which pointer the search must be performed on
		
		// then empty the other fields so that the searc can be done properly
		
	: ($5=$1)
		$2->:=""
		$3->:=""
	: ($5=$2)
		$1->:=""
		$3->:=""
	: ($5=$3)
		$1->:=""
		$2->:=""
End case 


$found:=False:C215

$vhDocRef:=Open document:C264(getSupportFilesPath+"banks.txt"; "")  // Open a TEXT document   

If (OK=1)  // If the document was opened
	
	Repeat   // Loop until no more data 
		
		RECEIVE PACKET:C104($vhDocRef; $bankID; ";")  // Read till you see a ; 
		RECEIVE PACKET:C104($vhDocRef; $bankCode; ";")  // Do same as above for second field 
		RECEIVE PACKET:C104($vhDocRef; $bankname; ";")  // Do same as above for second field 
		RECEIVE PACKET:C104($vhDocRef; $bankURL; ";")  // Do same as above for second field 
		RECEIVE PACKET:C104($vhDocRef; $newLine; 1)  // Do same as above for second field 
		
		If (OK=1)  // If we are not beyond the end of the document
			
			If ((($bankID=$1->) & ($bankID#"")) | (($bankCode=$2->) & ($bankCode#"")) | (($bankName=$3->) & ($bankName#"")))
				$1->:=$bankID
				$2->:=$bankCode
				$3->:=$bankName
				$4->:=$bankURL
				$found:=True:C214
			End if 
			
		End if 
		
	Until ((OK=0) | ($found=True:C214))
	
	CLOSE DOCUMENT:C267($vhDocRef)  // Close the document   
End if 

If (Not:C34($found))
	$1->:=$param1
	$2->:=$param2
	$3->:=$param3
End if 

$0:=$found