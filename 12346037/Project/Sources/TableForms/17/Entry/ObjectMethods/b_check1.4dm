Case of 
		
	: (Form event code:C388=On Clicked:K2:4)
		
		sl_handleLinksScreening(sl_LinksCompany+sl_ForSLButton)
		//handleCustomerEntityCompliance(True;[Links]CompanyName;->[Links]LinkID;->latestLinkIcon10)
		//sl_handleCompanyNameCompliance(True; [Links]CompanyName; ->[Links]LinkID; \
						New object("pointers"; New object("resultIconPtr"; ->latestLinkIcon10))\
						)
		//CheckSanctionCheckListSetIcon (True;[Links]CompanyName;True;Table(->[Links]);[Links]LinkID;->latestLinkIcon10)
End case 
