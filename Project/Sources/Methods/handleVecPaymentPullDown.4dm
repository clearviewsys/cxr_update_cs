//%attributes = {}
// handleVecPaymentPullDown (self; {1:Cash, 2:Account, 


C_POINTER:C301($1; $self)
C_LONGINT:C283($2)

$self:=$1
C_TEXT:C284($method)

C_TEXT:C284(vCustomerID)
ARRAY TEXT:C222(vecPaymentMethod; 6)

If (Count parameters:C259=2)
	vecPaymentMethod:=$2
End if 

$method:=vecPaymentMethod{vecPaymentMethod}

INV_vNextAccountID:=""  //added 6/8/22 @ibb
INV_vNextAccountCode:=""

READ ONLY:C145([Accounts:9])

Case of 
	: ($method=c_Account)
		ARRAY TEXT:C222(vecAccounts; 0)
		QUERY:C277([Accounts:9]; [Accounts:9]isPaymentMethod:19=True:C214; *)
		QUERY:C277([Accounts:9];  | ; [Accounts:9]CustomerID:20=vCustomerID)  // add the accounts that belong to the user to the list
		If (vCustomerID=getWalkInCustomerID)  // if customer is walkin then do not show accounts that are not available to walkins
			QUERY SELECTION:C341([Accounts:9]; [Accounts:9]doPreventWalkins:35=False:C215)
		End if 
		
		// Modified 05/17/21 @milan
		// Pravin asked to use existing MoneyGram account, not new ones
		//If (vReceivedOrPaid=getReceivedOrPayString (2))
		//QUERY SELECTION([Accounts];[Accounts]AccountCode#"MGR")
		//Else 
		//If (vReceivedOrPaid=getReceivedOrPayString (1))
		//QUERY SELECTION([Accounts];[Accounts]AccountCode#"MGS")
		//Else 
		//QUERY SELECTION([Accounts];[Accounts]AccountCode#"MGR")
		//QUERY SELECTION([Accounts];[Accounts]AccountCode#"MGS")
		//End if 
		//End if 
		
		If (Records in selection:C76([Accounts:9])>0)  // there is a list to pick from
			OBJECT SET VISIBLE:C603(vecAccounts; True:C214)
			orderByAccountNames
			
			SELECTION TO ARRAY:C260([Accounts:9]AccountID:1; vecAccounts)
			INSERT IN ARRAY:C227(vecAccounts; 1; 1)
			vecAccounts{1}:="Pick an account..."
			vecAccounts:=1
		Else 
			OBJECT SET VISIBLE:C603(vecAccounts; False:C215)
			vecAccounts:=0
		End if 
		postTabOnWindows
		
		
	: (($method=c_Cheque) | ($method=c_Wire))
		ARRAY TEXT:C222(vecAccounts; 0)
		QUERY:C277([Accounts:9]; [Accounts:9]isBankAccount:7=True:C214)
		//query and isPaymentMethod = true `<--- @Tiran should we do this? per LondonCurrency
		If (vCustomerID=getWalkInCustomerID)  // if customer is walkin then do not show accounts that are not available to walkins
			QUERY SELECTION:C341([Accounts:9]; [Accounts:9]doPreventWalkins:35=False:C215)
		End if 
		
		If (Records in selection:C76([Accounts:9])>0)  // there is a list to pick from
			OBJECT SET VISIBLE:C603(vecAccounts; True:C214)
			orderByAccountNames
			SELECTION TO ARRAY:C260([Accounts:9]AccountID:1; vecAccounts)
			INSERT IN ARRAY:C227(vecAccounts; 1; 1)
			vecAccounts{1}:="Pick a bank..."
			vecAccounts:=1
		Else 
			OBJECT SET VISIBLE:C603(vecAccounts; False:C215)
			vecAccounts:=0
		End if 
		postTabOnWindows
		
		
	: ($method=c_eWire)
		ARRAY TEXT:C222(vecAccounts; 0)
		QUERY:C277([Accounts:9]; [Accounts:9]isForeignAccount:15=True:C214)
		//QUERY([Accounts]; & ;[Accounts]isSettlementAccount=True)  // for now only show settlement accounts
		If (Records in selection:C76([Accounts:9])>0)  // there is a list to pick from
			OBJECT SET VISIBLE:C603(vecAccounts; True:C214)
			orderByAccountNames
			SELECTION TO ARRAY:C260([Accounts:9]AccountID:1; vecAccounts)
			INSERT IN ARRAY:C227(vecAccounts; 1; 1)
			vecAccounts{1}:="Pick an agent account..."
			vecAccounts:=1
		Else 
			OBJECT SET VISIBLE:C603(vecAccounts; False:C215)
			vecAccounts:=0
		End if 
		
		
	: ($method=c_Items)
		If (vAmount=0)
			vAmount:=1
		End if 
		
		postTabOnWindows
		
	Else 
		vecAccounts:=0
		ARRAY TEXT:C222(vecAccounts; 0)
		OBJECT SET VISIBLE:C603(vecAccounts; False:C215)
End case 

REDUCE SELECTION:C351([Accounts:9]; 0)  // 6/8/22 @ibb