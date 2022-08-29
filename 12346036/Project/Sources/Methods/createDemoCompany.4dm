//%attributes = {}
READ ONLY:C145([CompanyInfo:7])
ALL RECORDS:C47([CompanyInfo:7])
If (Records in selection:C76([CompanyInfo:7])=0)
	READ WRITE:C146([CompanyInfo:7])
	CREATE RECORD:C68([CompanyInfo:7])
	[CompanyInfo:7]CompanyName:1:="Clear View Systems Ltd.-Demo"
	[CompanyInfo:7]Country:10:=""
	[CompanyInfo:7]CountryCode:28:=""
	[CompanyInfo:7]Currency:11:=""
	[CompanyInfo:7]ClientCode:15:=""
	[CompanyInfo:7]ClientKey:16:=""
	[CompanyInfo:7]ClientCode2:25:=""
	[CompanyInfo:7]ClientKey2:26:=""
	[CompanyInfo:7]City:9:=""
	[CompanyInfo:7]Email:6:=""
	[CompanyInfo:7]RootFolderPath:13:=Get 4D folder:C485(Database folder:K5:14)
	[CompanyInfo:7]xmlFolderPath:14:=""
	[CompanyInfo:7]SLA_LastRenewalDate:22:=Current date:C33
	[CompanyInfo:7]SLA_ExpiryDate:21:=Add to date:C393(Current date:C33; 0; 1; 0)  // add one month
	
	//GET PICTURE FROM LIBRARY("_CompanyLogo";[CompanyInfo]Logo)
	assignCompanyInfoVars  // set global variables
	SAVE RECORD:C53([CompanyInfo:7])
	openFormWindow(->[CompanyInfo:7]; "CompanyInfo")
	MODIFY RECORD:C57([CompanyInfo:7]; *)
	UNLOAD RECORD:C212([CompanyInfo:7])
	READ ONLY:C145([CompanyInfo:7])
Else 
	READ ONLY:C145([CompanyInfo:7])
	FIRST RECORD:C50([CompanyInfo:7])
	LOAD RECORD:C52([CompanyInfo:7])
	assignCompanyInfoVars
	UNLOAD RECORD:C212([CompanyInfo:7])
End if 

