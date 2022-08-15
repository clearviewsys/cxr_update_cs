Case of 
	: (Form event code:C388=On Data Change:K2:15)
		
		Self:C308->:=removeEnclosingSpaces(toTitleCase(Self:C308))
		clearPictureField(->latestLinkIcon10)
		
		sl_handleLinksScreening(sl_LinksCompany+sl_ForInputBox)
		//If (stringHasMinimumLength ([Links]CompanyName;4))
		//CheckSanctionCheckListSetIcon (False;[Links]CompanyName;True;Table(->[Links]);[Links]LinkID;->latestLinkIcon10)
		//End if
		// handleCustomerEntityCompliance(False;[Links]CompanyName;->[Links]LinkID;->latestLinkIcon10)
		//sl_handleCompanyNameCompliance(False; [Links]CompanyName; ->[Links]LinkID; \
						New object("pointers"; New object("resultIconPtr"; ->latestLinkIcon10))\
						)
		
End case 

