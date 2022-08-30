//%attributes = {}
// getAccountTypeNumber ( string ) -> number


C_LONGINT:C283($0; $i)
C_TEXT:C284($1)
$0:=0
ARRAY TEXT:C222($arrAccountTypes; 5)
LIST TO ARRAY:C288("AccountTypes"; $arrAccountTypes)
For ($i; 1; Size of array:C274($arrAccountTypes))
	If ($arrAccountTypes{$i}=$1)
		$0:=$i
	End if 
End for 
ARRAY TEXT:C222($arrAccountTypes; 5)
