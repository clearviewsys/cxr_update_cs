//%attributes = {}
C_BOOLEAN:C305(<>isHMReportActive)
C_TEXT:C284(<>hmReportLicense)


If (<>isHMReportActive)
	
	setErrorTrap("Startup"; "HM Report Registration Failed. Make sure the Plugins and Components are installed")
	Case of 
		: (Application type:C494=4D Local mode:K5:1)
			//$iError:=hmRep_Register (<>hmReportLicense)  //OEM license
			
			
			//$iError:=hmRep_Register ("lEgAJjZ7ZAN1AAAAAJADXBXDAHIAJdAMQAOSAgGB9J")  //OEM license
			//$iError:=hmRep_Register ("0MMADJZ18AJSAAAAMhAQrBVaAGcAJuANAAAdADwAiq")  //Developer license
		: (Application type:C494=4D Volume desktop:K5:2)
			//$iError:=hmRep_Register ("98dfkdsf78l3")  //Runtime license
		Else 
			//$iError:=hmRep_Register (<>hmReportLicense)  //OEM license
			
			
			//$iError:=hmRep_Register ("lEgAJjZ7ZAN1AAAAAJADXBXDAHIAJdAMQAOSAgGB9J")  //OEM license
	End case 
	endErrorTrap
	
End if 