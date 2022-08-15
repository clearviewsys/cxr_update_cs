//%attributes = {}
// sanctionListResult

C_TEXT:C284($0)


Case of 
		
	: ([SanctionCheckLog:111]isSuccessful:7=False:C215)
		$0:="Name could not be checked."
		
	: ([SanctionCheckLog:111]CheckResult:10=1)
		$0:="Similar Name found"
		
	: ([SanctionCheckLog:111]CheckResult:10=2)
		$0:="Positive Match"
		
	: ([SanctionCheckLog:111]CheckResult:10=0)
		$0:=""
		
End case 

