//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 11/04/21, 20:11:17
// ----------------------------------------------------
// Method: webOnPost_WebEwires
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $ptrNameArray)
C_POINTER:C301($2; $ptrValueArray)
C_LONGINT:C283($0)

C_TEXT:C284($tAction; $requestForm; $tLinkID; $lastRefreshDts)
C_REAL:C285($rInverseRate; $rSourceRate)
C_OBJECT:C1216($quote)
C_LONGINT:C283($iResult)

$ptrNameArray:=$1
$ptrValueArray:=$2

$tAction:=WAPI_getParameter("action")
$requestForm:=WAPI_getParameter("request")

Case of 
	: (webContext="agents")
		
		Case of 
			: ($tAction="create")
				//prefill field data prior to sending the page/form
				
				webSelectAgentRecord
				
				[WebEWires:149]creationDate:15:=Current date:C33
				
				QUERY:C277([Links:17]; [Links:17]LinkID:1=[WebEWires:149]LinkID:25)  //get the sending party - primary link record 
				
				
				If ([Links:17]AML_isOnHold:54)  //don't allow to send
					WAPI_sendFile("agents/home.shtml")  //redidirect to an error page and go home
					$iResult:=0
					
				Else 
					
					[WebEWires:149]fromCountryCode:4:=[Links:17]countryCode:50
					
					
					If (True:C214)  //------- FROM PARTY ------ SENDER INFO - FROM THE LINK RECORD -----------
						
						OBJ_newFromParty(->[WebEWires:149]fromParty:7)
						
						OB SET:C1220([WebEWires:149]fromParty:7; Info_FullName; [Links:17]FullName:4)
						OB SET:C1220([WebEWires:149]fromParty:7; Info_FirstName; [Links:17]FirstName:2)
						OB SET:C1220([WebEWires:149]fromParty:7; Info_LastName; [Links:17]LastName:3)
						OB SET:C1220([WebEWires:149]fromParty:7; Info_Address; [Links:17]Address:19)
						OB SET:C1220([WebEWires:149]fromParty:7; Info_City; [Links:17]City:11)
						OB SET:C1220([WebEWires:149]fromParty:7; Info_State; "")
						OB SET:C1220([WebEWires:149]fromParty:7; Info_PostalCode; "")
						OB SET:C1220([WebEWires:149]fromParty:7; Info_CellPhone; [Links:17]MainPhone:8)
						OB SET:C1220([WebEWires:149]fromParty:7; Info_DateOfBirth; [Links:17]DOB:49)
						OB SET:C1220([WebEWires:149]fromParty:7; Info_GovernmentIDType; [Links:17]PictureIDType:34)
						OB SET:C1220([WebEWires:149]fromParty:7; Info_GovernmentID; [Links:17]PictureID:53)
						OB SET:C1220([WebEWires:149]fromParty:7; Info_CountryCode; [Links:17]countryCode:50)
						OB SET:C1220([WebEWires:149]fromParty:7; Info_Email; [Links:17]email:5)
						OB SET:C1220([WebEWires:149]fromParty:7; Info_Gender; [Links:17]Gender:47)
						
					End if 
					
					
					//---- TO PARTY ----- THE CUSTOMER IS THE BENEFICIARY IF COMING FROM A AGENT -----------
					If (True:C214)
						OBJ_newToParty(->[WebEWires:149]toParty:8)
					End if 
					
					
					
					
					If (True:C214)  //get currency and rates
						
						QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=[Links:17]CustomerID:14)  //get a default country/currency
						If ([Customers:3]CountryOfResidenceCode:114="")
							[WebEWires:149]toCountryCode:12:=[Customers:3]CountryCode:113
						Else 
							[WebEWires:149]toCountryCode:12:=[Customers:3]CountryOfResidenceCode:114
						End if 
						
						
						[WebEWires:149]toCCY:11:=getCurrencyCodeByCountryCode([WebEWires:149]toCountryCode:12)
						[WebEWires:149]fromCCY:5:=getCurrencyCodeByCountryCode([WebEWires:149]fromCountryCode:4)
						
						C_OBJECT:C1216($o)
						$o:=getCurrencyRateByPair([WebEWires:149]fromCountryCode:4; [WebEWires:149]toCountryCode:12)
						$rSourceRate:=$o.OurSellRateLocal
						$rInverseRate:=$o.OurSellRateInverse
						
						//QUERY([Currencies];[Currencies]ISO4217=[WebEWires]fromCCY;*)
						//QUERY([Currencies]; & ;[Currencies]toISO4217=[WebEWires]toCCY)
						
						//If (Records in selection([Currencies])>0)  //set to the first found
						//[WebEWires]directRate:=[Currencies]OurSellRateLocal
						//[WebEWires]inverseRate:=[Currencies]OurSellRateInverse
						//End if 
						
					End if 
					
				End if 
				
				REDUCE SELECTION:C351([Customers:3]; 0)
				
				
			Else 
				
		End case 
		
	: (webContext="customers")
		
		Case of 
			: ($tAction="create")  //assumes we have the beneficiary/link defined
				
				
				//prefill field data prior to sending the page/form
				
				WAPI_sessionSet("webewire"; New object:C1471("value"; ""))  // init so we can verify if already created via a refresh
				webSelectCustomerRecord
				
				OBJ_newPaymentInfo(->[WebEWires:149]paymentInfo:35)
				OBJ_newAMLInfo(->[WebEWires:149]AML_Info:9)
				OBJ_newBankInfo(->[WebEWires:149]toBankingInfo:24)
				OBJ_newFromParty(->[WebEWires:149]fromParty:7)
				OBJ_newToParty(->[WebEWires:149]toParty:8)
				OBJ_newThirdParty(->[WebEWires:149]toThirdParty:23)
				
				QUERY:C277([Links:17]; [Links:17]LinkID:1=[WebEWires:149]LinkID:25)  //get the sending party - primary link record 
				
				Case of 
					: ([Links:17]AML_isOnHold:54)  //don't allow to send
						//redidirect to an error page and go home
						WAPI_setAlertMessage("Beneficiary is ON HOLD"; 1)
						WAPI_sendFile("customers/home.shtml")
						$iResult:=0
						
					Else 
						
						If (True:C214)  //------- FROM PARTY ------ SENDER INFO - FROM THE CUSTOMER RECORD -----------
							[WebEWires:149]CustomerID:21:=[Customers:3]CustomerID:1
							OB SET:C1220([WebEWires:149]fromParty:7; "fullName"; [Customers:3]FullName:40)
							OB SET:C1220([WebEWires:149]fromParty:7; "firstName"; [Customers:3]FirstName:3)
							OB SET:C1220([WebEWires:149]fromParty:7; "lastName"; [Customers:3]LastName:4)
							OB SET:C1220([WebEWires:149]fromParty:7; "address"; [Customers:3]Address:7)
							OB SET:C1220([WebEWires:149]fromParty:7; "city"; [Customers:3]City:8)
							OB SET:C1220([WebEWires:149]fromParty:7; "state"; [Customers:3]Province:9)
							OB SET:C1220([WebEWires:149]fromParty:7; "postalCode"; [Customers:3]PostalCode:10)
							OB SET:C1220([WebEWires:149]fromParty:7; "cellPhone"; [Customers:3]CellPhone:13)
							OB SET:C1220([WebEWires:149]fromParty:7; "dob"; [Customers:3]DOB:5)
							OB SET:C1220([WebEWires:149]fromParty:7; "governmentIdType"; [Customers:3]PictureID_Type:70)
							OB SET:C1220([WebEWires:149]fromParty:7; "governmentId"; [Customers:3]PictureID_Number:69)
							OB SET:C1220([WebEWires:149]fromParty:7; "countryCode"; [Customers:3]CountryOfResidenceCode:114)
						End if 
						
						//---- TO PARTY ----- THE LINK IS THE BENEFICIARY IF COMING FROM A CUSTOMER -----------
						If (True:C214)  //IF NO LINK THEN THIS WILL JUST INITIALIZE THE OBJECT
							
							OB SET:C1220([WebEWires:149]toParty:8; "salutation"; [Links:17]Salutation:25)
							OB SET:C1220([WebEWires:149]toParty:8; "fullName"; [Links:17]FullName:4)
							OB SET:C1220([WebEWires:149]toParty:8; "firstName"; [Links:17]FirstName:2)
							OB SET:C1220([WebEWires:149]toParty:8; "lastName"; [Links:17]LastName:3)
							OB SET:C1220([WebEWires:149]toParty:8; "address"; [Links:17]Address:19)
							OB SET:C1220([WebEWires:149]toParty:8; "city"; [Links:17]City:11)
							OB SET:C1220([WebEWires:149]toParty:8; "state"; "")
							OB SET:C1220([WebEWires:149]toParty:8; "postalCode"; "")
							OB SET:C1220([WebEWires:149]toParty:8; "cellPhone"; [Links:17]MainPhone:8)
							OB SET:C1220([WebEWires:149]toParty:8; "dob"; [Links:17]DOB:49)
							OB SET:C1220([WebEWires:149]toParty:8; "governmentIdType"; [Links:17]PictureIDType:34)
							OB SET:C1220([WebEWires:149]toParty:8; "governmentId"; [Links:17]PictureID:53)
							OB SET:C1220([WebEWires:149]toParty:8; "countryCode"; [Links:17]countryCode:50)
							OB SET:C1220([WebEWires:149]toParty:8; "email"; [Links:17]email:5)
							OB SET:C1220([WebEWires:149]toParty:8; "gender"; [Links:17]Gender:47)
							OB SET:C1220([WebEWires:149]toParty:8; "relationship"; [Links:17]Relationship:26)
							
							//If ([WebEWires]AML_Info.toMOPCode="N")  //bank transfer
							//OB SET([WebEWires]toBankingInfo;Bank_doTransferToBank;True)
							//End if 
							
							OB SET:C1220([WebEWires:149]toBankingInfo:24; Bank_Name; [Links:17]BankName:28)
							OB SET:C1220([WebEWires:149]toBankingInfo:24; Bank_AccountNo; [Links:17]BankAccountNo:31)
							OB SET:C1220([WebEWires:149]toBankingInfo:24; Bank_TransitCode; [Links:17]BankTransitCode:29)
							OB SET:C1220([WebEWires:149]toBankingInfo:24; Bank_Details; [Links:17]BankingDetails:9)
							OB SET:C1220([WebEWires:149]toBankingInfo:24; Bank_Swift; "")
							
							OB SET:C1220([WebEWires:149]AML_Info:9; AML_purposeOfTransaction; [Links:17]defaultPurposeOfTransaction:41)
						End if 
						
						C_OBJECT:C1216($status; $request)
						$status:=New object:C1471
						$status:=WAPI_UT_recordToObject(->[WebEWires:149]; False:C215)  //create  object with [webewires] data set above
						If ($status.success)
							$request:=$status.value
						Else 
							$request:=New object:C1471
						End if 
						
						$request.creationDate:=Current date:C33
						
						$request.CustomerID:=[Customers:3]CustomerID:1
						//get currency and rates
						$request.fromCountryCode:=[Customers:3]CountryOfResidenceCode:114
						$request.fromCCY:=getCurrencyCodeByCountryCode([Customers:3]CountryOfResidenceCode:114)
						$request.toCountryCode:=[Links:17]countryCode:50
						$request.toCCY:=getCurrencyCodeByCountryCode([Links:17]countryCode:50)
						
						
						
						If ($requestForm="@-quote.shtml")  // if quote then use that data
							$status:=WAPI_sessionGet("quote")
							If ($status.success)
								$quote:=$status.value
								
								If ($quote["dash-quote-from-ccy"]#"")  // need this or don't create
									
									$lastRefreshDts:=$quote["dash-quote-mg-refresh-dts"]
									
									// verify within the last 30 minutes if not return to dashboard and alert
									
									$request.isQuote:=True:C214
									
									$request.fromCountryCode:=$quote["dash-quote-from-country"]
									$request.fromCCY:=$quote["dash-quote-from-ccy"]
									$request.fromAmount:=$quote["dash-quote-amount-due"]
									$request.toCCY:=$quote["dash-quote-to-ccy"]
									$request.toCountryCode:=$quote["dash-quote-to-country"]
									$request.toAmount:=$quote["dash-quote-to-amount"]
									$request.fromFee:=$quote["dash-quote-from-fee"]
									$request.directRate:=$quote["dash-quote-direct-rate"]
									$request.inverseRate:=$quote["dash-quote-inverse-rate"]
									$request.paymentInfo.promotionCode:=$quote["dash-quote-promo-code"]
									$request.paymentInfo.transferToPointId:=$quote["dash-quote-transfer-to-point-id"]
									
									Case of 
										: ($quote["dash-quote-delivery"]="MG")  // moneygram
											$request.paymentInfo.bookingType:="MG"
										: ($request.toCountryCode="AU")
											$request.paymentInfo.bookingType:="ewire"
										: ($request.toCountryCode="FJ")
											$request.paymentInfo.bookingType:="ewire"
										: ($request.toCountryCode="NZ")
											$request.paymentInfo.bookingType:="ewire"
										Else 
											$request.paymentInfo.bookingType:="wire"
											OB SET:C1220([WebEWires:149]toBankingInfo:24; Bank_doTransferToBank; True:C214)
									End case 
									
									If ($quote["dash-quote-delivery"]="N")
										OB SET:C1220([WebEWires:149]toBankingInfo:24; Bank_doTransferToBank; True:C214)
									End if 
									
									$request.paymentInfo.deliveryMethod:=$quote["dash-quote-delivery"]
									$request.paymentInfo.deliveryMethod2:=$quote["dash-quote-delivery-mg"]
									$request.paymentInfo.deliveryMethod2Code:=$quote["dash-quote-delivery-mg-code"]
									$request.paymentInfo.paymentMethod:=Replace string:C233($quote["dash-quote-pay"]; "dash-quote-pay-method-"; "")
									
									
									
									If ($quote["dash-quote-mg-options"]=Null:C1517)
									Else 
										$request.paymentInfo.mgQuoteOptions:=$quote["dash-quote-mg-options"]
									End if 
									
									Case of 
										: ($request.paymentInfo.paymentMethod="poli")
											$request.paymentInfo.gateway:="polipayapi"
										: ($request.paymentInfo.paymentMethod="eft")
											$request.paymentInfo.gateway:="paymark"
										: ($request.paymentInfo.paymentMethod="paypal")
											$request.paymentInfo.gateway:="paypal"
										: ($request.paymentInfo.paymentMethod="sq@")
											$request.paymentInfo.gateway:="square"
										Else 
									End case 
									
									$request.paymentInfo.paymentData:=New object:C1471
									
									$request.AML_Info[AML_toMOPCode]:=$quote["dash-quote-delivery"]
									If ($quote["dash-quote-delivery"]="MG")
										$request.AML_Info["toMOP"]:="MoneyGram"
									Else 
										$request.AML_Info["toMOP"]:=getPaymentTypeFromCode([WebEWires:149]AML_Info:9[AML_toMOPCode])
									End if 
									
								End if 
								
							End if 
						End if 
						
						WAPI_UT_objectToRecord($request; ->[WebEWires:149])
						
						$request.isComplete:=False:C215
						
						
						$status:=WAPI_sessionSet("request"; New object:C1471("value"; $request))
						If ($status.success)
							If (Is compiled mode:C492=False:C215)
								WAPI_Log(Current method name:C684; JSON Stringify:C1217($request))
							End if 
						Else 
							TRACE:C157
						End if 
						
				End case 
				
				
				
			: ($tAction="update")
				
				webSelectCustomerRecord
				$tLinkID:=WAPI_getInputValue(->[WebEWires:149]LinkID:25)
				QUERY:C277([Links:17]; [Links:17]LinkID:1=$tLinkID)  //get the correct lknk loaded
				
				
		End case 
		
	: (webContext="users")
		
	Else 
		
End case 





$0:=1  //ok to continue