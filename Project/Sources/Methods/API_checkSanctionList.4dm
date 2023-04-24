//%attributes = {}


C_TEXT:C284($content; $partFileName; $partMimeType; $partName)
C_OBJECT:C1216($result; $o)


If (False:C215)  //(WEB Get body part count=1)  //for each part
	WEB GET BODY PART:C1212(1; $content; $partName; $partMimeType; $partFileName)
	WEB SEND TEXT:C677(JSON Stringify:C1217(CXR_checkSanctionList(JSON Parse:C1218($partName))))
Else 
	ARRAY TEXT:C222($aNames; 0)
	ARRAY TEXT:C222($aValues; 0)
	WEB GET VARIABLES:C683($aNames; $aValues)
	
	If (Size of array:C274($aNames)>0)
		$o:=JSON Parse:C1218($aNames{1})
		If (Type:C295($o)=Is object:K8:27) & ($o#Null:C1517)
			$result:=CXR_checkSanctionList($o)
			
			//$o:=JSON Parse($result)
			
			If ($result.status="200")  // <------ NEED TO CHECK FOR RESULTS NOT ERRORS HERE
				WEB SEND TEXT:C677(JSON Stringify:C1217($result))
			Else 
				API_sendError($result.status; $result)
			End if 
		Else 
			API_sendError("400"; New object:C1471("success"; False:C215; "status"; 400; "statusText"; "Bad Request: parameters format unknown."))
		End if 
		
	Else   //error
		API_sendError("400"; New object:C1471("success"; False:C215; "status"; 400; "statusText"; "Bad Request: parameters NOT found."))
	End if 
End if 






