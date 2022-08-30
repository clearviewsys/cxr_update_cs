//%attributes = {}
// handleDropDown_customerLinks (->boundVar or self; ->boundField; customerID)

C_POINTER:C301($self; $fieldPtr; $1; $2)
C_TEXT:C284($customerID; $3)
C_LONGINT:C283($index)
C_TEXT:C284($selection; $delim)
$delim:=" : "
Case of 
	: (Count parameters:C259=3)
		$self:=$1
		$fieldPtr:=$2
		$customerID:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

Case of 
		
	: (Form event code:C388=On Load:K2:1)  // load the combo box array with transaction types
		READ ONLY:C145([Links:17])
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		SET QUERY LIMIT:C395(<>QUERYLIMIT)  // limit the query
		QUERY:C277([Links:17]; [Links:17]CustomerID:14=$customerID; *)
		QUERY:C277([Links:17];  | ; [Links:17]CustomerID:14="")
		ORDER BY:C49([Links:17]; [Links:17]FullName:4)  // order by Trans Type
		C_LONGINT:C283($i; $n)
		$n:=Records in selection:C76([Links:17])
		FIRST RECORD:C50([Links:17])
		APPEND TO ARRAY:C911($self->; "")
		For ($i; 1; $n)
			LOAD RECORD:C52([Links:17])
			APPEND TO ARRAY:C911($self->; [Links:17]LinkID:1+$delim+[Links:17]FullName:4)
			NEXT RECORD:C51([Links:17])
		End for 
		SET QUERY LIMIT:C395(0)
		
	: ((Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Validate:K2:3))
		// after the combo box has been selected, assign the field to the new value    
		$index:=$self->
		$selection:=$self->{$index}
		$selection:=Substring:C12($selection; 1; Position:C15($delim; $selection)-1)
		$fieldPtr->:=$selection
End case 