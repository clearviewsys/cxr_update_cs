//%attributes = {}
C_TIME:C306(vhDocRef)
C_TEXT:C284($headerxml; $xml)

If (isSLAValid)
	
	If (Test path name:C476(getXMLFolderPath)=Is a folder:K24:2)
		vhDocRef:=Create document:C266(getXMLFolderPath+c_rateswithcssFilename)  // Create new document  
	Else 
		vhDocRef:=Create document:C266(Get 4D folder:C485(Current resources folder:K5:16)+c_rateswithcssFilename)  // Create new document  
	End if 
	
	If (OK=1)
		READ ONLY:C145([Currencies:6])
		COPY NAMED SELECTION:C331([Currencies:6]; "$currencies")
		allCurrenciesForXML
		
		$headerxml:="<?xml version="+Quotify("1.0")+" encoding="+Quotify("ISO-8859-1")+"?>"+CRLF
		$headerxml:=$headerxml+"<?xml-stylesheet type="+Quotify("text/css")+" href="+Quotify("currency_table_widget.css")+"?>"+CRLF
		//<?xml version="1.0" encoding="ISO-8859-1"?>
		//<?xml-stylesheet type="text/css" href="currency_table_widget.css"?>
		
		$xml:=$headerxml+makeXMLforCSSRates
		SEND PACKET:C103(vhDocRef; $xml)  // Write one word in the document 
		CLOSE DOCUMENT:C267(vhDocRef)  // Close the document 
		USE NAMED SELECTION:C332("$currencies")
		CLEAR NAMED SELECTION:C333("$currencies")
	Else 
		CLOSE DOCUMENT:C267(vhDocRef)
	End if 
	
End if   // end if SLA Valid