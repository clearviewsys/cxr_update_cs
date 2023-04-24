C_TEXT:C284($webURL)

READ ONLY:C145([Branches:70])
ARRAY TEXT:C222(arrBranches; 0)
ARRAY REAL:C219(arrUnrealizedGains; 0)
C_DATE:C307($date)
C_TEXT:C284($branchID)

$date:=Date:C102(Request:C163("Enter the date:"; String:C10(Current date:C33); "Fetch"; "Cancel"))

If (OK=1)
	allRecordsBranches
	
	C_LONGINT:C283($i; $n)
	$n:=Records in selection:C76([Branches:70])
	
	If ($n>0)
		SELECTION TO ARRAY:C260([Branches:70]BranchID:1; arrBranches)
		SELECTION TO ARRAY:C260([Branches:70]BranchName:2; arrBranchNames)
		ARRAY REAL:C219(arrUnrealizedGains; $n)  // resize the array
		
		For ($i; 1; $n)  // iterate through the branches (vertically) ; for each branch iterate through the accounts (rows)
			
			
			GOTO SELECTED RECORD:C245([Branches:70]; $i)
			$branchID:=[Branches:70]BranchID:1
			$webURL:=[Branches:70]WebServerURL:9
			arrUnrealizedGains{$i}:=Round:C94(ws_getBranchUnrealizedGain($date; $webURL); 2)
			
		End for 
	End if 
End if 