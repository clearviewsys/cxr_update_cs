//%attributes = {}
C_LONGINT:C283($i; $n)
READ ONLY:C145([eWires:13])

If (Form event code:C388=On Load:K2:1)
	//ARRAY TEXT(ewr_arrAccountID;0)
	//ARRAY TEXT(ewr_arrAccountTypes;0)
	//ARRAY TEXT(ewr_arrCurrencies;0)
	//ARRAY TEXT(ewr_arrMainAccounts;0)
	//ARRAY REAL(ewr_arrMarketRates;0)
	//ARRAY PICTURE(ewr_arrIsFlagged;0)
	ewr_initeWiresListBox
End if 

$n:=Records in selection:C76([eWires:13])
FIRST RECORD:C50([eWires:13])
ORDER BY:C49([eWires:13]; [eWires:13]eWireID:1)
listbox_deleteAllRows(->ewr_eWiresListBox)
For ($i; 1; $n)
	listbox_appendRow(->ewr_eWiresListBox)
	ewr_filleWiresListBoxRow($i)
	NEXT RECORD:C51([eWires:13])
End for 