//$vhDocRef:=Create document("")  ` Save the document of your choice
//
//If (OK=1)  ` If a document has been created
//CLOSE DOCUMENT($vhDocRef)  ` We don't need to keep it open
//BLOB TO DOCUMENT(Document;$graph)  ` Write the document contents
//If (OK=0)
//  ` Handle error
//ALERT("nemidoonam chi begam")
//End if 
//End if 
//
C_PICTURE:C286(vPictObverse; vPictReverse)

If (FORM Get current page:C276=1)
	WRITE PICTURE FILE:C680([BankNotes:23]BankNotesID:1+".JPG"; vPictObverse; "JPEG")
Else 
	WRITE PICTURE FILE:C680([BankNotes:23]BankNotesID:1+"R.JPG"; vPictReverse; "JPEG")
End if 
