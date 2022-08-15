//%attributes = {}
// ----------------------------------------------------

// User name (OS): Jonathan Le

// Date and time: 04/02/04, 09:26:59

// ----------------------------------------------------

// Method: BKP_XML_SaveGeneral

// Description

// 

//

// Parameters

// ----------------------------------------------------

C_TIME:C306($1; $0; $tiDocRef)
C_LONGINT:C283($i)

$tiDocRef:=$1

SAX OPEN XML ELEMENT:C853($tiDocRef; "General")

For ($i; 1; Size of array:C274(aGeneralNames))
	SAX OPEN XML ELEMENT:C853($tiDocRef; aGeneralNames{$i})
	SAX ADD XML ELEMENT VALUE:C855($tiDocRef; BKP_GetTextVal(aGeneralNames{$i}))
	SAX CLOSE XML ELEMENT:C854($tiDocRef)
End for 

// handle the include files last

SAX OPEN XML ELEMENT:C853($tiDocRef; "IncludesFiles")
SAX OPEN XML ELEMENT:C853($tiDocRef; "ItemsCount")
SAX ADD XML ELEMENT VALUE:C855($tiDocRef; String:C10(Size of array:C274(IncludesFiles)))
SAX CLOSE XML ELEMENT:C854($tiDocRef)
For ($i; 1; Size of array:C274(IncludesFiles))
	SAX OPEN XML ELEMENT:C853($tiDocRef; "Item"+String:C10($i))
	SAX ADD XML ELEMENT VALUE:C855($tiDocRef; IncludesFiles{$i})
	SAX CLOSE XML ELEMENT:C854($tiDocRef)
End for 
SAX CLOSE XML ELEMENT:C854($tiDocRef)

SAX CLOSE XML ELEMENT:C854($tiDocRef)

$0:=$tiDocRef

