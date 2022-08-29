//%attributes = {}

// ----------------------------------------------------
// User name (OS): Tiran Behrouz
// Date and time: 01/12/16, 17:22:11
// ----------------------------------------------------
// Method: handleFillUserTransSumTable
// Description
// This method populates a screen report (table) with user transactions summary called from the form page
//
// Parameters
// $1: username
// $2: 
// ----------------------------------------------------


C_TEXT:C284($1; $username)
C_BOOLEAN:C305($isCancelled)


C_DATE:C307(vFromDate; vToDate; $fromDate; $toDate; $date)
C_TEXT:C284($user; vBranchID; $branchID; $curr)

C_LONGINT:C283($i; $n; $d; $c; $u)

// init the listbox itself
ARRAY BOOLEAN:C223(holdingsListBox; 0)

// Init the listbox arrays first

ARRAY DATE:C224(arrDates; 0)
ARRAY TEXT:C222(arrCodes; 0)
ARRAY REAL:C219(arrIns; 0)
ARRAY REAL:C219(arrOuts; 0)
ARRAY LONGINT:C221(arrCountIns; 0)
ARRAY LONGINT:C221(arrCountOuts; 0)

ARRAY REAL:C219(arrCost; 0)
ARRAY REAL:C219(arrRevenues; 0)
ARRAY TEXT:C222(arrCurrencies; 0)
ARRAY TEXT:C222(arrUsers; 0)
ARRAY REAL:C219(arrAvgBuys; 0)
ARRAY REAL:C219(arrAvgSells; 0)

ARRAY REAL:C219(arrFees; 0)  //3/11/19 IBB

Case of 
	: (Count parameters:C259=0)
		If (vFromDate=!00-00-00!)
			$fromDate:=Current date:C33
		Else 
			$fromDate:=vFromDate
		End if 
		$toDate:=vToDate
		$date:=$fromDate
		$branchID:=vBranchID
		$isCancelled:=False:C215
End case 

If ($fromDate<=$toDate)
	$n:=($toDate-$fromDate)+1  // I think it needs to be one 
Else 
	$n:=0
End if 

ARRAY TEXT:C222($arrUsersPerDate; 0)
ARRAY TEXT:C222($arrCurrPerUser; 0)



For ($d; 1; $n)
	queryRegistersByDate($date; False:C215; $branchID)
	DISTINCT VALUES:C339([Registers:10]CreatedByUserID:16; $arrUsersPerDate)  // fill the users arrUsers with all the users for that date
	SORT ARRAY:C229($arrUsersPerDate)
	For ($u; 1; Size of array:C274($arrUsersPerDate))  // for each user find the currencies that he dealt with
		// search all registers for that data that user
		queryRegistersByDate($date; False:C215; $branchID)
		QUERY SELECTION:C341([Registers:10]; [Registers:10]CreatedByUserID:16=$arrUsersPerDate{$u})  // find all the registers for that user
		DISTINCT VALUES:C339([Registers:10]Currency:19; $arrCurrPerUser)
		SORT ARRAY:C229($arrCurrPerUser)
		
		C_LONGINT:C283($lastRow; $r)
		
		For ($c; 1; Size of array:C274($arrCurrPerUser))
			$lastRow:=Size of array:C274(holdingsListBox)+1
			LISTBOX INSERT ROWS:C913(holdingsListBox; $lastRow; 1)  // insert one row at the bottom of the list
			
			arrDates{$lastRow}:=$date
			arrUsers{$lastRow}:=$arrUsersPerDate{$u}
			arrCurrencies{$lastRow}:=$arrCurrPerUser{$c}
			
			$r:=$lastRow
			$user:=arrUsers{$r}
			$curr:=arrCurrencies{$r}
			
			getTranSumByDateUserCurr($branchID; $date; $user; $curr; $isCancelled; ->arrCountIns{$r}; ->arrIns{$r}; ->arrCost{$r}; ->arrCountOuts{$r}; ->arrOuts{$r}; ->arrRevenues{$r}; ->arrFees{$r})
			arrAvgBuys{$r}:=calcSafeDivide(arrCost{$r}; arrIns{$r})
			arrAvgSells{$r}:=calcSafeDivide(arrRevenues{$r}; arrOuts{$r})
			
			//arrFees{$r}:=0  //<>TODO IBB added 3/11/19
			
		End for 
		$r:=Size of array:C274(holdingsListBox)+1
		
		LISTBOX INSERT ROWS:C913(holdingsListBox; $r; 1)  // insert one row at the bottom of the list
		arrDates{$r}:=$date
		arrUsers{$r}:=$arrUsersPerDate{$u}
		arrCurrencies{$r}:="    Subtotal: "
		getTransSumByDateUser($branchID; $date; $user; $isCancelled; ->arrCountIns{$r}; ->arrCost{$r}; ->arrCountOuts{$r}; ->arrRevenues{$r}; ->arrFees{$r})
		
	End for 
	$date:=Add to date:C393($date; 0; 0; 1)  // add 1 day
	
End for 
