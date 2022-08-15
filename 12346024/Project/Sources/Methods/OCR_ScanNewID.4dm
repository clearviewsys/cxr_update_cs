//%attributes = {}
// OCR_ScanNewID (->$picturePtr)
// Scan an ID 
// Created by JA on Feb 5/17/2017

C_POINTER:C301($1; $picturePtr)
C_PICTURE:C286($tmpPicture)

Case of 
		
	: (Count parameters:C259=0)
		$picturePtr:=->$tmpPicture
		
	: (Count parameters:C259=1)
		$picturePtr:=$1
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

docPhoto:=$picturePtr->
openFormWindow(->[CompanyInfo:7]; "ScanNewID")
$picturePtr->:=docPhoto

