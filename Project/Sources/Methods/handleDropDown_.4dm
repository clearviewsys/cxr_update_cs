//%attributes = {}
// handleDropDown_subAccount (->boundVar/self; ->boundField; ->originTable; ->originField;  accountID;{boolean:refresh})

C_POINTER:C301($self_DDArray; $boundFieldPtr; $originalTablePtr; $originalFieldPtr; $1; $2; $3; $4)
C_LONGINT:C283($formEvent; $5)  // to relaod the values into the DropDown array (force refresh)

C_LONGINT:C283($index; $i)
C_TEXT:C284($selection; $accountID)

Case of 
	: (Count parameters:C259=4)
		$self_DDArray:=$1
		$boundFieldPtr:=$2
		$originalTablePtr:=$3
		$originalFieldPtr:=$4
		$formEvent:=Form event code:C388
		
	: (Count parameters:C259=5)  // 
		$self_DDArray:=$1
		$boundFieldPtr:=$2
		$originalTablePtr:=$3
		$originalFieldPtr:=$4
		$formEvent:=$5
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

Case of 
		
	: ($FormEvent=On Load:K2:1)  // load the combo box array with transaction types
		
		READ ONLY:C145($originalTablePtr->)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		
		QUERY:C277($originalTablePtr->; [SubAccounts:112]AccountID:4=$accountID; *)
		QUERY:C277($originalTablePtr->;  | ; [SubAccounts:112]AccountID:4="")  // sub accounts
		ORDER BY:C49($originalTablePtr->; [SubAccounts:112]SubAccountID:2)  // order by name
		
		SELECTION TO ARRAY:C260([SubAccounts:112]SubAccountID:2; $self_DDArray->)
		INSERT IN ARRAY:C227($self_DDArray->; 1)  // the first item should be empty if empty is allowed
		$self_DDArray->{1}:=""
		
		// initially the dropdown should have the original value of the boundField
		$i:=Find in array:C230($self_DDArray->; $boundFieldPtr->)
		If ($i#-1)  // found in array
			$self_DDArray->:=$i
		Else 
			$self_DDArray->:=1  // select the first item (empty row) 
		End if 
		
	: (($formEvent=On Data Change:K2:15) | ($formEvent=On Clicked:K2:4) | ($formEvent=On Validate:K2:3))
		// after the combo box has been selected, assign the field to the new value    
		$index:=$self_DDArray->
		$selection:=$self_DDArray->{$index}
		$boundFieldPtr->:=$selection  // update the value of the bound variable
End case 