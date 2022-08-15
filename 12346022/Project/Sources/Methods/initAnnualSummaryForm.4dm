//%attributes = {}
//author: Amir
//Date: 13th October 2018
//SR_AnnualSummary init form method (for onload event of the form)
ARRAY PICTURE:C279(arrFlags; 0)
ARRAY TEXT:C222(arrCurrencyCodes; 0)
ARRAY REAL:C219(arrJanValues; 0)
ARRAY REAL:C219(arrFebValues; 0)
ARRAY REAL:C219(arrMarValues; 0)
ARRAY REAL:C219(arrAprValues; 0)
ARRAY REAL:C219(arrMayValues; 0)
ARRAY REAL:C219(arrJunValues; 0)
ARRAY REAL:C219(arrJulValues; 0)
ARRAY REAL:C219(arrAugValues; 0)
ARRAY REAL:C219(arrSepValues; 0)
ARRAY REAL:C219(arrOctValues; 0)
ARRAY REAL:C219(arrNovValues; 0)
ARRAY REAL:C219(arrDecValues; 0)

ARRAY POINTER:C280(arrMonthArraysPtr; 12)  //array of pointers to month arrays; used in the loop when saving data
arrMonthArraysPtr{1}:=->arrJanValues
arrMonthArraysPtr{2}:=->arrFebValues
arrMonthArraysPtr{3}:=->arrMarValues

arrMonthArraysPtr{4}:=->arrAprValues
arrMonthArraysPtr{5}:=->arrMayValues
arrMonthArraysPtr{6}:=->arrJunValues

arrMonthArraysPtr{7}:=->arrJulValues
arrMonthArraysPtr{8}:=->arrAugValues
arrMonthArraysPtr{9}:=->arrSepValues

arrMonthArraysPtr{10}:=->arrOctValues
arrMonthArraysPtr{11}:=->arrNovValues
arrMonthArraysPtr{12}:=->arrDecValues

C_POINTER:C301(listboxPtr)
C_POINTER:C301(yearSelectionPtr)
C_POINTER:C301(branchSelectionPtr)
C_POINTER:C301(showBuyChkboxPtr)
C_POINTER:C301(showSellChkboxPtr)
C_POINTER:C301(localCurrencyChkboxPtr)
C_POINTER:C301(countRadButtonPtr)
C_POINTER:C301(volumeRadButtonPtr)
listboxPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "listboxAnnualSummary")
showBuyChkboxPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "showBuyChkbox")
showSellChkboxPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "showSellChkbox")
localCurrencyChkbox:=OBJECT Get pointer:C1124(Object named:K67:5; "localCurrencyChkbox")
countRadButtonPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "CountRadButton")
volumeRadButtonPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "VolumeRadButton")
//select volume by default
volumeRadButtonPtr->:=1
//select buy by default
showBuyChkboxPtr->:=1
//-------------- year selection-------------
yearSelectionPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "yearCombobox")
ARRAY INTEGER:C220(yearSelectionValues; 0)
fillArrWithRegisterYearRange(->yearSelectionValues)
//select current year by default
yearSelectionPtr->:=1

//---------------branch selection-------------
branchSelectionPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "branchesCombobox")
ARRAY TEXT:C222(arrBranches; 0)
ARRAY TEXT:C222(branchSelectionValues; 0)
handlePopupSelectRecordsByBrID(->arrBranches; ->[Invoices:5]; ->[Invoices:5]BranchID:53; CBQUERYSELECTION)
If (Size of array:C274(arrBranches)>1)
	COPY ARRAY:C226(arrBranches; branchSelectionValues)
Else 
	ARRAY TEXT:C222(branchSelectionValues; 0)
End if 

//----------------array of all currencies--------
ARRAY TEXT:C222($uniqueCurrencyCodes; 0)
getAllCurrencyCodes(->$uniqueCurrencyCodes)
C_LONGINT:C283(numCurrencies)
numCurrencies:=Size of array:C274($uniqueCurrencyCodes)
LISTBOX INSERT ROWS:C913(*; "listboxAnnualSummary"; 0; numCurrencies)
COPY ARRAY:C226($uniqueCurrencyCodes; arrCurrencyCodes)
//------------------finding flags for all currencies-----------
C_LONGINT:C283($k)
For ($k; 1; numCurrencies)
	QUERY:C277([Currencies:6]; [Currencies:6]CurrencyCode:1=arrCurrencyCodes{$k})
	arrFlags{$k}:=[Currencies:6]Flag:3
End for 