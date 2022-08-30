//%attributes = {}
C_TIME:C306(vhDocRef)
vhDocRef:=Create document:C266(<>XMLFolderPath+c_xmlFlashTickerFilename)  // Create new document called Note 
If (OK=1)
	allCurrenciesForXML
	C_TEXT:C284($xml)
	$xml:=makeXMLflashTicker
	SEND PACKET:C103(vhDocRef; $xml)  // Write one word in the document 
	CLOSE DOCUMENT:C267(vhDocRef)  // Close the document 
End if 

