//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 10/18/18, 18:23:43
// ----------------------------------------------------
// Method: webDefaultValues_Ewires
// Description
// 
//    fill in any extra data prior to saving the new record

// Parameters
// ----------------------------------------------------




C_POINTER:C301($1; $ptrNameArray)
C_POINTER:C301($2; $ptrValueArray)
C_LONGINT:C283($0)

//agent or customer creating this
//TRACE

Case of 
	: (webContext="agents")
		// -- AGENTS NOW ONLY SETTLE EWIRES VIA THE WEB -- NO UPDATING ----
		webSelectAgentRecord
		
		If ([eWires:13]eWireID:1="")
			[eWires:13]eWireID:1:=createSerializedID(->[eWires:13]; 100000; "WEB")  //makeeWireID
		End if 
		
		If ([eWires:13]AgentID:26="")
			[eWires:13]AgentID:26:=[Agents:22]AgentID:1
			[eWires:13]fromCountry:9:=[Agents:22]Country:5
			[eWires:13]fromCountryCode:111:=[Agents:22]CountryCode:21
		End if 
		
		If (False:C215)  //<-- this should be pickable in the ewire -- but how to limit???
			//fallback to the head office
			[eWires:13]toCountry:10:=[Customers:3]Country_obs:11  //<----????
			[eWires:13]toCountryCode:112:=[Customers:3]CountryCode:113
		End if 
		
		[eWires:13]DeliveryAddress:37:=""
		[eWires:13]phoneNumber:39:=[Agents:22]MainPhone:11
		[eWires:13]BranchID:50:="WEB"
		[eWires:13]createdByUser:51:=[Agents:22]FullName:6
		[eWires:13]creationDate:53:=Current date:C33
		[eWires:13]creationTime:54:=Current time:C178
		If ([eWires:13]SendDate:2=!00-00-00!)
			[eWires:13]SendDate:2:=Current date:C33
		End if 
		
		If ([eWires:13]FromAmount:13=0)
			[eWires:13]FromAmount:13:=[eWires:13]amountLocal:45-[eWires:13]sourceServicefeeLocal:44
		End if 
		
		If (False:C215)  //update popup on web to use code and then activate
			//[eWires]fromMOP_Code:=""
			//[eWires]toMOP_Code:=""
			QUERY:C277([PaymentTypes:116]; [PaymentTypes:116]Code:2=[eWires:13]fromMOP_Code:113)
			[eWires:13]fromMOP:115:=[PaymentTypes:116]PaymentType:3
			QUERY:C277([PaymentTypes:116]; [PaymentTypes:116]Code:2=[eWires:13]toMOP_Code:114)
			[eWires:13]toMOP:116:=[PaymentTypes:116]PaymentType:3
		End if 
		
		[eWires:13]Status:22:=""
		[eWires:13]eWireStatus:121:=1  //submitted - initial save of ewire sets status to submitted. Needs to be approved to be settled
		
		
		[eWires:13]sanctionCheckResultString:71:=""
		[eWires:13]didCheckAgainstSanctionList:69:=False:C215
		[eWires:13]didMatchWithSanctionList:70:=False:C215
		
		
		If ([eWires:13]securityChallengeCode:75="")
			[eWires:13]securityChallengeCode:75:=Substring:C12(makeSecurityChallengeCode; 1; 4)
		End if 
		
		
		If (True:C214)  //-- SET THE SENDER INFO BASED ON PARENT LINK RECORD ----
			READ WRITE:C146([Links:17])
			QUERY:C277([Links:17]; [Links:17]LinkID:1=[eWires:13]LinkID:8)  //SENDER -- PARENT LINK RECORD
			
			If (Records in selection:C76([Links:17])=1)
				[eWires:13]senderAddress:96:=[Links:17]Address:19
				[eWires:13]senderCity:98:=[Links:17]City:11
				[eWires:13]senderDOB:101:=[Links:17]DOB:49
				[eWires:13]senderEmail:102:=[Links:17]email:5
				[eWires:13]senderGovernmentID:103:=[Links:17]PictureIDNo:35
				[eWires:13]senderGovernmentIDType:104:=[Links:17]PictureIDType:34
				//[eWires]SenderName:=[Links]FullName
				[eWires:13]senderPhone:97:=[Links:17]MainPhone:8
				[eWires:13]senderPostalCode:100:=""
				[eWires:13]senderState:99:=[Links:17]countryCode:50  //<---- ??????
				//[eWires]fromCountry
				//[eWires]fromCountryCode
			End if 
		End if 
		
		
		
		If (False:C215)  //moved to case statement
			If ([eWires:13]CustomerID:15="NEW@")  //add the info to the existing link if nothing thereelse create new
				[eWires:13]CustomerID:15:=""
				
				If ([Links:17]CustomerName:15="")  //current link doesnt have a customer yet (new client setup)
					[Links:17]CustomerName:15:=[eWires:13]BeneficiaryFullName:5
					[Links:17]CustomerPhone:16:=[eWires:13]BeneficiaryCellPhone:61
					[Links:17]CustomerBankInfo:17:=[eWires:13]BeneficiaryBankDetails:38
					[Links:17]UnconfirmedCustomerName:18:=[eWires:13]BeneficiaryFullName:5
				Else 
					//CREATE A NEW LINKS RECORD
					CREATE RECORD:C68([Links:17])
					createLinkID
					[Links:17]sameAsLinkID:52:=[eWires:13]LinkID:8
					[Links:17]countryCode:50:=[eWires:13]fromCountryCode:111
					[Links:17]Country:12:=[eWires:13]fromCountry:9
					
					[Links:17]CustomerID:14:=""
					[Links:17]CustomerName:15:=[eWires:13]BeneficiaryFullName:5
					[Links:17]CustomerPhone:16:=[eWires:13]BeneficiaryCellPhone:61
					[Links:17]CustomerBankInfo:17:=[eWires:13]BeneficiaryBankDetails:38
					[Links:17]UnconfirmedCustomerName:18:=[eWires:13]BeneficiaryFullName:5
					
					[Links:17]Relationship:26:=""  //-- DO WE NEED TO CAPTURE THIS ON THE EWIRE FROM???
					
					[Links:17]createdByUser:39:=[Agents:22]AgentID:1
					[Links:17]modifiedByUser:40:=""
					[Links:17]CreationDate:20:=Current date:C33
					[Links:17]CreationTime:21:=Current time:C178
					[Links:17]ModificationDate:22:=!00-00-00!
					[Links:17]ModificationTime:23:=?00:00:00?
					
					If (False:C215)  //this will all come from the "primary/parent" link record
						//[Links]FirstName:=
						//[Links]LastName:=
						//[Links]FullName:=
						//[Links]email:=
						//[Links]HomePhone:=
						//[Links]SecondaryPhone:=
						//[Links]MainPhone:=
						//[Links]BankingDetails:=
						//[Links]Comments:=
						//[Links]City:=
						//[Links]AuthorizedUser:=
						//[Links]Address:=
						//[Links]TouchedByUserID:=
						//[Links]Salutation:=
						//[Links]UnicodeName:=
						//[Links]BankName:=
						//[Links]BankTransitCode:=
						//[Links]BankAddress:=
						//[Links]BankAccountNo:=
						//[Links]isFlagged:=
						//[Links]Nationality:=
						//[Links]PictureIDType:=
						//[Links]PictureIDNo:=
						//[Links]PictureIDExpDate:=
						//[Links]PictureIDIssuedIn:=
						//[Links]BranchID:=
						//[Links]defaultPurposeOfTransaction:=
						//[Links]CompanyName:=
						//[Links]isCompany:=
						//[Links]_Sync_ID:=
						//[Links]_Sync_Data:=
						//[Links]occupation:=
						//[Links]Gender:=
						//[Links]UUID:=
						//[Links]DOB:=
						//[Links]isAccount:=
					End if 
					
				End if 
				
				SAVE RECORD:C53([Links:17])
				
				[eWires:13]LinkID:8:=[Links:17]LinkID:1  //update for new link
				
			End if 
		End if 
		
		Case of 
			: ([eWires:13]CustomerID:15="NEW@")  //add the info to the existing link if nothing there else create new LINK 
				[eWires:13]CustomerID:15:=""
				
				If ([Links:17]CustomerName:15="")  //current link doesnt have a customer yet (new client setup)
					[Links:17]CustomerName:15:=[eWires:13]BeneficiaryFullName:5
					[Links:17]CustomerPhone:16:=[eWires:13]BeneficiaryCellPhone:61
					[Links:17]CustomerBankInfo:17:=[eWires:13]BeneficiaryBankDetails:38
					[Links:17]UnconfirmedCustomerName:18:=[eWires:13]BeneficiaryFullName:5
				Else 
					//CREATE A NEW LINKS RECORD
					CREATE RECORD:C68([Links:17])
					createLinkID
					[Links:17]sameAsLinkID:52:=[eWires:13]LinkID:8
					[Links:17]countryCode:50:=[eWires:13]fromCountryCode:111
					[Links:17]Country:12:=[eWires:13]fromCountry:9
					
					[Links:17]CustomerID:14:=""
					[Links:17]CustomerName:15:=[eWires:13]BeneficiaryFullName:5
					[Links:17]CustomerPhone:16:=[eWires:13]BeneficiaryCellPhone:61
					[Links:17]CustomerBankInfo:17:=[eWires:13]BeneficiaryBankDetails:38
					[Links:17]UnconfirmedCustomerName:18:=[eWires:13]BeneficiaryFullName:5
					
					[Links:17]Relationship:26:=""  //-- DO WE NEED TO CAPTURE THIS ON THE EWIRE FROM???
					
					[Links:17]createdByUser:39:=[Agents:22]AgentID:1
					[Links:17]modifiedByUser:40:=""
					[Links:17]CreationDate:20:=Current date:C33
					[Links:17]CreationTime:21:=Current time:C178
					[Links:17]ModificationDate:22:=!00-00-00!
					[Links:17]ModificationTime:23:=?00:00:00?
					
					If (False:C215)  //this will all come from the "primary/parent" link record
						//[Links]FirstName:=
						//[Links]LastName:=
						//[Links]FullName:=
						//[Links]email:=
						//[Links]HomePhone:=
						//[Links]SecondaryPhone:=
						//[Links]MainPhone:=
						//[Links]BankingDetails:=
						//[Links]Comments:=
						//[Links]City:=
						//[Links]AuthorizedUser:=
						//[Links]Address:=
						//[Links]TouchedByUserID:=
						//[Links]Salutation:=
						//[Links]UnicodeName:=
						//[Links]BankName:=
						//[Links]BankTransitCode:=
						//[Links]BankAddress:=
						//[Links]BankAccountNo:=
						//[Links]isFlagged:=
						//[Links]Nationality:=
						//[Links]PictureIDType:=
						//[Links]PictureIDNo:=
						//[Links]PictureIDExpDate:=
						//[Links]PictureIDIssuedIn:=
						//[Links]BranchID:=
						//[Links]defaultPurposeOfTransaction:=
						//[Links]CompanyName:=
						//[Links]isCompany:=
						//[Links]_Sync_ID:=
						//[Links]_Sync_Data:=
						//[Links]occupation:=
						//[Links]Gender:=
						//[Links]UUID:=
						//[Links]DOB:=
						//[Links]isAccount:=
					End if 
					
				End if 
				
				SAVE RECORD:C53([Links:17])
				
				[eWires:13]LinkID:8:=[Links:17]LinkID:1  //update for new link
				
			: ([eWires:13]CustomerID:15="")
				// THIS SHOULDN'T HAPPEN - TRAP ERROR HERE <>TODO
				
			: ([eWires:13]CustomerID:15="|@")  //unestablished link
				//USE WHAT WAS ENTERED
				
			Else 
				QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=[eWires:13]CustomerID:15)
				If (Records in selection:C76([Customers:3])=1)
					[eWires:13]BeneficiaryAddress:59:=[Customers:3]Address:7
					[eWires:13]BeneficiaryAmendedName:119:=[Customers:3]FullName:40
					[eWires:13]BeneficiaryCellPhone:61:=[Customers:3]CellPhone:13
					[eWires:13]BeneficiaryCity:60:=[Customers:3]City:8
					[eWires:13]BeneficiaryCompanyName:92:=[Customers:3]CompanyName:42
					[eWires:13]BeneficiaryDOB:110:=[Customers:3]DOB:5
					[eWires:13]BeneficiaryEmail:63:=[Customers:3]Email:17
					[eWires:13]BeneficiaryGender:108:=[Customers:3]Gender:120
					[eWires:13]BeneficiaryRelationship:64:=[Customers:3]Relationship1:32
					[eWires:13]BeneficiarySalutation:109:=[Customers:3]Salutation:2
					//[eWires]BeneficiaryFullName:=  <--- should have this
					//[eWires]BeneficiarySWIFT:=
					[eWires:13]BeneficiaryUNICODEName:62:=[Customers:3]UNICODE_EthnicName:74
					
					//NOW CHECK FOR EXISTING LINK AND IF NONE CREATE ONE
					QUERY:C277([Links:17]; [Links:17]LinkID:1=[eWires:13]LinkID:8; *)
					QUERY:C277([Links:17];  | ; [Links:17]sameAsLinkID:52=[eWires:13]LinkID:8)
					QUERY SELECTION:C341([Links:17]; [Links:17]CustomerID:14=[eWires:13]CustomerID:15)
					
					If (Records in selection:C76([Links:17])=1)  //all good 
					Else 
						//create new link for this sender
						//CREATE A NEW LINKS RECORD
						CREATE RECORD:C68([Links:17])
						createLinkID
						[Links:17]sameAsLinkID:52:=[eWires:13]LinkID:8
						[Links:17]countryCode:50:=[eWires:13]fromCountryCode:111
						[Links:17]Country:12:=[eWires:13]fromCountry:9
						
						[Links:17]CustomerID:14:=[eWires:13]CustomerID:15  //new link to this customer record
						[Links:17]CustomerName:15:=[eWires:13]BeneficiaryFullName:5
						[Links:17]CustomerPhone:16:=[eWires:13]BeneficiaryCellPhone:61
						[Links:17]CustomerBankInfo:17:=[eWires:13]BeneficiaryBankDetails:38
						[Links:17]UnconfirmedCustomerName:18:=[eWires:13]BeneficiaryFullName:5
						
						[Links:17]Relationship:26:=""  //-- DO WE NEED TO CAPTURE THIS ON THE EWIRE FROM???
						
						[Links:17]createdByUser:39:=[Agents:22]AgentID:1
						[Links:17]modifiedByUser:40:=""
						[Links:17]CreationDate:20:=Current date:C33
						[Links:17]CreationTime:21:=Current time:C178
						[Links:17]ModificationDate:22:=!00-00-00!
						[Links:17]ModificationTime:23:=?00:00:00?
						
						If (False:C215)  //this will all come from the "primary/parent" link record
							//[Links]FirstName:=
							//[Links]LastName:=
							//[Links]FullName:=
							//[Links]email:=
							//[Links]HomePhone:=
							//[Links]SecondaryPhone:=
							//[Links]MainPhone:=
							//[Links]BankingDetails:=
							//[Links]Comments:=
							//[Links]City:=
							//[Links]AuthorizedUser:=
							//[Links]Address:=
							//[Links]TouchedByUserID:=
							//[Links]Salutation:=
							//[Links]UnicodeName:=
							//[Links]BankName:=
							//[Links]BankTransitCode:=
							//[Links]BankAddress:=
							//[Links]BankAccountNo:=
							//[Links]isFlagged:=
							//[Links]Nationality:=
							//[Links]PictureIDType:=
							//[Links]PictureIDNo:=
							//[Links]PictureIDExpDate:=
							//[Links]PictureIDIssuedIn:=
							//[Links]BranchID:=
							//[Links]defaultPurposeOfTransaction:=
							//[Links]CompanyName:=
							//[Links]isCompany:=
							//[Links]_Sync_ID:=
							//[Links]_Sync_Data:=
							//[Links]occupation:=
							//[Links]Gender:=
							//[Links]UUID:=
							//[Links]DOB:=
							//[Links]isAccount:=
						End if 
						
						SAVE RECORD:C53([Links:17])
					End if 
				Else 
					//TRAP FOR ERROR HERE <>TODO
				End if 
		End case 
		
		
		[eWires:13]AgentID:26:=[Agents:22]AgentID:1  //5/6/19
		[eWires:13]Author:4:=[Agents:22]AgentID:1
		
		UNLOAD RECORD:C212([Links:17])
		READ ONLY:C145([Links:17])
		REDUCE SELECTION:C351([Links:17]; 0)
		
		
	: (webContext="customer")
		webSelectCustomerRecord
		pickCurrency(->[eWires:13]Currency:12)
		
		
		[eWires:13]CustomerID:15:=[Customers:3]CustomerID:1
		[eWires:13]isPaymentSent:20:=True:C214  //from web default
		[eWires:13]Author:4:=""
		
		[eWires:13]Subject:6:=""
		[eWires:13]SenderName:7:=[Customers:3]LastName:4+", "+[Customers:3]FirstName:3
		
		QUERY:C277([Links:17]; [Links:17]CustomerID:14=[Customers:3]CustomerID:1; *)
		QUERY:C277([Links:17];  & ; [Links:17]FullName:4=[eWires:13]BeneficiaryFullName:5)
		[eWires:13]LinkID:8:=[Links:17]LinkID:1
		
		QUERY:C277([PaymentTypes:116]; [PaymentTypes:116]PaymentType:3=[eWires:13]fromMOP:115)
		[eWires:13]fromMOP_Code:113:=[PaymentTypes:116]Code:2
		
		QUERY:C277([PaymentTypes:116]; [PaymentTypes:116]PaymentType:3=[eWires:13]toMOP:116)
		[eWires:13]toMOP_Code:114:=[PaymentTypes:116]Code:2
		
		//are booleans saved????
		
		
		//----- TIRAN HOW DO WE DETERMINE FROM COUNTRY ?? -------
		[eWires:13]fromCountryCode:111:=[Customers:3]CountryCode:113
		QUERY:C277([Countries:62]; [Countries:62]CountryCode:1=[eWires:13]fromCountryCode:111)
		[eWires:13]fromCountry:9:=[Countries:62]CountryName:2
		
		[eWires:13]createdByUser:51:=webUserName
		[eWires:13]creationDate:53:=Current date:C33
		[eWires:13]creationTime:54:=Current time:C178
		
		If ([eWires:13]FromAmount:13=0)
			[eWires:13]FromAmount:13:=[eWires:13]amountLocal:45
		End if 
		
		
		
		
		
	Else 
		
End case 

//webSendNewRecordEmail (->[eWires])

$0:=0  //pass back error 
