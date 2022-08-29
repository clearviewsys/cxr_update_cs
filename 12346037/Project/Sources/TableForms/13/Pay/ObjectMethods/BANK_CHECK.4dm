Case of 
	: (Form event code:C388=On Clicked:K2:4)
		//CheckSanctionCheckListSetIcon (True;[eWires]BeneficiaryBankName;True;Table(->[eWires]);[eWires]eWireID;->latestListCheckBeneficiary8)
		//handleCustomerEntityCompliance(True;[eWires]BeneficiaryBankName;->[eWires]eWireID;->latestListCheckBeneficiary8)
		
		//sl_handleCompanyNameCompliance(True; [eWires]BeneficiaryBankName; ->[eWires]eWireID; \
															New object("pointers"; New object("resultIconPtr"; ->latestListCheckBeneficiary8))\
															)
		
		sl_handleEWiresScreening(sl_eWireBank+sl_ForSLButton)
End case 
