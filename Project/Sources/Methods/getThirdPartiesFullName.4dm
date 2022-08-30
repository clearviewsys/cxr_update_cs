//%attributes = {}
C_TEXT:C284($0)
C_TEXT:C284($fullName)

If ([ThirdParties:101]IsCompany:2)
	$fullName:=[ThirdParties:101]CompanyName:23
Else 
	$fullName:=[ThirdParties:101]FirstName:4+" "+[ThirdParties:101]OtherName:5+" "+[ThirdParties:101]LastName:3
End if 

$0:=$fullName

