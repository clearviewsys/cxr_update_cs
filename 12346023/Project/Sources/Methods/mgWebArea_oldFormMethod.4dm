//%attributes = {}
C_TEXT:C284($mypage; $finalPage; $js; $result; $errorText)
C_OBJECT:C1216($oneCookie; $results)
C_LONGINT:C283($winref)

Form:C1466.waURL:=waGetURL("mywa")
SET WINDOW TITLE:C213(Form:C1466.waURL)

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		OBJECT SET VISIBLE:C603(*; "mywa"; False:C215)
		
		WA SET PREFERENCE:C1041(*; "mywa"; WA enable Web inspector:K62:7; True:C214)
		//WA SET PREFERENCE(*; "mywa"; _o_WA enable JavaScript; True)
		
		WA OPEN URL:C1020(*; "mywa"; Form:C1466.session.endpoints.baseURL)  // we need this on windows for cookies to work properly
		
		Case of 
				
			: (Form:C1466.transaction.transactionType="Send")
				
				// Form.afterSubmitURL:="https://tmg15.sb.com.ua/MG/Operator/QuickSend.aspx"
				Form:C1466.afterSubmitURL:=Form:C1466.session.endpoints.afterSendURL
				Form:C1466.valueElement:="sendData"  // HTML element ID in which Profix returns data to 4D after succesful sending transaction
				Form:C1466.errorSpanId:="ctl00_ContentPlaceHolder1_ErrorLabel"
				
				$mypage:=mgGetDocument("sendform.html")
				$finalPage:=Replace string:C233($mypage; "{getFormData}"; mgGetFormHTML(Form:C1466.transaction))
				$finalPage:=Replace string:C233($finalPage; "{URL}"; Form:C1466.session.endpoints.sendURL)
				
				// WA SET PAGE CONTENT(*;"mywa";$finalPage;"https://tmg15.sb.com.ua")
				WA SET PAGE CONTENT:C1037(*; "mywa"; $finalPage; Form:C1466.session.endpoints.baseURL)
				
				
			: (Form:C1466.transaction.transactionType="Receive")
				
				// Form.afterSubmitURL:="https://tmg15.sb.com.ua/MG/Operator/Receive.aspx"
				Form:C1466.afterSubmitURL:=Form:C1466.session.endpoints.afterReceiveURL
				Form:C1466.valueElement:="receiveData"  // HTML element ID in which Profix returns data to 4D after succesful receiving transaction
				Form:C1466.errorSpanId:="ErrorLabel"
				
				$mypage:=mgGetDocument("receiveform.html")
				$finalPage:=Replace string:C233($mypage; "{getFormData}"; mgGetFormHTML(Form:C1466.transaction))
				$finalPage:=Replace string:C233($finalPage; "{URL}"; Form:C1466.session.endpoints.receiveURL)
				
				// WA SET PAGE CONTENT(*;"mywa";$finalPage;"https://tmg15.sb.com.ua")
				WA SET PAGE CONTENT:C1037(*; "mywa"; $finalPage; Form:C1466.session.endpoints.baseURL)
				
		End case 
		
		waClearCookies("mywa"; New collection:C1472(".MG1512ASPAUTH"; "ASP.NET_SessionId"; "mgAgentCountry"; "mgLocale"))
		
		DELAY PROCESS:C323(Current process:C322; 30)
		
		For each ($oneCookie; Form:C1466.session.cookies)
			waSetCookie("mywa"; $oneCookie.cookie; $oneCookie.value)
		End for each 
		
		SET TIMER:C645(-1)
		
		
		
	: (Form event code:C388=On Timer:K2:25)
		
		SET TIMER:C645(0)
		
		
		If (Form:C1466.waitForURL=Null:C1517)  // initial URL displayed
			
			waClickOnElement("mywa"; "submit")
			
			DELAY PROCESS:C323(Current process:C322; 60*2)
			
			WA OPEN URL:C1020(*; "mywa"; Form:C1466.afterSubmitURL)
			
			OBJECT SET VISIBLE:C603(*; "mywa"; True:C214)
			
			Form:C1466.waitForURL:="/MG/Operator/Default4D.aspx"
			
		Else 
			
			// wait for user to make transfer
			
			If (Form:C1466.waitForURL#"")
				
				If (waIsURL("mywa"; Form:C1466.waitForURL))
					
					If (Form:C1466.waitForURL="/MG/Operator/Default4D.aspx")
						
						DELAY PROCESS:C323(Current process:C322; 60)
						Form:C1466.value:=waGetValue("mywa"; Form:C1466.valueElement)
						Form:C1466.valueObject:=mgGetResultData(Form:C1466.value)  // convert data into 4D object
						
						// create record
						
						If (Form:C1466.winref#Null:C1517)
							CALL FORM:C1391(Form:C1466.winref; "mgGetResult"; Form:C1466.valueObject)
						End if 
						
						SET WINDOW TITLE:C213("I've got the data, you can close the window now!")
						
						waClickOnElement("mywa"; "ctl00_ContentPlaceHolder1_TransferDetailLink")  // Click on "Show" label in the form
						DELAY PROCESS:C323(Current process:C322; 60*2)
						
						Form:C1466.waitForURL:="/MG/Operator/ViewSendLookupDetails"
						
					End if 
					
					If (Form:C1466.waitForURL="/MG/Operator/ViewSendLookupDetails")
						
						Form:C1466.waitForURL:=""
						DELAY PROCESS:C323(Current process:C322; 60*3)
						
						If (Form:C1466.valueObject#Null:C1517)
							
							$results:=New object:C1471
							$results.result:=JSON Stringify:C1217(Form:C1466.valueObject; *)
							
							$winref:=Open form window:C675("resultsForm")
							DIALOG:C40("resultsForm"; $results)
							
							CLOSE WINDOW:C154
							
						End if 
						
					End if 
					
				Else 
					
					// check if there was errors in MG page
					$errorText:=waGetSpanText("mywa"; Form:C1466.errorSpanId)
					
					If ($errorText#"")  // some error in the page
						SET WINDOW TITLE:C213($errorText)
						$errorText:=""
					End if 
					
				End if 
				
			Else 
				
				// do nothing, not waiting for any URL to load
				
			End if 
			
		End if 
		
		
		SET TIMER:C645(90)
		
		
	: (Form event code:C388=On Close Box:K2:21)
		
		If (Is Windows:C1573)
			CANCEL:C270
		Else 
			If (Form:C1466.transaction.transactionType="Send")
				If (Form:C1466.valueObject#Null:C1517)
					// prevent crash on macOS when closing a dialog with WebArea after all steps are done in Send transaction
					// crashes on High Sierra, Mojave and Catalina
					HIDE PROCESS:C324(Current process:C322)
					PAUSE PROCESS:C319(Current process:C322)
				Else 
					// crash happens only when we have the result, so it is safe to cancel here and end process
					CANCEL:C270
				End if 
			Else 
				CANCEL:C270
			End if 
		End if 
		
		
End case 
