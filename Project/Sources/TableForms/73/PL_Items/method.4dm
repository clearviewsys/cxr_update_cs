If (Form event code:C388=On Load:K2:1)
	OBJECT SET TITLE:C194(*; "tax1Header"; <>TAX1NAME)
	OBJECT SET TITLE:C194(*; "tax1Header1"; <>TAX1NAME)
	OBJECT SET TITLE:C194(*; "tax2Header"; <>TAX2NAME)
	OBJECT SET TITLE:C194(*; "tax2Header2"; <>TAX2NAME)
End if 

If (Form event code:C388=On Outside Call:K2:11)
	PLItems_fillSummaryRows(vFromDate; vToDate; vBranchID)
End if 

If (Form event code:C388=On Unload:K2:2)
	PL_initListBoxDetailArrays
	PL_initListBoxSummaryArrays
	ARRAY TEXT:C222(arrItemInOutIds; 0)
	ARRAY REAL:C219(arrSummaryShortRates; 0)
	ARRAY REAL:C219(arrTax1; 0)
	ARRAY REAL:C219(arrTax2; 0)
	ARRAY REAL:C219(arrSummaryTax1; 0)
	ARRAY REAL:C219(arrSummaryTax2; 0)
End if 
