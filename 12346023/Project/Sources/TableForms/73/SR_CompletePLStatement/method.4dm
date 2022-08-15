C_POINTER:C301(branchDropDownPtr)
C_LONGINT:C283($formEvent)

$formEvent:=Form event code:C388
Case of 
	: ($formEvent=On Load:K2:1)
		ARRAY TEXT:C222(arrProfitLossTitles; 0)
		ARRAY TEXT:C222(arrProfitLossSubtitles; 0)
		ARRAY REAL:C219(arrProfitLossValues; 0)
		
		//from these arrays, only arrStylesPtr is used for styling
		ARRAY TEXT:C222(arrColNames; 0)
		ARRAY TEXT:C222(arrHeaderNames; 0)
		ARRAY POINTER:C280(arrColVars; 0)
		ARRAY POINTER:C280(arrHeaderVars; 0)
		ARRAY BOOLEAN:C223(arrColsVisible; 0)
		ARRAY POINTER:C280(arrStylesPtr; 0)
		ARRAY TEXT:C222(arrFooterNames; 0)
		ARRAY POINTER:C280(arrFooterVars; 0)
		LISTBOX GET ARRAYS:C832(*; "PLSummaryListBox"; arrColNames; arrHeaderNames; arrColVars; arrHeaderVars; arrColsVisible; arrStylesPtr; arrFooterNames; arrFooterVars)
		//-------------- year selection-------------
		branchDropDownPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "branchCombobox")
		//ARRAY INTEGER(yearSelectionValues;0)
		ARRAY TEXT:C222(branchSelectionValues; 0)
		//fillArrWithRegisterYearRange (->yearSelectionValues)
		//----------------branch selection------------
		branchDropDownPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "branchCombobox")
		ARRAY TEXT:C222(arrBranches; 0)
		ARRAY TEXT:C222(branchSelectionValues; 0)
		handlePopupSelectRecordsByBrID(->arrBranches; ->[Invoices:5]; ->[Invoices:5]BranchID:53; CBQUERYSELECTION)
		If (Size of array:C274(arrBranches)>1)
			COPY ARRAY:C226(arrBranches; branchSelectionValues)
		Else 
			ARRAY TEXT:C222(branchSelectionValues; 0)
		End if 
		
End case 