//%attributes = {}
//author: Amir Deris
//date: 7th Feb 2019
//this method is used for PART B (Cost of goods sold) of total profit and loss report
//calculateAnnualCostOfGoodsSold(
//$startDate: start of period
//$endDate: end of period
//$branch: the branch filter
//$arrTitlesPtr: a pointer to array to insert titles of rows (account and sub account IDs)
//$arrValuesPtr: a pointer to array to insert values of rows (cost of goods sold)
//$statusMessagePtr: a message to return such as missed currencies, or error message
//)

//calculate openning inventory:
//get all accounts
//for each account
//query registers for each account and regDate before $startDate
//SUM([Debit])-SUM(Credit) is opening inventory for each currency. 
//Evaluate it with first day of the year's rate (to local currency)
//add values

C_BOOLEAN:C305($0)  //status to return
C_DATE:C307($startDate; $1; $endDate; $2)
C_TEXT:C284($branch; $3)
C_POINTER:C301($arrTitlesPtr; $4)
C_POINTER:C301($arrValuesPtr; $5)
C_POINTER:C301($statusMessagePtr; $6)
C_DATE:C307($startDate; $endDate)

$startDate:=$1
$endDate:=$2
$branch:=$3
$arrTitlesPtr:=$4
$arrValuesPtr:=$5
$statusMessagePtr:=$6
ASSERT:C1129(Count parameters:C259=6; "Expected six parameters")


//getting currency rates at begining and end of year
ARRAY TEXT:C222(arrCurrencyCodesYearStart; 0)
ARRAY REAL:C219(arrCurrencyRatesYearStart; 0)
ARRAY TEXT:C222(arrCurrencyCodesYearEnd; 0)
ARRAY REAL:C219(arrCurrencyRatesYearEnd; 0)
C_BOOLEAN:C305($successStart; $successEnd)

$successStart:=getCurrencyRatesAtDate($startDate; ->arrCurrencyCodesYearStart; ->arrCurrencyRatesYearStart)
$successEnd:=getCurrencyRatesAtDate($endDate; ->arrCurrencyCodesYearEnd; ->arrCurrencyRatesYearEnd)

Case of 
	: (($successStart#True:C214) | (Size of array:C274(arrCurrencyRatesYearStart)=0))
		$statusMessagePtr->:="Could not download rates at "+String:C10($startDate)
		$0:=False:C215
	: (($successEnd#True:C214) | (Size of array:C274(arrCurrencyRatesYearEnd)=0))
		$statusMessagePtr->:="Could not download rates at "+String:C10($endDate)
		$0:=False:C215
	Else 
		$0:=True:C214
		READ ONLY:C145([Accounts:9])
		READ ONLY:C145([Registers:10])
		//----------
		//finding relevant accounts
		QUERY:C277([Accounts:9]; [Accounts:9]Type:36=1)  //asset (goods) accounts
		RELATE MANY SELECTION:C340([Registers:10]AccountID:6)
		
		QUERY SELECTION:C341([Registers:10]; [Registers:10]isCancelled:59=False:C215)
		QUERY SELECTION:C341([Registers:10]; [Registers:10]Debit:8#0; *)
		QUERY SELECTION:C341([Registers:10];  | ; [Registers:10]Credit:7#0)
		If ($branch#"Branch")
			QUERY SELECTION:C341([Registers:10]; [Registers:10]BranchID:39=$branch)
		End if 
		QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2<=$endDate)  //[0,B]
		
		CREATE SET:C116([Registers:10]; "validRegisters")
		
		
		ORDER BY:C49([Accounts:9]; [Accounts:9]AccountID:1; >)
		
		C_LONGINT:C283($accountIndex)
		C_REAL:C285($openingInventory; $openingInventoryLocal)
		C_REAL:C285($closingInventory; $closingInventoryLocal)
		C_REAL:C285($periodSumLocal; $periodSum; $periodPurchases; $periodPurchasesLocal)
		C_REAL:C285($costOfGoodsSold)
		C_BOOLEAN:C305($errorFindingCurrency)
		C_LONGINT:C283($currencyIndex)
		
		FIRST RECORD:C50([Accounts:9])
		For ($accountIndex; 1; Records in selection:C76([Accounts:9]))
			USE SET:C118("validRegisters")
			QUERY SELECTION:C341([Registers:10]; [Registers:10]AccountID:6=[Accounts:9]AccountID:1)
			
			$errorFindingCurrency:=False:C215
			//-------closing inventory for account
			
			$closingInventory:=Sum:C1([Registers:10]Debit:8)-Sum:C1([Registers:10]Credit:7)
			$currencyIndex:=-1
			$currencyIndex:=Find in array:C230(arrCurrencyCodesYearEnd; [Accounts:9]Currency:6)
			If ($currencyIndex#-1)
				$closingInventoryLocal:=$closingInventory*arrCurrencyRatesYearEnd{$currencyIndex}
			Else 
				$statusMessagePtr->:=$statusMessagePtr->+String:C10([Accounts:9]Currency:6)+", "
				$errorFindingCurrency:=True:C214
			End if 
			
			If (Not:C34($errorFindingCurrency))  //ignore if currency not found before
				//---------period sum for account
				QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2>=$startDate)  //[A,B]
				$periodSumLocal:=Sum:C1([Registers:10]DebitLocal:23)-Sum:C1([Registers:10]CreditLocal:24)
				$periodSum:=Sum:C1([Registers:10]Debit:8)-Sum:C1([Registers:10]Credit:7)
				$periodPurchases:=Sum:C1([Registers:10]Debit:8)
				$periodPurchasesLocal:=Sum:C1([Registers:10]DebitLocal:23)
				//-------opening inventory for account
				$openingInventory:=$closingInventory-$periodSum  //[0,A)
				$currencyIndex:=-1
				$currencyIndex:=Find in array:C230(arrCurrencyCodesYearStart; [Accounts:9]Currency:6)
				If ($currencyIndex#-1)
					$openingInventoryLocal:=$openingInventory*arrCurrencyRatesYearStart{$currencyIndex}
				Else 
					$errorFindingCurrency:=True:C214
				End if 
				
			End if 
			
			$costOfGoodsSold:=$openingInventoryLocal+$periodPurchasesLocal-$closingInventoryLocal
			If (isUserAllowedToViewThisAccount & Not:C34($errorFindingCurrency))
				//insert in list box
				APPEND TO ARRAY:C911($arrTitlesPtr->; [Accounts:9]AccountID:1)
				APPEND TO ARRAY:C911($arrValuesPtr->; $costOfGoodsSold)
			End if 
			
			
			NEXT RECORD:C51([Accounts:9])
			
		End for 
		
		ARRAY TEXT:C222(arrCurrencyCodesYearStart; 0)
		ARRAY REAL:C219(arrCurrencyRatesYearStart; 0)
		ARRAY TEXT:C222(arrCurrencyCodesYearEnd; 0)
		ARRAY REAL:C219(arrCurrencyRatesYearEnd; 0)
		CLEAR SET:C117("validRegisters")
		
End case 