//%attributes = {}
// checkCustomerPictureID
// this method shall be used before saving a customer record for validation of
// of the picture ID
// the new picture ID template has imbedded rules for each type of picture ID
// validateCustomers
C_LONGINT:C283($min; $max; $len)

READ ONLY:C145([PictureIDTypes:92])
SET QUERY DESTINATION:C396(Into current selection:K19:1)
If ([Customers:3]PictureID_TemplateID:15#"")
	QUERY:C277([PictureIDTypes:92]; [PictureIDTypes:92]TemplateID:1=[Customers:3]PictureID_TemplateID:15)
	Case of 
		: (Records in selection:C76([PictureIDTypes:92])=0)  // the picture ID template doesn't exist
			checkAddWarning("Picture ID Template is not found.")
			
		: (Records in selection:C76([PictureIDTypes:92])=1)  // found the exact template
			
			LOAD RECORD:C52([PictureIDTypes:92])
			$len:=Length:C16([Customers:3]PictureID_Number:69)
			$min:=[PictureIDTypes:92]MinLength:12
			$max:=[PictureIDTypes:92]MaxLength:21
			
			// check the length of the picture ID
			If ($min#$max)
				checkAddErrorIf(($len<$min); "Picture ID must be great than or equal to <X> characters"; String:C10($min))
				checkAddErrorIf(($len>$max); "Picture ID must be less than or equal to <X> characters"; String:C10($max))
			End if 
			// if the length should be exact
			If ($min=$max)
				checkAddErrorIf(($len#$min); "Picture ID must be exactly <X> characters"; String:C10($min))
			End if 
			// check mandatory fields
			checkAddErrorIf(([PictureIDTypes:92]isIssuingCountryMandatory:18 & ([Customers:3]PictureID_CountryCode:118="")); "Picture ID Country code must be filled!")
			checkAddErrorIf(([PictureIDTypes:92]isIssuingStateMandatory:17 & ([Customers:3]PictureID_IssueState:72="")); "Picture ID Issuing State/Province must be filled!")
			checkAddErrorIf(([PictureIDTypes:92]isIssuingAuthMand:19 & ([Customers:3]PictureID_Authority:116="")); "Picture ID Issuing authority must be filled!")
			checkAddErrorIf(([PictureIDTypes:92]isIssuingDateMandatory:20 & ([Customers:3]PictureID_IssueDate:16=!00-00-00!)); "Picture ID Issuing date must be filled!")
			checkAddErrorIf(([PictureIDTypes:92]isExpiryDateMandatory:16 & ([Customers:3]PictureID_ExpiryDate:71=!00-00-00!)); "Picture ID Expiry date must be filled!")
			
			UNLOAD RECORD:C212([PictureIDTypes:92])
		Else 
			
	End case 
	
Else   // if the templateID is not filled (is empty)
	checkAddWarningIf([Customers:3]PictureID_Number:69#""; "Picture ID Template is left blank.")
End if 

// if the issue date is after the expiry date (when the expiry date is not null)
checkAddErrorIf((([Customers:3]PictureID_IssueDate:16>[Customers:3]PictureID_ExpiryDate:71) & ([Customers:3]PictureID_ExpiryDate:71#!00-00-00!)); "Issue Date cannot be after the expiry date")
checkAddErrorIf(([Customers:3]PictureID_IssueDate:16>Current date:C33); "Issue date cannot be in the future!")
If ([Customers:3]PictureID_ExpiryDate:71#!00-00-00!)
	checkAddWarningIf(([Customers:3]PictureID_ExpiryDate:71<Current date:C33); "This Picture ID is expired!")
End if 