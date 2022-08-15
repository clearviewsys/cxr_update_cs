//%attributes = {}
//author: Amir
//date: 14th Sept 2018
//used for customer transaction statistics report
//assumes [Customers] already has the desired selection 
//calcCustmrTransactStats(
//    ->listBox;->arrCustomerIDandNames;->arrTransactionTypes;
//    ->arrDescriptions;->arrTotalBuys;->arrTotalSells;
//    ->arrAverageBuys;->arrAverageSells;
//    ->arrBuyQuantities;->arrSellQuantities
//)
//calculates the transaction statistics for customers in selection
//for registers of type (InternalTableNumber) Cash, Account, Wire, and eWire
//from begining of time, last year, last 3 months, and last month
//calculates total, average and quantity for buy and sell registers.
C_POINTER:C301($1; $listboxPtr)
C_POINTER:C301($2; $arrCustomerIDandNamesPtr; $3; $arrTransTypesPtr)
C_POINTER:C301($4; $arrDescriptionsPtr; $5; $arrTotalBuysPtr)
C_POINTER:C301($6; $arrTotalSellsPtr; $7; $arrAverageBuysPtr)
C_POINTER:C301($8; $arrAverageSellsPtr; $9; $arrBuyQuantitiesPtr; $10; $arrSellQuantitiesPtr)
ASSERT:C1129(Count parameters:C259=10; "Expected 10 parameters")

$listboxPtr:=$1
$arrCustomerIDandNamesPtr:=$2
$arrTransTypesPtr:=$3
$arrDescriptionsPtr:=$4
$arrTotalBuysPtr:=$5
$arrTotalSellsPtr:=$6
$arrAverageBuysPtr:=$7
$arrAverageSellsPtr:=$8
$arrBuyQuantitiesPtr:=$9
$arrSellQuantitiesPtr:=$10


C_DATE:C307(vFromDate; vToDate)
C_TEXT:C284(vBranchID)
//finding the relevant dates
C_DATE:C307($now; fromLastMonth; toLastMonth; $fromLast3Months; $fromLastYear)
$now:=Current date:C33
getDateRange_LastMonth(->fromLastMonth; ->toLastMonth)
$fromLast3Months:=Add to date:C393($now; 0; -3; 0)
$fromLastYear:=Add to date:C393($now; 0; -12; 0)
//finding the types of registers
C_LONGINT:C283($cashType; $accountType; $wireType; $eWireType)
$cashType:=Table:C252(->[CashInOuts:32])
$accountType:=Table:C252(->[AccountInOuts:37])
$wireType:=Table:C252(->[Wires:8])
$eWireType:=Table:C252(->[eWires:13])

//parallel arrays used for register types
ARRAY LONGINT:C221($arrRegisterTypes; 4)
$arrRegisterTypes{1}:=$cashType
$arrRegisterTypes{2}:=$accountType
$arrRegisterTypes{3}:=$wireType
$arrRegisterTypes{4}:=$eWireType
ARRAY TEXT:C222($arrRegisterTypeNames; 4)
$arrRegisterTypeNames{1}:="Cash"
$arrRegisterTypeNames{2}:="Account"
$arrRegisterTypeNames{3}:="Wire"
$arrRegisterTypeNames{4}:="eWire"

//parallel arrays used for time periods
ARRAY DATE:C224($arrDates; 4)
$arrDates{1}:=!00-00-00!
$arrDates{2}:=$fromLastYear
$arrDates{3}:=$fromLast3Months
$arrDates{4}:=fromLastMonth
ARRAY TEXT:C222($arrDateNames; 4)
$arrDateNames{1}:="Total"
$arrDateNames{2}:="Last year"
$arrDateNames{3}:="Last 3 months"
$arrDateNames{4}:="Last month"

C_LONGINT:C283($numCustomers; $listBoxIndex)
$numCustomers:=Records in selection:C76([Customers:3])
C_LONGINT:C283($customerIndex)
$customerIndex:=1
//calculate statistics for each customer:
//for each different register types which are: cash, account, wire, ewire
//calculate row values for total (from beginning of time), last year, last 3 months, last month
C_LONGINT:C283($registerTypeIndex; $dateIndex)
If ($numCustomers>0)  //if there is any customer for the given date range
	C_LONGINT:C283($progress)
	$progress:=launchProgressBar("Customer transaction statistics")
	Repeat 
		If (vBranchID#"")
			QUERY:C277([Registers:10]; [Registers:10]BranchID:39=vBranchID)
		Else 
			ALL RECORDS:C47([Registers:10])
		End if 
		QUERY SELECTION:C341([Registers:10]; [Registers:10]CustomerID:5=[Customers:3]CustomerID:1)
		CREATE SET:C116([Registers:10]; "registersForGivenCustomer")
		
		For ($registerTypeIndex; 1; Size of array:C274($arrRegisterTypes))  //cash, account, wire, ewire
			USE SET:C118("registersForGivenCustomer")
			QUERY SELECTION:C341([Registers:10]; [Registers:10]InternalTableNumber:17=$arrRegisterTypes{$registerTypeIndex})
			
			For ($dateIndex; 1; Size of array:C274($arrDates))  //total, last year, last 3 months, last month
				QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2>=$arrDates{$dateIndex})
				$listBoxIndex:=listbox_appendRow($listboxPtr)
				$arrCustomerIDandNamesPtr->{$listBoxIndex}:=[Customers:3]CustomerID:1+" : "+[Customers:3]FullName:40
				$arrTransTypesPtr->{$listBoxIndex}:=$arrRegisterTypeNames{$registerTypeIndex}
				$arrDescriptionsPtr->{$listBoxIndex}:=$arrDateNames{$dateIndex}
				$arrTotalBuysPtr->{$listBoxIndex}:=Sum:C1([Registers:10]DebitLocal:23)
				$arrTotalSellsPtr->{$listBoxIndex}:=Sum:C1([Registers:10]CreditLocal:24)
				
				CREATE SET:C116([Registers:10]; "registersForGivenCustTypeDate")
				QUERY SELECTION:C341([Registers:10]; [Registers:10]Debit:8>0)  //buy registers
				//order of queries is important here; for taking average, we need to remove 0 values
				$arrAverageBuysPtr->{$listBoxIndex}:=Average:C2([Registers:10]DebitLocal:23)
				$arrBuyQuantitiesPtr->{$listBoxIndex}:=Records in selection:C76([Registers:10])
				USE SET:C118("registersForGivenCustTypeDate")
				QUERY SELECTION:C341([Registers:10]; [Registers:10]Credit:7>0)  //sell registers
				$arrAverageSellsPtr->{$listBoxIndex}:=Average:C2([Registers:10]CreditLocal:24)
				$arrSellQuantitiesPtr->{$listBoxIndex}:=Records in selection:C76([Registers:10])
				CLEAR SET:C117("registersForGivenCustTypeDate")
			End for 
		End for 
		CLEAR SET:C117("registersForGivenCustomer")
		If ($customerIndex%5=1)
			refreshProgressBar($progress; $customerIndex; $numCustomers)
			setProgressBarTitle($progress; "Customer "+[Customers:3]CustomerID:1)
		End if 
		NEXT RECORD:C51([Customers:3])
		$customerIndex:=$customerIndex+1
	Until (($customerIndex>$numCustomers) | isProgressBarStopped($progress))
	HIDE PROCESS:C324($progress)
End if 