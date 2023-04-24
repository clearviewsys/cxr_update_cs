//%attributes = {}
C_LONGINT:C283($0)
C_TEXT:C284($1; $2; $wireID; $currency; $error; $authKey; $beneficiaryID; $paymentID; $verification)
C_BOOLEAN:C305($3; $priority)
C_POINTER:C301($errorPtr)
C_OBJECT:C1216($responseObj)

C_POINTER:C301($pError)
$error:=""
$pError:=->$error


Case of 
	: (Count parameters:C259=3)
		$wireID:=$1
		$currency:=$2
		$priority:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


If (getKeyValue("currencyCloud.activated")="true")
	
	$authKey:=CC_login(getKeyValue("currencyCloud.user"); \
		getKeyValue("currencyCloud.pass"); $pError)
	
	
	If (Length:C16($authKey)>3)
		//Successful login
		
		//Select query record matching passed in ID
		READ WRITE:C146([Wires:8])
		READ WRITE:C146([Customers:3])
		READ WRITE:C146([WireTemplates:42])
		SET QUERY LIMIT:C395(1)
		QUERY:C277([Wires:8]; [Wires:8]CXR_WireID:1=$wireID)
		If (Records in selection:C76([Wires:8])=1)
			OK:=1
			If ([Wires:8]CC_PaymentID:86#"")
				myConfirm("This wire has already been sent with Currency Cloud, are you sure you would like to send it again?")
			End if 
			If (OK=1)
				If ($currency=[Wires:8]Currency:15)
					If (([Wires:8]BeneficiaryCountryCode:78="AE") | (([Wires:8]BeneficiaryCountryCode:78="") & ([Wires:8]BeneficiaryBankCountryCode:77="AE")))
						myAlert("Sending wires to the United Arab Emirates is currently not supported by CXR's Currency Cloud API."+Char:C90(Carriage return:K15:38)+\
							"The country will be available in future updates")
						$0:=400
					Else 
						QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=[Wires:8]CustomerID:2)
						
						If (Records in selection:C76([Customers:3])=1)
							QUERY:C277([WireTemplates:42]; [WireTemplates:42]WireTemplateID:1=[Wires:8]WireTemplateID:83)
							SET QUERY LIMIT:C395(0)
							
							//Fill in beneficiary fields with data from [Wires]
							C_OBJECT:C1216($beneficiaryObj; $paymentObj)
							
							If ((Records in selection:C76([WireTemplates:42])=1) & ([WireTemplates:42]CC_BeneficiaryID:37#""))
								$beneficiaryID:=[WireTemplates:42]CC_BeneficiaryID:37
							Else 
								If ([Wires:8]CC_BeneficiaryID:87#"")
									$beneficiaryID:=[Wires:8]CC_BeneficiaryID:87
								Else 
									$beneficiaryObj:=New object:C1471()
									
									$beneficiaryObj.currency:=$currency
									$beneficiaryObj.bank_country:=[Wires:8]BeneficiaryBankCountryCode:77
									If ($beneficiaryObj.bank_country="")
										$beneficiaryObj.bank_country:=[Wires:8]BeneficiaryCountryCode:78
									End if 
									If ($beneficiaryObj.bank_country="")
										$beneficiaryObj.bank_country:=[Wires:8]BeneficiaryBankCountry:6
									End if 
									
									$beneficiaryObj.beneficiary_address:=[Wires:8]BeneficiaryAddress:26
									$beneficiaryObj.beneficiary_country:=[Wires:8]BeneficiaryCountryCode:78
									If ($beneficiaryObj.beneficiary_country="")
										$beneficiaryObj.beneficiary_country:=[Wires:8]BeneficiaryBankCountryCode:77
									End if 
									If ($beneficiaryObj.beneficiary_country="")
										$beneficiaryObj.beneficiary_country:=[Wires:8]BeneficiaryBankCountry:6
									End if 
									$beneficiaryObj.account_number:=[Wires:8]BeneficiaryAccountNo:9
									
									//  fix for CurrencyCloud API @milan
									//If ($currency#"USD")
									//$beneficiaryObj.iban:=[Wires]BeneficiaryAccountNo
									//End if 
									$beneficiaryObj.iban:=[Wires:8]BeneficiaryAccountNo:9
									
									$beneficiaryObj.routing_code_type_1:="institution_no"
									$beneficiaryObj.routing_code_value_1:=[Wires:8]BeneficiaryInstitutionNo:7
									$beneficiaryObj.routing_code_type_2:="branch_code"
									$beneficiaryObj.routing_code_value_2:=[Wires:8]BeneficiaryBranchTransitNo:8
									$beneficiaryObj.bic_swift:=[Wires:8]BeneficiarySWIFT:28
									If ([Wires:8]isBeneficiaryEntity:71)
										$beneficiaryObj.beneficiary_entity_type:="company"
										$beneficiaryObj.beneficiary_company_name:=[Wires:8]BeneficiaryFullName:10
									Else 
										$beneficiaryObj.beneficiary_entity_type:="individual"
										//Need to be seperated from [Wires]BeneficiaryFullName
										$beneficiaryObj.beneficiary_first_name:=FT_GetFirstName([Wires:8]BeneficiaryFullName:10)
										$beneficiaryObj.beneficiary_last_name:=FT_GetLastName([Wires:8]BeneficiaryFullName:10)
									End if 
									$beneficiaryObj.beneficiary_city:=[Wires:8]BeneficiaryCity:50
									If ($beneficiaryObj.beneficiary_city="")
										$beneficiaryObj.beneficiary_city:=[Wires:8]BeneficiaryBankCityState:5
									End if 
									$beneficiaryObj.beneficiary_postcode:=[Wires:8]BeneficiaryZIPCode:52
									$beneficiaryObj.beneficiary_state_or_province:=[Wires:8]BeneficiaryState:51
									$beneficiaryObj.beneficiary_date_of_birth:=DATE_formatAsString([Wires:8]BeneficiaryDOB:74)
									If ($beneficiaryObj.beneficiary_date_of_birth="0000-00-00")
										OB REMOVE:C1226($beneficiaryObj; "beneficiary_date_of_birth")
									End if 
									
									$beneficiaryObj.name:=[Wires:8]BeneficiaryFullName:10
									$beneficiaryObj.bank_account_holder_name:=[Wires:8]BeneficiaryFullName:10
									
									CC_removeBlankFields($beneficiaryObj)
									
									$verification:=CC_validateBeneficiaryFields($pError; $beneficiaryObj; $authKey; $priority)
									
									If ($verification#"200")
										myConfirm($verification+Char:C90(Carriage return:K15:38)+"Would you like to continue?")
										If (OK=1)
											$beneficiaryID:=CC_createBeneficiary($pError; $beneficiaryObj; $authKey)
										Else 
											$pError->:="Beneficiary creation cancelled"
										End if 
									Else 
										$beneficiaryID:=CC_createBeneficiary($pError; $beneficiaryObj; $authKey)
									End if 
									
									
								End if 
							End if 
							
							If (Length:C16($beneficiaryID)>3)
								//Success on creating a beneficiary
								C_OBJECT:C1216($account)
								$account:=New object:C1471()
								$account:=CC_getBalance($pError; $currency; $authKey)
								If (Num:C11($account.amount)<Num:C11([Wires:8]Amount:14))
									myConfirm("Account selected does not contain enough funds to complete transfer"\
										+Char:C90(Carriage return:K15:38)\
										+"Would you like to continue?")
								End if 
								If (OK=1)
									
									$paymentObj:=New object:C1471()
									
									$paymentObj.beneficiary_id:=$beneficiaryID
									$paymentObj.amount:=String:C10([Wires:8]Amount:14)
									$paymentObj.currency:=$currency
									$paymentObj.reference:=[Wires:8]CXR_WireID:1
									$paymentObj.purpose_code:=[Wires:8]currencyCloudPurposeCode:89
									$paymentObj.reason:=[Wires:8]AML_PurposeOfTransaction:49
									If (($currency="CNY") | ($currency="INR") | ($currency="MYR"))
										$paymentObj.reason:=[Wires:8]currencyCloudPurposeCode:89
									End if 
									If ($paymentObj.reason="")
										$paymentObj.reason:=[Wires:8]Memo:19
									End if 
									$paymentObj.payment_date:=DATE_formatAsString(Date:C102(Current date:C33))
									If ($paymentObj.payment_date="0000-00-00")
										OB REMOVE:C1226($paymentObj; "payment_date")
									End if 
									If ($priority)
										$paymentObj.payment_type:="priority"
									Else 
										$paymentObj.payment_type:="regular"
									End if 
									If ([Wires:8]OriginatorFullName:34="")
										$paymentObj.payer_entity_type:="individual"
										$paymentObj.payer_date_of_birth:=DATE_formatAsString([Customers:3]DOB:5)
										$paymentObj.payer_city:=[Customers:3]City:8
										$paymentObj.payer_address:=[Customers:3]Address:7
										$paymentObj.payer_postcode:=[Customers:3]PostalCode:10
										$paymentObj.payer_state_or_province:=[Customers:3]Province:9
										$paymentObj.payer_country:=[Customers:3]CountryCode:113
										$paymentObj.payer_first_name:=[Customers:3]FirstName:3
										$paymentObj.payer_last_name:=[Customers:3]LastName:4
									Else 
										$paymentObj.payer_city:=[Wires:8]OriginatorCity:37
										$paymentObj.payer_address:=[Wires:8]OriginatorAddress:36
										$paymentObj.payer_postcode:=[Wires:8]OriginatorZIP:40
										$paymentObj.payer_state_or_province:=[Wires:8]OriginatorState:38
										$paymentObj.payer_country:=[Wires:8]OriginatorCountry:39
										$paymentObj.payer_first_name:=FT_GetFirstName([Wires:8]OriginatorFullName:34)
										$paymentObj.payer_last_name:=FT_GetLastName([Wires:8]OriginatorFullName:34)
									End if 
									
									//Fill in CC_BeneficiaryID field in [WireTemplates]
									If (Records in selection:C76([WireTemplates:42])=1)
										[WireTemplates:42]CC_BeneficiaryID:37:=$beneficiaryID
										SAVE RECORD:C53([WireTemplates:42])
									Else 
										[Wires:8]CC_BeneficiaryID:87:=$beneficiaryID
									End if 
									
									CC_removeBlankFields($paymentObj)
									
									$responseObj:=CC_createPayment($pError; $paymentObj; $authKey)
									If (OB Is defined:C1231($responseObj; "Error"))
										$paymentID:=String:C10($responseObj.Error)
									Else 
										$paymentID:=String:C10($responseObj.id)
									End if 
									If (Length:C16($paymentID)>3)
										//Success on creating payments
										//Fill in CC_PaymentID field in [Wires]
										
										[Wires:8]CC_PaymentID:86:=$paymentID
										[Wires:8]WireNo:48:=$responseObj.short_reference
										SAVE RECORD:C53([Wires:8])
										
										myAlert("Payment sent successfully")
										$0:=200
									Else 
										//Failure creating payment
										myAlert("Failure creating payment: "+Char:C90(Carriage return:K15:38)+$pError->)
										$0:=Num:C11($paymentID)
									End if 
								Else 
									myAlert("Transfer Cancelled")
									$0:=400
								End if 
							Else 
								//Failure creating beneficiary
								myAlert("Failure creating beneficiary: "+Char:C90(Carriage return:K15:38)+$pError->)
								$0:=Num:C11($beneficiaryID)
							End if 
							
							
							
						Else 
							//CustomerID from [Wires] not found in [Customers]
							myAlert("Customer for Wire does not exist")
							$0:=400
						End if 
						
					End if 
				Else 
					//Selected Currency does not match Wire currency
					myAlert("Selected Currency does not match Wire currency")
					$0:=400
				End if 
			Else 
				//Payment already exists on Currency Cloud
				myAlert("Wire has already been created on Currency Cloud"+\
					Char:C90(Carriage return:K15:38)+\
					"Payment ID: "+\
					[Wires:8]CC_PaymentID:86)
				$0:=200
			End if 
		Else 
			//Wire ID not found in [Wires]
			myAlert("Wire not found")
			$0:=400
			
		End if 
		CC_logout($authKey)
	Else 
		//Error on login
		myAlert("Error on login")
		$0:=400
	End if 
	
Else 
	//Currency Cloud not active
	myAlert("You do not have Currency Cloud transfers activated on your account")
	$0:=400
End if 



