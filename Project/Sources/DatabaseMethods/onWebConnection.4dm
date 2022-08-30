C_TEXT:C284($1; $2; $3; $4; $5; $6)

C_LONGINT:C283($nError; $iFound)
C_BOOLEAN:C305($bAllow)
C_OBJECT:C1216($entity)
C_TEXT:C284($context; $token; $webErrorMessage; $username; $webewireid; $transStatus)
C_LONGINT:C283($iPos)


//If (webIsBot ($1;$3)=False)
If (WAPI_isIgnoredRequest($1; $3)=False:C215)
	//ON ERR CALL("WAPI_onError")
	ON ERR CALL:C155("onErrCallIgnore")
	
	webInitVars
	
	WebClientIP:=$3  //waht if proxy need to get from header
	WebServerIP:=$4
	
	If (WAPI_isLicensed=False:C215)
		ARRAY TEXT:C222(WEB_aNames; 0)
		ARRAY TEXT:C222(WEB_aValues; 0)
		WEB GET VARIABLES:C683(WEB_aNames; WEB_aValues)
		
		ARRAY TEXT:C222(WEB_aHeaderNames; 0)
		ARRAY TEXT:C222(WEB_aHeaderValues; 0)
		WEB GET HTTP HEADER:C697(WEB_aHeaderNames; WEB_aHeaderValues)
	End if 
	
	
	Case of 
		: ($1="@4DREMOTE@")
			WSS_listener($1)
			
		: ($1="@4DHOOK@")
			If (WAPI_isLicensed)
				WAPI_initConnection($1; $2; $3; $4; $5; $6)
			End if 
			webHookListener($1)
			
		: (Sync_isSyncRequest($1))
			Sync_httpListener($1; $2; $3; $4)
			
		: ($1="@confirm?@") | ($1="@confirm.jsp@")  //confirmation request
			confirmationSetStatusRemote
			
		Else   //WAPI related calls for web app
			
			If (WAPI_isLicensed)
				WAPI_initConnection($1; $2; $3; $4; $5; $6)
				$context:=webInitContext($1)  //get current webContext before checking session b/c if session dead this will be cleared
				
				Case of 
					: ($context="app")
						$bAllow:=True:C214
					: ($1="@login/@")
						$bAllow:=True:C214
					: ($1="@registration.shtml")
						$bAllow:=True:C214
					: ($1="@confirmemailtoken.shtml")
						$bAllow:=True:C214
					: ($1="@forgotpassword.shtml")
						$bAllow:=True:C214
					: (WAPI_getParameter("pq_table")=Table name:C256(->[Currencies:6]))
						$bAllow:=True:C214
					Else 
						$bAllow:=False:C215
				End case 
				
				//WAPI_isDebug (False)
				WAPI_isMinimized(True:C214)
				
				
				
				Case of 
					: ($1="")  //10/2/21
						webSendLoginPage
						
					: ($1="@4DREST@")
						WAPI_onWebConnection($1; $2; $3; $4; $5; $6)
						
					: ($1="@notify.asp@")
						webNotification
						WAPI_sendFile(WAPI_getPageSuccess)
						
					: ($1="@webRegister@")
						webRegister  //create webUser and the send confirm token page
						
					: ($1="@webConfirmToken@")
						webConfirmToken  //send registration success if confirmed
						
					: ($1="@webconfirmaccount@")  //if webUser and Customer have matching email but not linked send confirm page
						webConfirmAccount
						
					: ($1="@webCreateProfile@")  //DO WE NEED THIS???
						webCreateProfile
						
					: ($1="@webResetPassword@")
						webResetPassword
						
					: ($1="@webChangePassword@")
						webChangePassword
						
					: ($1="@webLoginAgent")
						webLoginAgent
						
					: ($1="@webLoginCustomer")
						webLoginCustomer
						
					: ($1="@webLogout")
						webLogout
						
						//: ($1="@executeMethod@") | ($1="@confirm.jsp@")
						//WAPI_executeMethod 
						
					: (WAPI_isValidPage($1; True:C214))  //this shouldn't happen but it is at LOTUS - 4D is ignoring the html root so if exists send it
						//$tPath:=Convert path system to POSIX(Get 4D folder(HTML Root folder;*))+$1
						//$tPath:=Convert path POSIX to system($tPath)
						//WEB SEND FILE($tPath)
						
					: ($bAllow)  //no session needed
						WAPI_onWebConnection($1; $2; $3; $4; $5; $6)
						//need to have way to let some connections in without a session.. ie. currency ticker
						
						//: (webIsSessionAlive =False)  //test for valid session here and authorized session
						//webSendLoginPage   // (WAPI_getPageRoot ($1))  //since no session then redirect for a login
						
					: (webIsSessionAlive)  //test for valid session here and authorized session
						$username:=WAPI_getSession("username")
						
						Case of 
							: (Position:C15("/sq-return"; $1)>0)
								UTIL_Log(Current method name:C684; $username+": "+$1)  //debug - remove later
								
								$webewireid:=Split string:C1554(WAPI_getParameter("Reference"); "-")[0]
								
								$entity:=ds:C1482.WebEWires.query("WebEwireID == :1"; $webewireid)
								
								If ($entity.length=1)
									// this is the redirect - we should check payment status now and then send
									$transStatus:=$entity.first().paymentInfo.status
									
									If ($transStatus="NEW") | ($transStatus="DRAFT")
										$transStatus:=webGetWebewirePayStatus($entity)
									End if 
									
									Case of 
										: ($transStatus="SUCCESSFUL")  //success
											$webErrorMessage:=getKeyValue("web.customers.webewires.confirmation.alert")
											If ($webErrorMessage="")
												$webErrorMessage:="You have successfully completed your eWire request.<br>We will review your transaction and send you an email<br>once payment has been processed."
											End if 
											WAPI_setParameter("alertMessage"; $webErrorMessage)
											WAPI_setParameter("alertType"; "1")
											
										: ($transStatus="UNKNOWN")
											WAPI_setParameter("alertMessage"; "Payment transaction has an UNKNOWN response.")
											WAPI_setParameter("alertType"; "3")
											
										Else   // DECLINED/BLOCKED/FAILED/INPROGRESS/CANCELLED
											If ($transStatus="")
												$transStatus:="NOT FOUND"
											End if 
											
											WAPI_setParameter("alertMessage"; "Payment Status "+$transStatus)
											WAPI_setParameter("alertType"; "3")
									End case 
									
									WAPI_setParameter("table"; "webewires")
									WAPI_setParameter("primarykey"; "webewires___webewireid")
									WAPI_setParameter("webewires___webewireid"; $webewireid)
									WAPI_setParameter("request"; $context+"/webewires-confirm.shtml")
									
									UTIL_Log(Current method name:C684; $username+": reference found: "+$webewireid+" context: "+$context+" send: readRecord"+\
										" Tran Status: "+$transStatus)  //debug - remove later
									WAPI_onWebConnection("/"+$context+"/readRecord"; $2; $3; $4; $5; $6)
									
								Else 
									
									UTIL_Log(Current method name:C684; $username+": token not found: "+$token+" context: "+$context+" send: home.shtml")  //debug - remove later
									WAPI_onWebConnection("/"+$context+"/home.shtml"; $2; $3; $4; $5; $6)
								End if 
								
								
							: (Position:C15("/paymark-return"; $1)>0)  //paymark callback
								UTIL_Log(Current method name:C684; $username+": "+$1)  //debug - remove later
								
								$webewireid:=WAPI_getParameter("Reference")
								
								$entity:=ds:C1482.WebEWires.query("WebEwireID == :1"; $webewireid)
								
								If ($entity.length=1)
									WAPI_setParameter("table"; "webewires")
									WAPI_setParameter("primarykey"; "webewires___webewireid")
									WAPI_setParameter("webewires___webewireid"; $webewireid)
									WAPI_setParameter("request"; $context+"/webewires-confirm.shtml")
									
									$transStatus:=$entity.first().paymentInfo.status
									
									Case of 
										: ($transStatus="SUCCESSFUL")  //success
											$webErrorMessage:=getKeyValue("web.customers.webewires.confirmation.alert")
											If ($webErrorMessage="")
												$webErrorMessage:="You have successfully completed your eWire request.<br>We will review your transaction and send you an email<br>once payment has been processed."
											End if 
											WAPI_setParameter("alertMessage"; $webErrorMessage)
											WAPI_setParameter("alertType"; "1")
											
										: ($transStatus="UNKNOWN")
											WAPI_setParameter("alertMessage"; "Payment transaction has an UNKNOWN response.")
											WAPI_setParameter("alertType"; "3")
											
										Else   // DECLINED/BLOCKED/FAILED/INPROGRESS/CANCELLED
											If ($transStatus="")
												$transStatus:="NOT FOUND"
											End if 
											
											WAPI_setParameter("alertMessage"; "Payment Status "+$transStatus)
											WAPI_setParameter("alertType"; "3")
									End case 
									
									
									UTIL_Log(Current method name:C684; $username+": reference found: "+$webewireid+" context: "+$context+" send: readRecord"+\
										" Tran Status: "+$transStatus)  //debug - remove later
									WAPI_onWebConnection("/"+$context+"/readRecord"; $2; $3; $4; $5; $6)
									
								Else 
									
									UTIL_Log(Current method name:C684; $username+": token not found: "+$token+" context: "+$context+" send: home.shtml")  //debug - remove later
									WAPI_onWebConnection("/"+$context+"/home.shtml"; $2; $3; $4; $5; $6)
								End if 
								
							: (Position:C15("/poli-"; $1)>0)  //poli callback
								UTIL_Log(Current method name:C684; $username+": "+$1)  //debug - remove later
								
								$token:=WAPI_getParameter("token")  //POLI_getTokenFromLink ($1)
								
								$entity:=ds:C1482.WebEWires.query("paymentInfo.poliToken == :1"; $token)
								
								If ($entity.length=1)
									WAPI_setParameter("table"; "webewires")
									WAPI_setParameter("primarykey"; "webewires___webewireid")
									WAPI_setParameter("webewires___webewireid"; $entity.first().WebEwireID)
									WAPI_setParameter("request"; $context+"/webewires-confirm.shtml")
									
									Case of 
										: ($1="@/poli-success@")
											$webErrorMessage:=getKeyValue("web.customers.webewires.confirmation.alert")
											If ($webErrorMessage="")
												$webErrorMessage:="You have successfully completed your eWire request.<br>We will review your transaction and send you an email<br>once payment has been processed."
											End if 
											
											WAPI_setParameter("alertMessage"; $webErrorMessage)
											WAPI_setParameter("alertType"; "1")
											
										: ($1="@/poli-failure@")
											WAPI_setParameter("alertMessage"; "Poli Payment has Failed.")
											WAPI_setParameter("alertType"; "3")
											
										: ($1="@/poli-cancel@")
											WAPI_setParameter("alertMessage"; "Poli Payment has been Cancelled")
											WAPI_setParameter("alertType"; "3")
											
									End case 
									
									UTIL_Log(Current method name:C684; $username+": token found: "+$token+" context: "+$context+" send: readRecord")  //debug - remove later
									WAPI_onWebConnection("/"+$context+"/readRecord"; $2; $3; $4; $5; $6)
									
								Else 
									
									UTIL_Log(Current method name:C684; $username+": token not found: "+$token+" context: "+$context+" send: home.shtml")  //debug - remove later
									WAPI_onWebConnection("/"+$context+"/home.shtml"; $2; $3; $4; $5; $6)
								End if 
								
							Else 
								WAPI_onWebConnection($1; $2; $3; $4; $5; $6)
						End case 
						
					Else 
						
						
						Case of 
							: (Position:C15("/poli-"; $1)>0)  //poli callback should be here outside of session
								UTIL_Log(Current method name:C684; $1)  //debug - remove later
								UTIL_Log(Current method name:C684; "SESSION not found: "+WEB Get current session ID:C1162+" context: "+$context+" send: login.shtml")  //debug - remove later
								
							: (Position:C15("/pmark-"; $1)>0)  //paymark callback should be here outside of session
								UTIL_Log(Current method name:C684; $1)  //debug - remove later
								UTIL_Log(Current method name:C684; "SESSION not found: "+WEB Get current session ID:C1162+" context: "+$context+" send: login.shtml")  //debug - remove later
								
						End case 
						
						webSendLoginPage
						//WAPI_onWebConnection ($1;$2;$3;$4;$5;$6)
				End case 
				
			End if 
	End case 
	
Else 
	WEB SEND TEXT:C677("Critical Error: Contact Support")
	WAPI_Log(Current method name:C684; "Blocked: "+$3+" URL: "+$1)
End if 