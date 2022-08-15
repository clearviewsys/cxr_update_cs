//%attributes = {"shared":true}

Case of 
	: (Application type:C494=4D Server:K5:6)  //6/29/16 IBB ` added so we can run server as a service
		//launchUpdateProcess  7/30/19 now handled by SP_ManagerProcess
		
	: (Application type:C494#4D Remote mode:K5:5)
		handleProcess(->[CompanyInfo:7]; "display_UpdatePanel")
End case 