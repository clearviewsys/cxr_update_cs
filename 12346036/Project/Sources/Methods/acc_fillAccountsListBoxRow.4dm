//%attributes = {}
// acc_fillAccountsListBoxRow (row)
C_LONGINT:C283($i; $1)
C_BOOLEAN:C305($isManager; $2)

Case of 
	: (Count parameters:C259=1)
		$i:=$1
		$isManager:=isUserManager
		
	: (Count parameters:C259=2)
		$i:=$1
		$isManager:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_DATE:C307(vFromDate; vToDate)
C_LONGINT:C283(cbApplyDateRange)


If (False:C215)  // for compiler's sake)
	ARRAY TEXT:C222(acc_arrAccountIDs; 0)
	ARRAY TEXT:C222(acc_arrAccountTypes; 0)
	ARRAY TEXT:C222(acc_arrCurrencies; 0)
	ARRAY TEXT:C222(acc_arrMainAccounts; 0)
	ARRAY REAL:C219(acc_arrTransfers; 0)
	ARRAY REAL:C219(acc_arrOpenings; 0)
	ARRAY REAL:C219(acc_arrIns; 0)
	ARRAY REAL:C219(acc_arrOuts; 0)
	ARRAY REAL:C219(acc_arrBalances; 0)
	ARRAY REAL:C219(acc_arrDebits; 0)
	ARRAY REAL:C219(acc_arrCredits; 0)
	ARRAY REAL:C219(acc_arrFees; 0)
	ARRAY REAL:C219(acc_arrUnrealizedGains; 0)
	
	ARRAY REAL:C219(acc_arrMarketRates; 0)
	ARRAY REAL:C219(acc_arrMarketRatesInv; 0)
	
	ARRAY REAL:C219(acc_arrMarketValues; 0)
	
	ARRAY PICTURE:C279(acc_arrIsFlagged; 0)
	ARRAY REAL:C219(acc_arrReorderIn; 0)
	
End if 


RELATE ONE:C42([Accounts:9]MainAccountID:2)
RELATE ONE:C42([Accounts:9]Currency:6)
C_REAL:C285(vTransferIn; vTransferOut)

If (isUserAllowedToViewThisAccount($isManager))  // if account is for managers only but the user is not administrator then don't show the balances
	If (([Accounts:9]Type:36=5) | ([Accounts:9]Type:36=4))  // revenue & expense account should be treated differently
		C_REAL:C285($temp)
		getAccountBalanceInDateRange([Accounts:9]AccountID:1; vFromDate; vToDate; numToBoolean(cbApplyDateRange); ->$temp; ->vTransferIn; ->vTransferOut; ->acc_arrIns{$i}; ->acc_arrOuts{$i}; ->$temp; ->acc_arrDebits{$i}; ->acc_arrCredits{$i}; ->acc_arrFees{$i}; ->acc_arrUnrealizedGains{$i}; vBranchID)
		acc_arrBalances{$i}:=acc_arrDebits{$i}-acc_arrCredits{$i}
	Else 
		getAccountBalanceInDateRange([Accounts:9]AccountID:1; vFromDate; vToDate; numToBoolean(cbApplyDateRange); ->acc_arrOpenings{$i}; ->vTransferIn; ->vTransferOut; ->acc_arrIns{$i}; ->acc_arrOuts{$i}; ->acc_arrBalances{$i}; ->acc_arrDebits{$i}; ->acc_arrCredits{$i}; ->acc_arrFees{$i}; ->acc_arrUnrealizedGains{$i}; vBranchID)
	End if 
	If ([Accounts:9]minInventoryLevel:31>0)
		acc_arrReorderIn{$i}:=acc_arrBalances{$i}-[Accounts:9]minInventoryLevel:31
	End if 
	
	acc_arrMarketRates{$i}:=[Currencies:6]SpotRateLocal:17
	acc_arrMarketRatesInv{$i}:=calcSafeDivide(1; acc_arrMarketRates{$i})
	acc_arrTransfers{$i}:=vTransferIn-vTransferOut
	
End if 

acc_arrAccountIDs{$i}:=[Accounts:9]AccountID:1
//acc_arrAccountTypes{$i}:=[Accounts]AccountType
acc_arrMainAccounts{$i}:=[Accounts:9]MainAccountID:2
acc_arrCurrencies{$i}:=[Accounts:9]Currency:6

If ([Accounts:9]isForeignAccount:15)
	loadPictureResource("minAgent"; ->acc_arrIsFlagged{$i})
	//GET PICTURE FROM LIBRARY("miniAgent"; acc_arrIsFlagged{$i})
End if 

If ([Accounts:9]isFlagged:13)
	loadPictureResource("Flag"; ->acc_arrIsFlagged{$i})
	//GET PICTURE FROM LIBRARY("Flag"; acc_arrIsFlagged{$i})
End if 
acc_RecalcAccountListBoxRow($i)