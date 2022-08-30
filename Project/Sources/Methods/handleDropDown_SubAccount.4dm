//%attributes = {}
// handleDropDown_subAccount (->boundVar/self; ->boundField;  accountID;{boolean:refresh})

C_POINTER:C301($self_DDArray; $boundFieldPtr; $originalTablePtr; $originalFieldPtr; $1; $2)
C_TEXT:C284($accountID; $3)
C_LONGINT:C283($index; $i)
C_TEXT:C284($selection)
C_BOOLEAN:C305($refresh; $4)  // to relaod the values into the DropDown array (force refresh)
$originalTablePtr:=->[SubAccounts:112]
$originalFieldPtr:=->[SubAccounts:112]SubAccountID:2

Case of 
		
	: (Count parameters:C259=3)
		$self_DDArray:=$1
		$boundFieldPtr:=$2
		$accountID:=$3
		$refresh:=False:C215
		
	: (Count parameters:C259=4)  // 
		$self_DDArray:=$1
		$boundFieldPtr:=$2
		$accountID:=$3
		$refresh:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

Case of 
		
	: ((Form event code:C388=On Load:K2:1) | ($refresh))  // load the combo box array with transaction types
		
		READ ONLY:C145($originalTablePtr->)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		
		SET QUERY LIMIT:C395(<>QUERYLIMIT)  // limit the query
		//QUERY($originalTablePtr->;$originalFieldPtr->=$accountID;*)
		//QUERY($originalTablePtr->; | ;$originalFieldPtr->="")  // sub accounts
		QUERY:C277($originalTablePtr->; [SubAccounts:112]AccountID:4=$accountID; *)
		QUERY:C277($originalTablePtr->;  | ; [SubAccounts:112]AccountID:4="")  // sub accounts
		ORDER BY:C49($originalTablePtr->; [SubAccounts:112]SubAccountID:2)  // order by name
		
		SET QUERY LIMIT:C395(0)
		
		SELECTION TO ARRAY:C260($originalFieldPtr->; $self_DDArray->)
		INSERT IN ARRAY:C227($self_DDArray->; 1)  // the first item should be empty if empty is allowed
		$self_DDArray->{1}:=""
		
		$i:=Find in array:C230($self_DDArray->; $boundFieldPtr->)
		If ($i#-1)  // found in array
			$self_DDArray->:=$i
		Else 
			$self_DDArray->:=1  // select the first item (empty row) 
		End if 
		
	: ((Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Validate:K2:3))
		// after the combo box has been selected, assign the field to the new value    
		$index:=$self_DDArray->
		$selection:=$self_DDArray->{$index}
		$boundFieldPtr->:=$selection  // update the value of the bound variable
End case 