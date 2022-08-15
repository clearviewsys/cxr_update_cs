var $validStatus; $currValidity; $resultInt : Integer
var $email; $currEmail : Text
var $emailObj; $settingsObj : Object

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		If (RAL2_isLicenseValid("CXW.EmailVer"))
			$currEmail:=[Customers:3]Email:17
			If (($currEmail="") | (isValidEmailFormat($currEmail)=False:C215))
				myAlert("Email not formatted correctly, enter an email in a valid format")
			Else 
				$currValidity:=[Customers:3]isValidEmail:154
				
				// Validate email and return an int 0, 1, or 2
				$settingsObj:=openEmailCriteriaForm()
				If (OB Is defined:C1231($settingsObj; "validate"))
					If ($settingsObj.validate=True:C214)
						$resultInt:=checkSingleEmail($currEmail; $settingsObj.criteria)
					Else 
						$resultInt:=$currValidity
					End if 
				Else 
					$resultInt:=$currValidity
				End if 
				
				[Customers:3]isValidEmail:154:=$resultInt
				handleTristateCheckBox(->emailValidityCheckbox; ->[Customers:3]isValidEmail:154; "Unknown"; "Valid"; "InValid"; Black:K11:16; Green:K11:9; Red:K11:4; On Load:K2:1)
				
			End if 
		Else 
			alertInvalidEmailLicense()
		End if 
End case 





//$email:=[Customers]Email

//If (($email="") | (isValidEmailFormat($email)=False))
//myAlert("Email not formatted correctly, enter an email in a valid format")
//Else 

//$validStatus:=isEmailValid([Customers]Email)

//If ($validStatus=1)
//myAlert("The email is Valid")
//End if 

//If ($validStatus=2)
//myAlert("This email is not Valid, please enter a valid email address")
//[Customers]Email:=""
//End if 
//End if 