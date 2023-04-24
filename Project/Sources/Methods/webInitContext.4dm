//%attributes = {}

C_TEXT:C284($1; $URL)
C_TEXT:C284($0)

C_TEXT:C284(webContext; $currContext; $urlContext)
C_BOOLEAN:C305($isSessionAlive)

$URL:=$1

If (WAPI_isLicensed)
	
	$isSessionAlive:=WAPI_isSessionAlive
	If ($isSessionAlive)
		$currContext:=WAPI_getSession("context")
	Else 
		WAPI_createSession(WEB Get current session ID:C1162)
		$currContext:=""
	End if 
	
	$urlContext:=webGetContextFromURL($URL)
	
	
	
	If (True:C214)
		Case of 
			: ($URL="app/@") | ($URL="custom/@") | ($URL="login/@")
				$currContext:="app"
				
			: ($URL="js/@") | ($URL="css/@") | ($URL="wapi/@") | ($URL="img/@")  //in webdecoy - not context needed
				$currContext:="app"
				
			: ($currContext="") & ($urlContext="")
				$currContext:=getKeyValue("web.configuration.context.default"; "customers")
				WAPI_setSession("context"; $currContext)
				
			: ($currContext="")
				$currContext:=$urlContext  //update to url
				WAPI_setSession("context"; $currContext)
				
			: ($urlContext="")
				$currContext:=$currContext  //keep the same
				
			Else   //both have a value so use the URL context - user typed something new
				$currContext:=$urlContext
				WAPI_setSession("context"; $currContext)
		End case 
		
		//Case of 
		//: ($currContext="app")  //all good 
		
		//: ($currContext="")
		//Else 
		//  //WAPI_createSession 
		//WAPI_setSession ("context";$currContext)
		//End case 
		
		webContext:=$currContext
		
	Else 
		
		If ($currContext="")
			
			webContext:=""  //set a default context
			
			If (Position:C15("/"; $URL)=1)
				$URL:=Substring:C12($URL; 2; Length:C16($URL))  //strip leading /
			End if 
			
			C_LONGINT:C283($iPos)
			$iPos:=0
			
			Case of 
				: ($URL="")  //root/base
					webContext:="customers"
					
				: ($URL="js/@") | ($URL="css/@") | ($URL="wapi/@") | ($URL="img/@")  //in webdecoy
					
				: ($URL="customers/@")  //valid context
					$iPos:=Position:C15("/"; $URL)
					
				: ($URL="agents/@")  //valid context
					$iPos:=Position:C15("/"; $URL)
					
				: ($URL="login/@")  //unspecified in URL so default
					webContext:="customers"
			End case 
			
			
			Case of 
				: ($iPos=0) & ($URL="@.shtml")  //this is a page request
					//keep default context
				: ($iPos>0)
					webContext:=Substring:C12($URL; 1; $iPos-1)  //set context based on URL 
				Else 
					//keep default context
			End case 
			
			If (webContext="")
			Else 
				WAPI_createSession
				WAPI_setSession("context"; webContext)
			End if 
			
		End if 
		
	End if 
	
Else 
	webContext:=""
End if 

$0:=webContext