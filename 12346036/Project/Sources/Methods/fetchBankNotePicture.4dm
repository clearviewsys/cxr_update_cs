//%attributes = {}
// fetchBankNotePicture( boolean:obverse/reverse) -> picture

// $1 : true = obverse ; false = reverse


C_BOOLEAN:C305($1)
C_PICTURE:C286($0)
C_TEXT:C284($pictureURL)
If ($1)
	$pictureURL:=[BankNotes:23]Prefix:6+String:C10([BankNotes:23]CatNo:3)+[BankNotes:23]Postfix:7+".JPG"
Else 
	$pictureURL:=[BankNotes:23]Prefix:6+String:C10([BankNotes:23]CatNo:3)+[BankNotes:23]Postfix:7+"R.JPG"
End if 

$0:=fetchPicturefromURL("banknotes.com"; $pictureURL)


