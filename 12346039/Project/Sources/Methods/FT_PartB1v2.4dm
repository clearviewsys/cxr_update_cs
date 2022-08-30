//%attributes = {}
// ------------------------------------------------------------------------------
// Method: FT_PartB1v2: Information about transaction.
// This part is for information about the large cash transaction.
// If the large cash transaction was two or more cash transactions of less than 
// $10,000 made within 24 consecutive hours of each other that total $10,000 or more, 
// include those in the same report. 
//
// If there are more than 99 such transactions that make up a large cash transaction, 
// you will have to use more than one report.
// 
// Parameters: 
//   see above
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 12/10/2015
// ------------------------------------------------------------------------------

// createPartB1

C_TEXT:C284($1; $filename)
C_POINTER:C301($2; $arrPtr)
C_LONGINT:C283($3; $seq; $4; $b1Counter)

Case of 
		
	: (Count parameters:C259=4)
		
		$fileName:=$1
		$arrPtr:=$2
		$seq:=$3
		$b1Counter:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_REAL:C285($amount)
C_TEXT:C284($quickDropInd)
C_BOOLEAN:C305($isRelatedIran)


If ($seq<=Size of array:C274($arrPtr->))
	
	
	QUERY:C277([Registers:10]; [Registers:10]RegisterID:1=$arrPtr->{$seq})
	$quickDropInd:="0"
	
	If ([Registers:10]RegisterType:4="Buy")
		$amount:=AmountToSpotRate([Registers:10]DebitLocal:23)
		FT_PartB1($fileName; "B1"; $b1Counter; FT_GetStringDate([Registers:10]CreationDate:14); FT_GetStringTime([Registers:10]CreationTime:15); $quickDropInd; FT_GetStringDate([Registers:10]CreationDate:14); [Registers:10]Debit:8; [Registers:10]Currency:19; "A"; " ")
	Else 
		$amount:=AmountToSpotRate([Registers:10]CreditLocal:24)
		FT_PartB1($fileName; "B1"; $b1Counter; FT_GetStringDate([Registers:10]CreationDate:14); FT_GetStringTime([Registers:10]CreationTime:15); $quickDropInd; FT_GetStringDate([Registers:10]CreationDate:14); [Registers:10]Credit:7; [Registers:10]Currency:19; "A"; " ")
	End if 
	
	
	If ($amount<[ServerPrefs:27]twoIDsLimit:15)
		underThreshold:=True:C214
	End if 
	
End if 

APPEND TO ARRAY:C911(arrFTRegisterID; [Registers:10]RegisterID:1)


