//%attributes = {}
//Argument. /Description

//record_id: //Text : Unique //This is a unique transaction identifier that can be used to uniquely identify th.This id is usually created in a sequential manner.//This is like a primary key and corresponds to RegisterID in CXR.This attribute is called “reference_id” in FlexCube schema.
//transaction_id: //Text : non-unique //This is an identifier denoting that the transaction is part of a group of transa.//In CXR this is mapped to the InvoiceID field.
//transaction_type: //Text : //Type of transaction e.g.Cash, EFT, exchange, cheque deposit, WU Inbound, WU Outbound, etc.
//branch_code: //Text//The branch code in which the transaction occurred(if applicable).Same as BranchID in CXR
//creation_date_stamp: //Text : ISO Date Stamp//Date which the transaction was recorded in the original flexcube server.
//flex_module: //The name of the FlexCube module that the transaction was recorded in.For example{barclay@clearviewsys.comcan you give some examples of module names}.//Knowing the module would allow CXR to enquire about the appropriate module using.
//value_date: //Text : Date//Date that the transaction will take effect.For future transactions the date may be in the future This field will map to Reg.
//transaction_date_stamp: //Text : ISO Date Stamp//Date that the transaction took place.In most cases this transaction is the same as the creation date and value date.If the transaction has been entered manually at a different date, the transactio/or value date//This corresponds to the InvoiceDate/Time fields in CXR
//transaction_code: //This is from the swagger file.We need more information about what the transaction code denotes.
//instruction_code: //What is this field ? 
//flex_customer_id: //Text : FlexCube unique Customer ID
//cxr_cutomer_id: //Text : CXR customer ID if available(optional).This attribute is obviously not in the FLEXcube database.However, there may be another attribute in the Customers table that may be used .
//foreign_currency_amount: //Numeric : //A real number with high precision that represents the transaction amount(potentially in a foreing currency).E.g.1000 EUR.
//dr_br_ind: //Text : //Debit/Credit Indicator.The values In/out represent if the amount has been deposited or withdrawn from the account
//exchange_rate: //Numeric : //The exchange rate used for the transaction.This is used for foreign exchange transactions.This is 1 for the home currency(base currency : KHR)
//local_currency_amount: //Numeric : //The local amount(in home currency)equivalent to the transaction amount.//amount_local=amount*exchange_rate//(e.g.1000 EUR @ 1.4 CAD/EUR=1400 CAD)
//currency: //Currency ISO code(e.g.USD, EUR, GBP)//Also called the Account_Currency
//flex_account_id: //Unique Account ID in FlexCube that identifies which account has been affected by.For example if the customer has several accounts(checking, saving, etc)then the flex_account_id will identify which one has been affected by the transa.
//flex_user_id: //User ID who did the transaction(if applicable).Sometimes transactions are done by a teller in which case the flex_user_id will .

//cxr_customerid
//purpose_of_transaction
//source_of_funds
//third_party_name
//type_of_transaction
//destination_country_code

//first_name
//last_name
//full_name
//type_of_customer
//country_code
//occupation
//dob
//gender
//address
//countryofbirthcode
//nationality
//incorporationcountry
//incorporationdate



#DECLARE($batchID : Text; $trans : Object)->$status : Object


C_OBJECT:C1216($schema; $re; $ie; $ce)
C_TEXT:C284($schemaPath; $dts)
C_COLLECTION:C1488($col)

If (False:C215)  // for testing
	
	// check to see if in storage and retrieve from there else retrieve from disk and store in storage
	
	$schemaPath:=Get 4D folder:C485(Current resources folder:K5:16)+"jq"+Folder separator:K24:12+"cabSchema.json"
	
	If (Test path name:C476($schemaPath)=Is a document:K24:1)
		$schema:=JSON Parse:C1218(Document to text:C1236($schemaPath))
		If (OK=1)
			$status:=JSON Validate:C1456($trans; $schema)  // 
		Else 
			$status:=New object:C1471("success"; False:C215; "status"; -9099; "statusText"; "Failed to load cabSchema.json")
		End if 
	End if 
	
Else 
	$status:=New object:C1471("success"; True:C214; "status"; 0; "statusText"; "")
End if 

If ($status.success)
	
	If (String:C10($trans.flex_customer_id)#"")
		$re:=ds:C1482.Registers.new()
		
		$re.metaData:=New object:C1471()
		$re.metaData.CAB:=$trans
		$re.metaData.batchID:=$batchID
		
		If (False:C215)  //getKeyValue("CAB.testMode"; "false")="true")  // --------- RANDOM DATA PRE-CAB FINAL CSV ------
			
			$col:=ds:C1482.List_SOF.all().distinct("Code")
			$re.metaData.sourceOfFund:=$col[(Random:C100%($col.length-1))+1]
			$col:=ds:C1482.List_POT.all().distinct("Code")
			$re.metaData.purposeOfTransaction:=$col[(Random:C100%($col.length-1))+1]
			$re.metaData.typeOfTransaction:=New collection:C1472("ewire"; "cash"; "transfer")[(Random:C100%(2))+1]
			$col:=ds:C1482.Countries.all().distinct("CountryCode")
			$re.metaData.destinationCountry:=$col[(Random:C100%($col.length-1))+1]
			
		Else   // ----- NEED TO SET BASED ON NEW CSV ------
			$re.metaData.sourceOfFund:=$trans.source_of_funds
			$re.metaData.purposeOfTransaction:=$trans.purpose_of_transaction
			$re.metaData.typeOfTransaction:=$trans.type_of_transaction
			$re.metaData.destinationCountry:=$trans.destination_country_code
			$re.metaData.thirdPartyName:=$trans.third_party_name
		End if 
		
		$re.RegisterID:=$trans.record_id
		$re.InvoiceNumber:=$trans.transaction_id
		
		Case of 
			: (Value type:C1509($trans.flex_customer_id)=Is real:K8:4) | (Value type:C1509($trans.flex_customer_id)=Is longint:K8:6)
				If ($trans.flex_customer_id=0)
					$re.CustomerID:="SELF"
				Else 
					$re.CustomerID:=String:C10($trans.flex_customer_id)
				End if 
				
			: (Value type:C1509($trans.flex_customer_id)=Is text:K8:3)
				If ($trans.flex_customer_id="")
					$re.CustomerID:="SELF"
				Else 
					$re.CustomerID:=$trans.flex_customer_id
				End if 
		End case 
		
		
		
		$re.BranchID:=$trans.branch_code  // in format of 001, 006
		
		
		$re.RegisterDate:=Date:C102(OB Get:C1224($trans; "value_date"; Is text:K8:3)+"T00:00:00")
		If ($re.RegisterDate=!00-00-00!)
			$re.RegisterDate:=Date:C102($trans.value_date)
		End if 
		
		//$re.RegisterDate:=Date($trans.value_date+"T00:00:00")
		//$trans.transaction_date_stamp <--             what is this???? or what to map to? -- NEED TO ADD FIELD
		//$trans.instruction_code<--need to understand -- this has been removed
		
		$re.CreatedByUserID:=$trans.flex_user_id
		
		$dts:=$trans.creation_date_stamp+":00"  //cab is not passing seconds
		$re.CreationDate:=Date:C102($dts)
		$re.CreationTime:=Time:C179($dts)
		
		If ($re.CreationDate=!00-00-00!)
			$re.CreationDate:=Current date:C33
		End if 
		
		If ($re.CreationTime=?00:00:00?)
			$re.CreationTime:=Current time:C178
		End if 
		
		$re.Currency:=$trans.currency
		$re.OurRate:=$trans.exchange_rate
		
		$re.AccountID:=$trans.flex_account_id
		$re.RegisterType:=$trans.transaction_code
		
		
		If (Storage:C1525.cabFlexModules#Null:C1517)
			$col:=Storage:C1525.cabFlexModules.query("MODULE_ID == :1"; $trans.flex_module)
			If ($col.length>0)
				$re.Comments:=$col[0].MODULE_DESC
			End if 
		End if 
		
		If (Storage:C1525.cabTransCodes#Null:C1517)
			$col:=Storage:C1525.cabTransCodes.query("TRN_CODE == :1"; $trans.transaction_code)
			If ($col.length>0)
				If ($re.Comments#"")
					$re.Comments:=$re.Comments+"||"
				End if 
				$re.Comments:=$col[0].TRN_DESC
			End if 
		End if 
		
		
		Case of 
			: ($trans.dr_br_ind="D")
				$re.Debit:=$trans.foreign_currency_amount
				$re.DebitLocal:=$trans.local_currency_amount
				$re.Credit:=0
				$re.CreditLocal:=0
				$re.isReceived:=True:C214
				
				
			: ($trans.dr_br_ind="C")  // 
				$re.Credit:=$trans.foreign_currency_amount
				$re.CreditLocal:=$trans.local_currency_amount
				$re.Debit:=0
				$re.DebitLocal:=0
				$re.isReceived:=False:C215
				
			Else   //error
				$status.success:=False:C215
				$status.status:=-9001
				$status.statusText:="Debit Credit indicator UNKNOWN: "+$trans.dr_br_ind
		End case 
		
		
		
		
		// ----- CREATE INVOICE IF NEEDED -------
		If ($status.success)  // now check to see if we need to create an invoice
			If (ds:C1482.Invoices.query("InvoiceID == :1"; $re.InvoiceNumber).length=0)  // already created NO NEED
				$ie:=ds:C1482.Invoices.new()
				$ie.InvoiceID:=$trans.transaction_id
				$ie.invoiceDate:=Date:C102($trans.value_date)
				$ie.BranchID:=$trans.branch_code
				$ie.CreatedByUserID:=$trans.flex_user_id
				$ie.CreationDate:=Date:C102($trans.creation_date_stamp)
				$ie.CreationTime:=Time:C179($trans.creation_date_stamp)
				$ie.CustomerID:=$re.CustomerID  //$trans.flex_customer_id
				$ie.CustomerFullName:=$trans.full_name
				$ie.CustomerFullAddress:=$trans.address
				
				$ie.ExchangeRate:=$trans.exchange_rate
				$ie.SourceOfFund:=$re.metaData.sourceOfFund
				$ie.AMLPurposeOfTransaction:=$re.metaData.purposeOfTransaction
				$ie.AMLCountryCode:=$re.metaData.destinationCountry
				
				//$ie.FromAmount:=
				//$ie.FromAmountLC:=
				//$ie.fromCurrency:=
				//$ie.toAmount:=
				//$ie.toAmountLC:=
				//$ie.toCurrency:=
				$ie.TransactionType:=$re.TransactionType
				
				//$ie.isEFT:=
				//$ie.isLCt:=
				//$ie.isSuspicious:=
				
				$status:=$ie.save()
				
				If ($status.success=False:C215)
					$status.statusText:=$status.statusText+" || Failed to save invoices record."
				End if 
			End if 
		End if 
		
		
		// ----- CREATE CUSTOMER IF NEEDED -------
		
		If ($status.success)  // now check to see if we need to create an invoice
			If (ds:C1482.Customers.query("CustomerID == :1"; $trans.flex_customer_id).length=0)  // already created NO NEED
				$ce:=ds:C1482.Customers.new()
				$ce.CustomerID:=$re.CustomerID
				
				$ce.FirstName:=$trans.first_name
				$ce.LastName:=$trans.last_name
				$ce.FullName:=$trans.full_name
				
				$ce.Address:=$trans.address
				$ce.CountryCode:=$trans.country_code
				
				
				Case of 
					: ($trans.type_of_customer="I")  //individual
						$ce.isCompany:=False:C215
						
					: ($trans.type_of_customer="B")  //bank
						$ce.isCompany:=True:C214
						
					: ($trans.type_of_customer="C")  //company
						$ce.isCompany:=True:C214
						
				End case 
				
				If ($ce.isCompany)
					$ce.BusinessIncorporatedInCountry:=$trans.incorporationcountry
					$ce.BusinessIncorporationDate:=Date:C102($trans.incorporationdate)
				Else 
					$ce.Occupation:=$trans.occupation
					$ce.DOB:=Date:C102($trans.dob)
					$ce.Gender:=$trans.gender
					$ce.CountryOfBirthCode:=$trans.countryofbirthcode
					$ce.Nationality:=$trans.nationality
				End if 
				
				
				$ce.approvalStatus:=Num:C11(getKeyValue("cab.customer.new.approvalstatus"; "0"))  //-9999. // since we are now creating don't need the web service to update???"
				$status:=$ce.save()
				
				If ($status.success=False:C215)
					$status.statusText:=$status.statusText+" || Failed to save CUSTOMER record."
				End if 
			End if 
		End if 
		
		
		
		// ---- SAVE THE REGISTER TRANSACTION ------
		If ($status.success)
			$status:=$re.save()
			If ($status.success=False:C215)
				$status.statusText:=$status.statusText+" || Failed to save registers record."
			End if 
		End if 
		
	Else 
		$status.success:=True:C214
		$status.status:=0
		return ($status)
		//$status.statusText:="Customer ID is NOT defined."
	End if 
	
Else 
	// json did not validate
	$status.success:=False:C215
	$status.status:=-9010
	$status.statusText:="JSON did NOT validate."
End if 

If ($status.success=False:C215)  // add the record id
	$status.statusText:=$status.statusText+"||"+$trans.transaction_id
End if 

