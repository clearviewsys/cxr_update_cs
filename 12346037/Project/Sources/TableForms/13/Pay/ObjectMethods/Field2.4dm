

Case of 
	: (Form event code:C388=On Data Change:K2:15)
		
		Self:C308->:=removeEnclosingSpaces(toTitleCase(Self:C308))
		
		sl_handleEWiresScreening(sl_eWirePerson+sl_ForInputBox)
		//handleCheckeWireBeneficiary("full_edit")
		//clearPictureField (->latestListCheckBeneficiary4)
		//CheckSanctionCheckListSetIcon (False;Self->;False;Table(->[eWires]);[eWires]eWireID;->latestListCheckBeneficiary4)
		//sl_handlePersonNameCompliance(False; Self->; ->[eWires]eWireID; New object(\
												"pointers"; New object("resultIconPtr"; ->latestListCheckBeneficiary4)\
												))
		
		
End case 

