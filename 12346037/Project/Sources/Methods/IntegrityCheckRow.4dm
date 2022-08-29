//%attributes = {}
// integrityCheckRow (integritycheckstring) -> success
// this is a long procedure to perform all integrity checks on a record


C_TEXT:C284($1; $checkType)
C_BOOLEAN:C305($success; $0)
$success:=True:C214
$checkType:=$1

Case of 
	: ($checkType="IC_unbalancedInvoices")  // invoice balance
		C_REAL:C285(vSumDebits; vSumCredits)
		RELATE MANY:C262([Invoices:5]InvoiceID:1)  // load the registers
		vSumDebits:=Sum:C1([Registers:10]CreditLocal:24)
		vSumCredits:=Sum:C1([Registers:10]DebitLocal:23)
		If (vSumCredits#vSumDebits)
			$success:=False:C215
		End if 
		
	: ($checkType="IC_accountCurrencies")
		RELATE ONE:C42([Registers:10]AccountID:6)
		If ([Registers:10]Currency:19#[Accounts:9]Currency:6)
			$success:=False:C215
		End if 
		
	: ($checkType="IC_InvoiceCustomers")
		RELATE ONE:C42([Registers:10]InvoiceNumber:10)
		If ([Registers:10]CustomerID:5#[Invoices:5]CustomerID:2)
			$success:=False:C215
		End if 
		
	: ($checkType="IC_RegisterRates")
		If (([Registers:10]SpotRate:26>0) & (isRateOffRange([Registers:10]SpotRate:26; [Registers:10]OurRate:25)))
			$success:=False:C215
		End if 
		
	: ($checkType="IC_invalidMainAccounts")
		RELATE ONE:C42([Accounts:9]MainAccountID:2)
		If (Records in selection:C76([MainAccounts:28])=0)
			$success:=False:C215
		End if 
		
	: ($checkType="IC_chequeAccounts")
		queryRegistersByID([Cheques:1]RegisterID:6)
		If ([Cheques:1]AccountID:7#[Registers:10]AccountID:6)
			$success:=False:C215
		End if 
		
	: ($checkType="IC_chequeCurrencies")
		RELATE ONE:C42([Cheques:1]AccountID:7)
		If ([Cheques:1]Currency:9#[Accounts:9]Currency:6)
			$success:=False:C215
		End if 
		
	: ($checkType="IC_linkagents")
		RELATE ONE:C42([Links:17]AuthorizedUser:13)
		If (Records in selection:C76([WebUsers:14])=0)
			$success:=False:C215
		Else   // web user exist, now check if webuser is an authorized agent 
			QUERY:C277([Agents:22]; [Agents:22]AgentID:1=[WebUsers:14]webUsername:1)
			If (Records in selection:C76([Agents:22])=0)
				$success:=False:C215
			End if 
		End if 
		
	: ($checkType="IC_EWireInvoiceID")
		READ ONLY:C145([eWires:13])
		QUERY:C277([eWires:13]; [eWires:13]eWireID:1=[Registers:10]InternalRecordID:18)  // select the ewires
		LOAD RECORD:C52([eWires:13])
		If ([Registers:10]InvoiceNumber:10#[eWires:13]InvoiceNumber:29)
			$success:=False:C215
		End if 
		
	: ($checkType="IC_eWireAccounts")
		READ ONLY:C145([eWires:13])
		QUERY:C277([eWires:13]; [eWires:13]eWireID:1=[Registers:10]InternalRecordID:18)  // select the ewires
		LOAD RECORD:C52([eWires:13])
		If ([Registers:10]AccountID:6#[eWires:13]AccountID:30)
			$success:=False:C215
		End if 
	: ($checkType="IC_eWireCustomerID")
		RELATE ONE:C42([eWires:13]LinkID:8)
		If ([eWires:13]CustomerID:15#[Links:17]CustomerID:14)
			$success:=False:C215
		End if 
		
	: ($checkType="IC_InvalidAccounts")
		RELATE ONE:C42([Registers:10]AccountID:6)
		If (Records in selection:C76([Accounts:9])#1)
			$success:=False:C215
		End if 
		
	: ($checkType="IC_OrphanRegisters")
		RELATE ONE:C42([Registers:10]InvoiceNumber:10)
		If (Records in selection:C76([Invoices:5])#1)
			$success:=False:C215
		End if 
		
	Else 
		
End case 

$0:=$success