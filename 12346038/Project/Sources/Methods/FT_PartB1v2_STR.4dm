//%attributes = {}


// ------------------------------------------------------------------------------
// Method: FT_PartB1v2_STR: Information about transaction.
// 
// Part B1: Information about transaction
// This part is for information about the transaction(s)that led you to the suspicion of a connection to 
// money laundering or terrorist f.
// Provide details about how the transaction was initiated(i.e., where the money came from).
// Details about how the transaction was completed(i.e., where the money went)go in Part B2.
// In the case of an attempted transaction, this would include information about ho.
// Your suspicion could be based on a series of transactions. 
// In that case, include in this report the information for each transaction that led to the suspicion.
// -----------------------------------------------------------------------------------------------------------  // 
// Parameters: 
//   see above
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 5/5/2020
// ------------------------------------------------------------------------------

// createPartB1

C_TEXT:C284($1; $filename)
C_POINTER:C301($2; $arrPtr)
C_LONGINT:C283($3; $seq)
C_BOOLEAN:C305($4; $isrelatedIran)


Case of 
		
	: (Count parameters:C259=4)
		
		$fileName:=$1
		$arrPtr:=$2
		$seq:=$3
		$isrelatedIran:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


If ($seq<=Size of array:C274($arrPtr->))
	
	QUERY:C277([Registers:10]; [Registers:10]RegisterID:1=$arrPtr->{$seq})
	
	If ([Registers:10]RegisterType:4="Buy")
		//FT_PartB1 ($fileName;"B1";$seq;FT_GetStringDate ([Registers]CreationDate);FT_GetStringTime ([Registers]CreationTime);"0";FT_GetStringDate ([Registers]CreationDate);AmountToSpotRate ([Registers]Debit);[Registers]Currency;"A";" ")
		FT_PartB1_STR($fileName; "B1"; $seq; FT_GetStringDate([Registers:10]CreationDate:14); FT_GetStringTime([Registers:10]CreationTime:15); "0"; FT_GetStringDate([Registers:10]CreationDate:14); [Registers:10]Debit:8; [Registers:10]Currency:19; "A"; " "; [Registers:10]CreatedByUserID:16; $isrelatedIran)
	Else 
		//FT_PartB1 ($fileName;"B1";$seq;FT_GetStringDate ([Registers]CreationDate);FT_GetStringTime ([Registers]CreationTime);"0";FT_GetStringDate ([Registers]CreationDate);AmountToSpotRate ([Registers]Credit);[Registers]Currency;"A";" ")
		FT_PartB1_STR($fileName; "B1"; $seq; FT_GetStringDate([Registers:10]CreationDate:14); FT_GetStringTime([Registers:10]CreationTime:15); "0"; FT_GetStringDate([Registers:10]CreationDate:14); [Registers:10]Credit:7; [Registers:10]Currency:19; "A"; " "; [Registers:10]CreatedByUserID:16; $isrelatedIran)
	End if 
	
End if 

APPEND TO ARRAY:C911(arrFTRegisterID; [Registers:10]RegisterID:1)

