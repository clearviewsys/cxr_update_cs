//%attributes = {}
// checkIfBranchAddressesAreValid
// validate if all branches have an address

READ ONLY:C145([Branches:70])

QUERY:C277([Branches:70]; [Branches:70]Address:3=""; *)
QUERY:C277([Branches:70];  | ; [Branches:70]City:4=""; *)
QUERY:C277([Branches:70];  | ; [Branches:70]CountryCode:12=""; *)
QUERY:C277([Branches:70];  | ; [Branches:70]Province:10=""; *)
QUERY:C277([Branches:70];  | ; [Branches:70]PostalCode:11=""; *)
QUERY:C277([Branches:70];  | ; [Branches:70]LocationNumberFT:19="")


ARRAY TEXT:C222($arrBranchID; 0)
ARRAY TEXT:C222($arrName; 0)

ARRAY TEXT:C222($arrAddress; 0)
ARRAY TEXT:C222($arrCity; 0)
ARRAY TEXT:C222($arrProvince; 0)
ARRAY TEXT:C222($arrPostalCode; 0)
ARRAY TEXT:C222($arrLocationNumber; 0)

SELECTION TO ARRAY:C260([Branches:70]BranchID:1; $arrBranchID; [Branches:70]BranchName:2; $arrBranchName; [Branches:70]Address:3; $arrAddress; [Branches:70]City:4; $arrCity; [Branches:70]Province:10; $arrProvince; [Branches:70]PostalCode:11; $arrPostalCode; [Branches:70]LocationNumberFT:19; $arrLocationNumber)

C_LONGINT:C283($i)
C_TEXT:C284($msg)


$msg:=""

For ($i; 1; Size of array:C274($arrBranchID))
	
	$msg:="Branch "+$arrBranchID{$i}+" Address"
	checkAddError($msg+" is not complete.")
	
End for 


If (Records in selection:C76([Branches:70])>0)
	$0:=False:C215
Else 
	$0:=True:C214
End if 
REDUCE SELECTION:C351([Branches:70]; 0)




