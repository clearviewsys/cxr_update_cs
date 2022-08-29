//%attributes = {}
//author: Jonna
//date: 21 OCt 2019
//used for customer transaction first and last
//assumes [Customers] already has the desired selection 
//Check_CustomersFirstLastTrans(
//    ->listBox;->arrCustomerIDandNames;->arrTransactionTypes;
//   ->arrTotalBuys;->arrTotalSells;
//    ->arrAverageBuys;->arrAverageSells;
//    ->arrBuyQuantities;->arrSellQuantities
//)

C_POINTER:C301($1; $listboxPtr)
C_POINTER:C301($2; $arrCustomerIdPtr; $3; $arrCustNamePtr)
C_POINTER:C301($4; $arrFirstTransDatePtr; $5; $arrLastTransDatePtr)
C_POINTER:C301($6; $arrTotalTransPtr; $7; $arrTransVolumePtr)
ASSERT:C1129(Count parameters:C259=7; "Expected 7 parameters")


$listboxPtr:=$1
$arrCustomerIdPtr:=$2
$arrCustNamePtr:=$3
$arrFirstTransDatePtr:=$4
$arrLastTransDatePtr:=$5
$arrTotalTransPtr:=$6
$arrTransVolumePtr:=$7


C_LONGINT:C283($numCustomers; $listBoxIndex)
DISTINCT VALUES:C339([Customers:3]CustomerID:1; $arrCustomerID)
$numCustomers:=Size of array:C274($arrCustomerID)
C_LONGINT:C283($customerIndex)
$customerIndex:=1

C_LONGINT:C283($registerTypeIndex)
If ($numCustomers>0)  //if there is any customer for the given date range
	C_LONGINT:C283($progress)
	$progress:=launchProgressBar("Customer transaction statistics")
	CREATE SET:C116([Registers:10]; "registerSelection")
	
	Repeat 
		QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$arrCustomerID{$customerIndex})
		USE SET:C118("registerSelection")
		QUERY SELECTION:C341([Registers:10]; [Registers:10]CustomerID:5=[Customers:3]CustomerID:1)
		
		$listBoxIndex:=listbox_appendRow($listboxPtr)
		$arrCustomerIdPtr->{$listBoxIndex}:=[Customers:3]CustomerID:1
		$arrCustNamePtr->{$listBoxIndex}:=[Customers:3]FullName:40
		ORDER BY:C49([Registers:10]; [Registers:10]RegisterDate:2; >)
		$arrFirstTransDatePtr->{$listBoxIndex}:=[Registers:10]RegisterDate:2
		ORDER BY:C49([Registers:10]; [Registers:10]RegisterDate:2; <)
		$arrLastTransDatePtr->{$listBoxIndex}:=[Registers:10]RegisterDate:2
		$arrTotalTransPtr->{$listBoxIndex}:=Records in selection:C76([Registers:10])
		$arrTransVolumePtr->{$listBoxIndex}:=Sum:C1([Registers:10]DebitLocal:23)
		
		If ($customerIndex%5=1)
			refreshProgressBar($progress; $customerIndex; $numCustomers)
			setProgressBarTitle($progress; "Customer "+[Customers:3]CustomerID:1)
		End if 
		//NEXT RECORD([Customers])
		$customerIndex:=$customerIndex+1
	Until (($customerIndex>$numCustomers) | isProgressBarStopped($progress))
	HIDE PROCESS:C324($progress)
	CLEAR SET:C117("registerSelection")
End if 