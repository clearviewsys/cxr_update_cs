//%attributes = {}
// archivePictureID ( fileName:string )
// use this insIde the [customers]entry form to archive the picture


C_TEXT:C284($fileName; $newFilename; $1)
$fileName:=$1

checkInit
checkAddErrorIf($filename=""; "Invalid picture filename.")
checkAddErrorIf([Customers:3]FirstName:3=""; "First name is not entered.")
checkAddErrorIf([Customers:3]LastName:4=""; "Last name is not entered.")
checkAddErrorIf(getClientPictureIDDest=""; "Archive folder has not been defined in Client Preferences.")
checkAddErrorIf(getClientPictureIDSource=""; "Picture source folder has not been defined in Client Preferences.")

//checkAddErrorIf (Size of array($pullDownPtr->)=0;"No pictures were available in the source folder.")

If (isValidationConfirmed)
	//$fileName:=$pullDownPtr->{$pullDownPtr->}
	$newFilename:=makeFullName([Customers:3]FirstName:3; [Customers:3]LastName:4)+"_"+String:C10(Sequence number:C244([Customers:3]); "000000000")+"_"+$fileName
	CONFIRM:C162("This picture will be moved into archive folder and renamed to "+$newFileName; "Move and Rename"; "Leave it")
	If (OK=1)
		MOVE DOCUMENT:C540(getClientPictureIDSource+$fileName; getClientPictureIDDest+$newFileName)
		//ALERT($filename+" is moved into destionation folder")
	End if 
End if 
