COMPILER_WEB


CXR_initSettings  //must come before checkIfCorrectDatafile 
// Automatic Update Procedures. SERVER
openCorrectDataFile

//SYNC_Startup   //needs to come before startup on server -- in Startup method now
USER_Load_Groups

UTIL_generateSSLKeys
Startup

SP_start

If (<>isHMReportActive)
	//$iError:=hmRep_Register (<>hmReportLicense)  //OEM license 2015
End if 

//$iError:=hmRep_Register ("lEgAJjZ7ZAN1AAAAAJADXBXDAHIAJdAMQAOSAgGB9J")  //OEM license
//$iError:=hmRep_Register ("0MMADJZ18AJSAAAAMhAQrBVaAGcAJuANAAAdADwAiq")


//Ltg_Startup 