//%attributes = {}
// getMarchType ($sanctionCheckResult): 
// Get if the result is an exact, partial or not has a match


C_TEXT:C284($1; $sanctionCheckResult)
C_BOOLEAN:C305($2; $isExactMath)
C_LONGINT:C283($0)

Case of 
	: (Count parameters:C259=1)
		$sanctionCheckResult:=$1
		$isExactMath:=False:C215
		
	: (Count parameters:C259=2)
		$sanctionCheckResult:=$1
		$isExactMath:=$2
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


If ($isExactMath=False:C215)
	// Partial result
	Case of 
			
		: (Position:C15("Error. Could not connect"; $sanctionCheckResult)>0)
			$0:=-1
			
		: (Position:C15("No Exact Match!"; $sanctionCheckResult)>0)
			$0:=1
			
		: (Position:C15("Limit"; $sanctionCheckResult)>0)
			$0:=0
			
		: ($sanctionCheckResult#"")
			$0:=2
			
		: ($sanctionCheckResult="")
			$0:=0
			
	End case 
	
	
End if 
