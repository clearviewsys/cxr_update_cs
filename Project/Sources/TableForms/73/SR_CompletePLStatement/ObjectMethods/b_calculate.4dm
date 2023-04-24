//refresh button object method for complete Profit and Loss statement
//author: Amir
//9th Jan 2019

C_POINTER:C301($summaryListBoxPtr)
$summaryListBoxPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "PLSummaryListBox")
C_LONGINT:C283($listboxRowIndex)
C_LONGINT:C283($TITLE_ROW_BG_COLOR; $TITLE_ROW_FONT_COLOR; $SUBTOTAL_ROW_BG_COLOR)
C_LONGINT:C283($progressID)
C_LONGINT:C283($BG_COLOR_INDEX; FONT_COLOR_INDEX; $ROW_STYLE_INDEX)
C_LONGINT:C283($REVENUE_ACCOUNT_TYPE)
C_LONGINT:C283($ERROR_FONT_COLOR; $WARNING_ROW_COLOR; $FONT_COLOR_INDEX)
$TITLE_ROW_BG_COLOR:=0x003C5E9A
$TITLE_ROW_FONT_COLOR:=0x00FFFFFF
$ERROR_FONT_COLOR:=0x00FF0000
$WARNING_ROW_COLOR:=0x00F7A210
$SUBTOTAL_ROW_BG_COLOR:=0x00D3DDEE
$ROW_STYLE_INDEX:=1  //these indices are determined from LISTBOX GET ARRAYS function
$FONT_COLOR_INDEX:=2
$BG_COLOR_INDEX:=3
$REVENUE_ACCOUNT_TYPE:=4

listbox_deleteAllRows($summaryListBoxPtr)
//----------------------------------------
//--------INCOME SECTION (PART A)
//----------------------------------------
//-------------trading income
$progressID:=launchProgressBar("Calculating trading incomes")
$listboxRowIndex:=listbox_appendRow($summaryListBoxPtr)
arrProfitLossTitles{$listboxRowIndex}:="INCOME"

arrStylesPtr{$BG_COLOR_INDEX}->{$listboxRowIndex}:=$TITLE_ROW_BG_COLOR
arrStylesPtr{$FONT_COLOR_INDEX}->{$listboxRowIndex}:=$TITLE_ROW_FONT_COLOR
arrStylesPtr{$ROW_STYLE_INDEX}->{$listboxRowIndex}:=Bold:K14:2

$listboxRowIndex:=listbox_appendRow($summaryListBoxPtr)
arrProfitLossTitles{$listboxRowIndex}:="Trading Income"
arrStylesPtr{$ROW_STYLE_INDEX}->{$listboxRowIndex}:=Bold:K14:2
ARRAY TEXT:C222($tempPLTitleNames; 0)  //contains temp values for titles of rows
ARRAY REAL:C219($tempPLCalculatedValues; 0)  //contains temp values for values of rows
C_DATE:C307($startDate; $endDate)
$startDate:=vFromDate
$endDate:=vToDate
calculatePLTradingIncomes(->$tempPLTitleNames; ->$tempPLCalculatedValues; $startDate; $endDate; branchSelectionValues{branchDropDownPtr->})
C_LONGINT:C283($i; $numRecords)
C_REAL:C285($totalTradingIncome)
$numRecords:=Size of array:C274($tempPLTitleNames)
For ($i; 1; $numRecords)
	$listboxRowIndex:=listbox_appendRow($summaryListBoxPtr)
	arrProfitLossTitles{$listboxRowIndex}:=$tempPLTitleNames{$i}
	arrProfitLossValues{$listboxRowIndex}:=$tempPLCalculatedValues{$i}
	$totalTradingIncome:=$totalTradingIncome+$tempPLCalculatedValues{$i}
	
End for 
$listboxRowIndex:=listbox_appendRow($summaryListBoxPtr)
arrProfitLossTitles{$listboxRowIndex}:="Total Trading Income $"
arrProfitLossValues{$listboxRowIndex}:=$totalTradingIncome
arrStylesPtr{$ROW_STYLE_INDEX}->{$listboxRowIndex}:=Bold:K14:2

//-------------operating income
refreshProgressBar($progressID; 1; 4)
setProgressBarTitle($progressID; "Calculating operating income")

$listboxRowIndex:=listbox_appendRow($summaryListBoxPtr)  //inserting an empty line
$listboxRowIndex:=listbox_appendRow($summaryListBoxPtr)
arrProfitLossTitles{$listboxRowIndex}:="Operating Income"
arrStylesPtr{$ROW_STYLE_INDEX}->{$listboxRowIndex}:=Bold:K14:2

ARRAY TEXT:C222($tempPLTitleNames; 0)  //contains names of account names (for revenue account type which is $REVENUE_ACCOUNT_TYPE)
ARRAY REAL:C219($tempPLCalculatedValues; 0)  //contains calculated values for those accounts
calculateIncomeByAccountType(->$tempPLTitleNames; ->$tempPLCalculatedValues; $REVENUE_ACCOUNT_TYPE; $startDate; $endDate; branchSelectionValues{branchDropDownPtr->})
$numRecords:=Size of array:C274($tempPLTitleNames)
C_REAL:C285($totalOperatingIncome)
For ($i; 1; $numRecords)
	$listboxRowIndex:=listbox_appendRow($summaryListBoxPtr)
	arrProfitLossTitles{$listboxRowIndex}:=$tempPLTitleNames{$i}
	arrProfitLossValues{$listboxRowIndex}:=$tempPLCalculatedValues{$i}
	$totalOperatingIncome:=$totalOperatingIncome+$tempPLCalculatedValues{$i}
	
End for 
$listboxRowIndex:=listbox_appendRow($summaryListBoxPtr)
arrProfitLossTitles{$listboxRowIndex}:="Total Operating Income $"
arrProfitLossValues{$listboxRowIndex}:=$totalOperatingIncome
arrStylesPtr{$ROW_STYLE_INDEX}->{$listboxRowIndex}:=Bold:K14:2

$listboxRowIndex:=listbox_appendRow($summaryListBoxPtr)  //inserting an empty line
$listboxRowIndex:=listbox_appendRow($summaryListBoxPtr)
arrProfitLossTitles{$listboxRowIndex}:="TOTAL INCOME"
C_REAL:C285($totalIncome)
$totalIncome:=$totalOperatingIncome+$totalTradingIncome
arrProfitLossValues{$listboxRowIndex}:=$totalIncome
arrStylesPtr{$ROW_STYLE_INDEX}->{$listboxRowIndex}:=Bold:K14:2
arrStylesPtr{$BG_COLOR_INDEX}->{$listboxRowIndex}:=$SUBTOTAL_ROW_BG_COLOR
$listboxRowIndex:=listbox_appendRow($summaryListBoxPtr)  //inserting empty line

//----------------------------------------
//--------COGS (PART B) Costs of goods sold
//----------------------------------------
refreshProgressBar($progressID; 2; 4)
setProgressBarTitle($progressID; "Calculating cost of goods sold")

$listboxRowIndex:=listbox_appendRow($summaryListBoxPtr)
arrProfitLossTitles{$listboxRowIndex}:="COGS"
arrStylesPtr{$BG_COLOR_INDEX}->{$listboxRowIndex}:=$TITLE_ROW_BG_COLOR
arrStylesPtr{$FONT_COLOR_INDEX}->{$listboxRowIndex}:=$TITLE_ROW_FONT_COLOR
arrStylesPtr{$ROW_STYLE_INDEX}->{$listboxRowIndex}:=Bold:K14:2

$listboxRowIndex:=listbox_appendRow($summaryListBoxPtr)
arrProfitLossTitles{$listboxRowIndex}:="Cost of Goods Sold"
arrStylesPtr{$ROW_STYLE_INDEX}->{$listboxRowIndex}:=Bold:K14:2

C_BOOLEAN:C305($successCogs)
C_TEXT:C284($statusMessage)

ARRAY TEXT:C222($tempPLTitleNames; 0)
ARRAY REAL:C219($tempPLCalculatedValues; 0)

$successCogs:=calculateAnnualCostOfGoodsSold($startDate; $endDate; branchSelectionValues{branchDropDownPtr->}; ->$tempPLTitleNames; ->$tempPLCalculatedValues; ->$statusMessage)
If ($successCogs#True:C214)  //error preventing part B from showing values
	$listboxRowIndex:=listbox_appendRow($summaryListBoxPtr)
	arrProfitLossTitles{$listboxRowIndex}:=$statusMessage
	arrStylesPtr{$ROW_STYLE_INDEX}->{$listboxRowIndex}:=Bold:K14:2
	arrStylesPtr{$FONT_COLOR_INDEX}->{$listboxRowIndex}:=$ERROR_FONT_COLOR
Else 
	If ($statusMessage#"")
		$listboxRowIndex:=listbox_appendRow($summaryListBoxPtr)
		myAlert("Did not find rates for following currencies: "+$statusMessage)
		arrProfitLossTitles{$listboxRowIndex}:="Could not find rates for some currencies"
		arrStylesPtr{$ROW_STYLE_INDEX}->{$listboxRowIndex}:=Bold:K14:2
		arrStylesPtr{$FONT_COLOR_INDEX}->{$listboxRowIndex}:=$WARNING_ROW_COLOR
	End if 
	$numRecords:=Size of array:C274($tempPLTitleNames)
	C_REAL:C285($totalCogs)
	For ($i; 1; $numRecords)
		$listboxRowIndex:=listbox_appendRow($summaryListBoxPtr)
		arrProfitLossTitles{$listboxRowIndex}:=$tempPLTitleNames{$i}
		arrProfitLossValues{$listboxRowIndex}:=$tempPLCalculatedValues{$i}
		$totalCogs:=$totalCogs+$tempPLCalculatedValues{$i}
	End for 
	
	$listboxRowIndex:=listbox_appendRow($summaryListBoxPtr)
	arrProfitLossTitles{$listboxRowIndex}:="Total Cost of Goods Sold"
	arrProfitLossValues{$listboxRowIndex}:=$totalCogs
	arrStylesPtr{$ROW_STYLE_INDEX}->{$listboxRowIndex}:=Bold:K14:2
	
	$listboxRowIndex:=listbox_appendRow($summaryListBoxPtr)  //inserting empty line
	$listboxRowIndex:=listbox_appendRow($summaryListBoxPtr)
	arrProfitLossTitles{$listboxRowIndex}:="GROSS PROFIT"
	arrProfitLossValues{$listboxRowIndex}:=$totalIncome-$totalCogs
	
	arrStylesPtr{$ROW_STYLE_INDEX}->{$listboxRowIndex}:=Bold:K14:2
	arrStylesPtr{$BG_COLOR_INDEX}->{$listboxRowIndex}:=$SUBTOTAL_ROW_BG_COLOR
End if 

//----------------------------------------
//--------Expenses (part C)
//---------------------------------------- 
$listboxRowIndex:=listbox_appendRow($summaryListBoxPtr)  //inserting empty line
$listboxRowIndex:=listbox_appendRow($summaryListBoxPtr)
arrProfitLossTitles{$listboxRowIndex}:="EXPENSES"
arrStylesPtr{$BG_COLOR_INDEX}->{$listboxRowIndex}:=$TITLE_ROW_BG_COLOR
arrStylesPtr{$FONT_COLOR_INDEX}->{$listboxRowIndex}:=$TITLE_ROW_FONT_COLOR
arrStylesPtr{$ROW_STYLE_INDEX}->{$listboxRowIndex}:=Bold:K14:2

$listboxRowIndex:=listbox_appendRow($summaryListBoxPtr)
arrProfitLossTitles{$listboxRowIndex}:="Operating Expenses"
arrStylesPtr{$ROW_STYLE_INDEX}->{$listboxRowIndex}:=Bold:K14:2

refreshProgressBar($progressID; 3; 4)
setProgressBarTitle($progressID; "Calculating expenses")

ARRAY TEXT:C222($tempPLTitleNames; 0)
ARRAY REAL:C219($tempPLCalculatedValues; 0)
C_LONGINT:C283($EXPENSE_ACCOUNT_TYPE)
$EXPENSE_ACCOUNT_TYPE:=5
calculateAccountSummaryByType(->$tempPLTitleNames; ->$tempPLCalculatedValues; $startDate; $endDate; branchSelectionValues{branchDropDownPtr->}; $EXPENSE_ACCOUNT_TYPE; "Branch")
C_REAL:C285($totalExpenses)
$numRecords:=Size of array:C274($tempPLTitleNames)
For ($i; 1; $numRecords)
	$listboxRowIndex:=listbox_appendRow($summaryListBoxPtr)
	arrProfitLossTitles{$listboxRowIndex}:=$tempPLTitleNames{$i}
	arrProfitLossValues{$listboxRowIndex}:=$tempPLCalculatedValues{$i}
	$totalExpenses:=$totalExpenses+$tempPLCalculatedValues{$i}
End for 

$listboxRowIndex:=listbox_appendRow($summaryListBoxPtr)  //inserting empty line
$listboxRowIndex:=listbox_appendRow($summaryListBoxPtr)

arrProfitLossTitles{$listboxRowIndex}:="TOTAL EXPENSES"
arrProfitLossValues{$listboxRowIndex}:=$totalExpenses

arrStylesPtr{$ROW_STYLE_INDEX}->{$listboxRowIndex}:=Bold:K14:2
arrStylesPtr{$BG_COLOR_INDEX}->{$listboxRowIndex}:=$SUBTOTAL_ROW_BG_COLOR

//----------------------------------------
//--------Net income: Gross Profit - Total Expenses 
//----------------------------------------
If ($successCogs=True:C214)
	C_REAL:C285($netIncome)
	$netIncome:=$totalIncome-$totalCogs-$totalExpenses
	$listboxRowIndex:=listbox_appendRow($summaryListBoxPtr)  //inserting empty line
	$listboxRowIndex:=listbox_appendRow($summaryListBoxPtr)
	
	arrProfitLossTitles{$listboxRowIndex}:="NET INCOME"
	arrProfitLossValues{$listboxRowIndex}:=$netIncome
	
	arrStylesPtr{$ROW_STYLE_INDEX}->{$listboxRowIndex}:=Bold:K14:2
	arrStylesPtr{$BG_COLOR_INDEX}->{$listboxRowIndex}:=$SUBTOTAL_ROW_BG_COLOR
End if 
refreshProgressBar($progressID; 4; 4)

HIDE PROCESS:C324($progressID)
