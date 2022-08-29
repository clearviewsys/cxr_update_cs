

Case of 
	: (Form event code:C388=On Data Change:K2:15)
		
		Self:C308->:=removeEnclosingSpaces(toTitleCase(Self:C308))
		//clearPictureField (->latestListCheckBeneficiary5)
		//CheckSanctionCheckListSetIcon (False;Self->;False;Table(->[eWires]);[eWires]eWireID;->latestListCheckBeneficiary5)
		//handleCustomerEntityCompliance(False;Self->;->[eWires]eWireID;->latestListCheckBeneficiary5)
		//sl_handleCompanyNameCompliance(False; Self->; ->[eWires]eWireID; \
																		New object("pointers"; New object("resultIconPtr"; ->latestListCheckBeneficiary5))\
																		)
		sl_handleEWiresScreening(sl_eWireCompany+sl_ForInputBox)
		
End case 





