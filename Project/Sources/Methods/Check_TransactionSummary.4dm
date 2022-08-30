//%attributes = {}
//Check_TransactionSummary(
//    ->listBox;->arrFullname;->arrTimePeriod;
//   ->arrTotalTrans;->arrTransVolume;
//    ->arrCustomerType;->$arrTransactionDesc)

C_POINTER:C301($1; $listboxPtr)
C_POINTER:C301($2; $arrTimePeriodPtr)
C_POINTER:C301($3; $arrTotalTransPtr; $4; $arrTransVolumePtr)
C_POINTER:C301($5; $arrCustomerTypePtr; $6; $arrTransactionDescPtr)
ASSERT:C1129(Count parameters:C259=6; "Expected 6 parameters")

$listboxPtr:=$1
$arrTimePeriodPtr:=$2
$arrTotalTransPtr:=$3
$arrTransVolumePtr:=$4
$arrCustomerTypePtr:=$5
$arrTransactionDescPtr:=$6

C_OBJECT:C1216($Registers; $oTransactions)
C_LONGINT:C283($listBoxIndex)
$Registers:=Create entity selection:C1512([Registers:10])

If ($Registers.length>0)
	C_LONGINT:C283($progress)
	$progress:=launchProgressBar("Customer transaction summary")
	
	// less than 50,000 SAR S&N
	$oTransactions:=$Registers.query("invoice.CustomerTypeID =:1 | invoice.CustomerTypeID =:2 & DebitLocal <=:3"; "S"; "N"; 50000)
	$oTransactions:=$oTransactions.query("customer.isWalkin =:1 & customer.isInsider =:2"; False:C215; False:C215)
	$listBoxIndex:=listbox_appendRow($listboxPtr)
	If ($oTransactions.length>0)
		$arrTimePeriodPtr->{$listBoxIndex}:=String:C10(vFromDate)+" to "+String:C10(vToDate)
		$arrTotalTransPtr->{$listBoxIndex}:=$oTransactions.sum("DebitLocal")
		$arrTransVolumePtr->{$listBoxIndex}:=$oTransactions.count("CustomerID")
	Else 
		$arrTimePeriodPtr->{$listBoxIndex}:=""
		$arrTotalTransPtr->{$listBoxIndex}:=0
		$arrTransVolumePtr->{$listBoxIndex}:=0
	End if 
	$arrCustomerTypePtr->{$listBoxIndex}:="Saudi & Non Saudi ( S & N )"
	$arrTransactionDescPtr->{$listBoxIndex}:="Less Than 5000 SAR"
	
	
	// From 5,001 to 100,000 S
	$oTransactions:=$Registers.query("invoice.CustomerTypeID =:1 & DebitLocal >=:2 & DebitLocal <=:3"; "S"; 5001; 100000)
	$oTransactions:=$oTransactions.query("customer.isWalkin =:1 & customer.isInsider =:2"; False:C215; False:C215)
	$listBoxIndex:=listbox_appendRow($listboxPtr)
	If ($oTransactions.length>0)
		$arrTimePeriodPtr->{$listBoxIndex}:=String:C10(vFromDate)+" to "+String:C10(vToDate)
		$arrTotalTransPtr->{$listBoxIndex}:=$oTransactions.sum("DebitLocal")
		$arrTransVolumePtr->{$listBoxIndex}:=$oTransactions.count("CustomerID")
	Else 
		$arrTimePeriodPtr->{$listBoxIndex}:=""
		$arrTotalTransPtr->{$listBoxIndex}:=0
		$arrTransVolumePtr->{$listBoxIndex}:=0
	End if 
	$arrCustomerTypePtr->{$listBoxIndex}:="Saudi"
	$arrTransactionDescPtr->{$listBoxIndex}:="From 5001 to 100 000 SAR"
	
	// From 5,001 to 50,000 N
	$oTransactions:=$Registers.query("invoice.CustomerTypeID =:1 & DebitLocal >=:2 & DebitLocal <=:3"; "N"; 5001; 50000)
	$oTransactions:=$oTransactions.query("customer.isWalkin =:1 & customer.isInsider =:2"; False:C215; False:C215)
	$listBoxIndex:=listbox_appendRow($listboxPtr)
	If ($oTransactions.length>0)
		$arrTimePeriodPtr->{$listBoxIndex}:=String:C10(vFromDate)+" to "+String:C10(vToDate)
		$arrTotalTransPtr->{$listBoxIndex}:=$oTransactions.sum("DebitLocal")
		$arrTransVolumePtr->{$listBoxIndex}:=$oTransactions.count("CustomerID")
	Else 
		$arrTimePeriodPtr->{$listBoxIndex}:=""
		$arrTotalTransPtr->{$listBoxIndex}:=0
		$arrTransVolumePtr->{$listBoxIndex}:=0
	End if 
	$arrCustomerTypePtr->{$listBoxIndex}:="Non Saudi"
	$arrTransactionDescPtr->{$listBoxIndex}:="From 5001 to 50 000 SAR"
	
	// more than 100,000 SAR S
	$oTransactions:=$Registers.query("invoice.CustomerTypeID =:1 & DebitLocal >:2"; "S"; 100000)
	$oTransactions:=$oTransactions.query("customer.isWalkin =:1 & customer.isInsider =:2"; False:C215; False:C215)
	$listBoxIndex:=listbox_appendRow($listboxPtr)
	If ($oTransactions.length>0)
		$arrTimePeriodPtr->{$listBoxIndex}:=String:C10(vFromDate)+" to "+String:C10(vToDate)
		$arrTotalTransPtr->{$listBoxIndex}:=$oTransactions.sum("DebitLocal")
		$arrTransVolumePtr->{$listBoxIndex}:=$oTransactions.count("CustomerID")
	Else 
		$arrTimePeriodPtr->{$listBoxIndex}:=""
		$arrTotalTransPtr->{$listBoxIndex}:=0
		$arrTransVolumePtr->{$listBoxIndex}:=0
	End if 
	$arrCustomerTypePtr->{$listBoxIndex}:="Saudi"
	$arrTransactionDescPtr->{$listBoxIndex}:="More Than 100 000 SAR "
	
	// more than 50,000 SAR N
	$oTransactions:=$Registers.query("invoice.CustomerTypeID =:1 & DebitLocal >=:2"; "N"; 50000)
	$oTransactions:=$oTransactions.query("customer.isWalkin =:1 & customer.isInsider =:2"; False:C215; False:C215)
	$listBoxIndex:=listbox_appendRow($listboxPtr)
	If ($oTransactions.length>0)
		$arrTimePeriodPtr->{$listBoxIndex}:=String:C10(vFromDate)+" to "+String:C10(vToDate)
		$arrTotalTransPtr->{$listBoxIndex}:=$oTransactions.sum("DebitLocal")
		$arrTransVolumePtr->{$listBoxIndex}:=$oTransactions.count("CustomerID")
	Else 
		$arrTimePeriodPtr->{$listBoxIndex}:=""
		$arrTotalTransPtr->{$listBoxIndex}:=0
		$arrTransVolumePtr->{$listBoxIndex}:=0
	End if 
	$arrCustomerTypePtr->{$listBoxIndex}:="Non Saudi"
	$arrTransactionDescPtr->{$listBoxIndex}:="More than 50 000 SAR "
	HIDE PROCESS:C324($progress)
End if 