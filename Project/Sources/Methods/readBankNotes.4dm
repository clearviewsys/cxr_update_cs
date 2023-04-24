//%attributes = {}
// readBankCodes(->bankId;->bankCode;->bankName;->vURL;self)->boolean

// finds a bank code or id and return other informations

// this information is fetched from a text file

C_TIME:C306($vhDocRef)
C_BOOLEAN:C305($found; $0)
C_TEXT:C284($country; $currency; $desc)
$found:=False:C215

$vhDocRef:=Open document:C264(""; "")  // Open a TEXT document   

If (OK=1)  // If the document was opened
	
	C_TEXT:C284($delim; $id; $temp; $newLine; $prefix; $postfix)
	$delim:=Char:C90(10)
	RECEIVE PACKET:C104($vhDocRef; $temp; $delim)  // read comment 
	
	
	RECEIVE PACKET:C104($vhDocRef; $country; ";")  // read country ; prefix ; posfix (eg : CA;CA;;) 
	
	RECEIVE PACKET:C104($vhDocRef; $currency; ";")  // read country ; prefix ; posfix (eg : CA;CA;;) 
	
	RECEIVE PACKET:C104($vhDocRef; $prefix; ";")
	RECEIVE PACKET:C104($vhDocRef; $postfix; ";")
	RECEIVE PACKET:C104($vhDocRef; $temp; $delim)  // consume one return
	
	
	CONFIRM:C162("Importing data for country:"+$country+"; prefix:"+$prefix+"; posfix:"+$postfix)
	If (ok=1)
		Repeat   // Loop until no more data 
			
			RECEIVE PACKET:C104($vhDocRef; $temp; $delim)  // Do same as above for second field 
			
			RECEIVE PACKET:C104($vhDocRef; $id; $delim)  // Read till you see a ; 
			
			
			RECEIVE PACKET:C104($vhDocRef; $temp; $delim)  // Do same as above for second field 
			
			RECEIVE PACKET:C104($vhDocRef; $desc; $delim)  // Do same as above for second field 
			
			
			RECEIVE PACKET:C104($vhDocRef; $temp; $delim)  // Do same as above for second field 
			
			RECEIVE PACKET:C104($vhDocRef; $temp; $delim)  // Do same as above for second field 
			
			//RECEIVE PACKET($vhDocRef;$newLine;1)  ` Do same as above for second field 
			
			If (OK=1)  // If we are not beyond the end of the document
				
				createBankNotes($country; $id; $desc; 0; $Prefix; $postfix; $currency)
			End if 
		Until ((OK=0) | ($found=True:C214))
	End if 
	CLOSE DOCUMENT:C267($vhDocRef)  // Close the document   
	
End if 
