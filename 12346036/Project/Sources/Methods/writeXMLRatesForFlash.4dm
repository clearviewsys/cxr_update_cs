//%attributes = {}
C_TIME:C306(vhDocRef)

If (Test path name:C476(getXMLFolderPath)=Is a folder:K24:2)
	vhDocRef:=Create document:C266(getXMLFolderPath+c_rateswithcssFilename)  // Create new document  
Else 
	vhDocRef:=Create document:C266(c_rateswithcssFilename)  // Create new document  
End if 

If (OK=1)
	allCurrenciesForXML
	C_TEXT:C284($xml)
	$xml:=makeXMLforSelectedCurrencies
	SEND PACKET:C103(vhDocRef; $xml)  // Write one word in the document 
	CLOSE DOCUMENT:C267(vhDocRef)  // Close the document 
End if 

