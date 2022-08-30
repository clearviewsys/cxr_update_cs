
If (Form event code:C388=On Double Clicked:K2:5)
	
	COPY NAMED SELECTION:C331([SanctionCheckLog:111]; "$sanctionCheckNS")  // save the selection of records
	USE SET:C118("$sanctionchecklog_LBSet")  // use the highlighted set to load the record for display
	COPY SET:C600("$sanctionchecklog_LBSet"; "$tempSet")
	
	openFormWindow(->[SanctionCheckLog:111]; "View")
	//DIALOG([SanctionCheckLog];"View")
	
	USE NAMED SELECTION:C332("$sanctionCheckNS")  // reload the original selection
	COPY SET:C600("$tempSet"; "$sanctionchecklog_LBSet")  // restore the highlighted set
	CLEAR SET:C117("$tempSet")  // cleanup
	CLEAR NAMED SELECTION:C333("$sanctionCheckNS")
	
End if 

