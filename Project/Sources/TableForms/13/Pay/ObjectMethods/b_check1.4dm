

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		//CheckSanctionCheckListSetIcon (True;[eWires]BeneficiaryCompanyName;True;Table(->[eWires]);[eWires]eWireID;->latestListCheckBeneficiary5)
		//handleCustomerEntityCompliance(True;[eWires]BeneficiaryCompanyName;->[eWires]eWireID;->latestListCheckBeneficiary5)
		//sl_handleCompanyNameCompliance(False; [eWires]BeneficiaryCompanyName; ->[eWires]eWireID; New object(\
																					"pointers"; New object("resultIconPtr"; ->latestListCheckBeneficiary5)\
																					))
		sl_handleEWiresScreening(sl_eWireCompany+sl_ForSLButton)
End case 
