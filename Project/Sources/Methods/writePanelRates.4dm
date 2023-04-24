//%attributes = {}
C_TIME:C306($vhDocRef)
C_BOOLEAN:C305($found; $0)
ARRAY TEXT:C222($currencyArray; 15)
C_LONGINT:C283($i; $size)
C_TEXT:C284($nl; $prefix; $documentName)

$i:=1
$found:=False:C215
$NL:=Char:C90(13)+Char:C90(10)
$documentName:=getSupportFilesPath+c_PanelRatesInputFilename
$vhDocRef:=Open document:C264($documentName; "")  // Open a TEXT document   

If (OK=1)  // If the document was opene
	C_TEXT:C284($delim; $currency)
	$delim:=";"
	$i:=1
	Repeat   // Loop until no more data 
		RECEIVE PACKET:C104($vhDocRef; $currency; $delim)
		$currencyArray{$i}:=$currency
		$i:=$i+1
	Until ((OK=0) | ($found=True:C214))
	$size:=$i-2
	CLOSE DOCUMENT:C267($vhDocRef)  // Close the document   
	
	C_TIME:C306(vhDocRef)
	vhDocRef:=Create document:C266(<>panelRatesOutputFolder+c_PanelRatesOutputFileName)  // Create new document called Note 
	If (OK=1)
		C_TEXT:C284($rates)
		C_REAL:C285(vSpotRate; vBuyRate; vSellRate)
		SEND PACKET:C103(vhDocRef; "051.msg"+$nl)  // Write one word in the document
		
		For ($i; 1; $size)
			getCurrencyRates($currencyArray{$i}; ->vSpotRate; ->vBuyRate; ->vSellRate)
			SEND PACKET:C103(vhDocRef; String:C10(vBuyRate)+$nl)  // Write one word in the document
			
		End for 
		
		For ($i; 1; $size)
			getCurrencyRates($currencyArray{$i}; ->vSpotRate; ->vBuyRate; ->vSellRate)
			SEND PACKET:C103(vhDocRef; String:C10(vSellRate)+$nl)  // Write one word in the document
		End for 
		
		For ($i; 1; $size)
			SEND PACKET:C103(vhDocRef; $currencyArray{$i}+$nl)  // Write one word in the document
		End for 
		
		
		CLOSE DOCUMENT:C267(vhDocRef)  // Close the document 
	End if 
	
Else 
	myAlert("Could not open document "+$documentName+".")
End if 