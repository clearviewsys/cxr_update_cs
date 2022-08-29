//%attributes = {}
// FT_partB2v2

C_TEXT:C284($1; $filename)
C_POINTER:C301($2; $arrPtr)
C_LONGINT:C283($3; $seq)

Case of 
		
	: (Count parameters:C259=3)
		
		$fileName:=$1
		$arrPtr:=$2
		$seq:=$3
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 



If ($seq<=Size of array:C274($arrPtr->))
	
	QUERY:C277([Registers:10]; [Registers:10]RegisterID:1=$arrPtr->{$seq})
	
	If ([Registers:10]RegisterType:4="Buy")
		//FT_GeneratePartB2 ($fileName;[Registers]Currency;AmountToSpotRate ([Registers]Debit);$seq)
		
		// Convert Toman to IRR if the Tx use that Currency
		If ([Registers:10]Currency:19=getKeyValue("TOMCode"; "TOM"))
			FT_GeneratePartB2($fileName; "IRR"; [Registers:10]Debit:8*10; $seq)  // 1 Toman = 10 IRR
		Else 
			FT_GeneratePartB2($fileName; [Registers:10]Currency:19; [Registers:10]Debit:8; $seq)
		End if 
		
	Else 
		//FT_GeneratePartB2 ($fileName;[Registers]Currency;AmountToSpotRate ([Registers]Credit);$seq)
		If ([Registers:10]Currency:19=getKeyValue("TOMCode"; "TOM"))
			FT_GeneratePartB2($fileName; "IRR"; [Registers:10]Credit:7*10; $seq)  // 1 Toman = 10 IRR
		Else 
			FT_GeneratePartB2($fileName; [Registers:10]Currency:19; [Registers:10]Credit:7; $seq)
		End if 
		
	End if 
	
Else 
	FT_GeneratePartB2($fileName; "CAD"; 0; $seq)
End if 


