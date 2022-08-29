
Case of 
	: (Form event code:C388=On Data Change:K2:15)
		
		Self:C308->:=removeEnclosingSpaces(toTitleCase(Self:C308))
		//clearPictureField (->latestListCheckBeneficiary8)
		//CheckSanctionCheckListSetIcon (False;Self->;True;Table(->[eWires]);[eWires]eWireID;->latestListCheckBeneficiary8)
		//handleCustomerEntityCompliance(False;Self->;->[eWires]eWireID;->latestListCheckBeneficiary8)
		//sl_handleCompanyNameCompliance(False; Self->; ->[eWires]eWireID; \
															New object("pointers"; New object("resultIconPtr"; ->latestListCheckBeneficiary8))\
															)
		sl_handleEWiresScreening(sl_eWireBank+sl_ForInputBox)
End case 
