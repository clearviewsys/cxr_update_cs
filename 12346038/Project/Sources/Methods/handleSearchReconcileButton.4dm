//%attributes = {}
C_LONGINT:C283($i)
C_BOOLEAN:C305($condition)
C_TEXT:C284(vLookFor)
For ($i; 1; Size of array:C274(arrDates))
	$condition:=(arrDebits{$i}=Num:C11(vLookFor)) & (cbSearchDeposits=1)
	$condition:=$condition | ((arrCredits{$i}=Num:C11(vLookFor)) & (cbSearchWithdrawals=1))
	$condition:=$condition | ((cbSearchComments=1) & ((arrDates{$i}=Date:C102(vLookFor)) | (arrInvoiceNumbers{$i}=vLookFor) | (Position:C15(vLookFor; arrComments{$i})>0)))
	reconcileList{$i}:=False:C215
	
	//If (arrChecked{$i}=False)
	If (arrChecked{$i}=False:C215)  // definitely check the ones that satisfy condition and have not been checkmarked
		If ($condition)
			reconcileList{$i}:=True:C214
			OBJECT SET SCROLL POSITION:C906(reconcileList; $i; *)
		End if 
	Else   // if the row is already checkmarked, then double check if the 'also search checkmarked' has been selected
		If ($condition & (cbSearchCheckmarked=1))
			reconcileList{$i}:=True:C214
			OBJECT SET SCROLL POSITION:C906(reconcileList; $i; *)
			
		End if 
	End if 
	//End if 
End for 
If (Find in array:C230(reconcileList; True:C214)=0)  // couldn't find anything
	GOTO OBJECT:C206(*; "lookFor")
	BEEP:C151
Else 
	GOTO OBJECT:C206(*; "reconcileList")
End if 

//for($j;1;5)
//If (Find in array(reconcileList;True)=0)  ` couldn't find anything
//For ($i;1;Size of array(arrDates)-$j)
//If ((arrChecked{$i}=False) & (arrChecket{$i+1}=false))
//If ((arrDebits{$i}=vLookFor) | (arrCredits{$i}=vLookFor))
//reconcileList{$i}:=True
//Else 
//reconcileList{$i}:=False
//End if 
//End if 
//End for 
//
//End if 
//end for