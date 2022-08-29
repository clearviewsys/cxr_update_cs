//%attributes = {}
// ----------------------------------------------------

// User name (OS): Jonathan Le

// Date and time: 04/02/04, 09:27:10

// ----------------------------------------------------

// Method: BKP_XML_SaveInfo

// Description

// 

//

// Parameters

// ----------------------------------------------------

C_TIME:C306($1; $0; $tiDocRef)
C_LONGINT:C283($i)

$tiDocRef:=$1

SAX OPEN XML ELEMENT:C853($tiDocRef; "DataBase")

For ($i; 1; Size of array:C274(aDBNames))
	SAX OPEN XML ELEMENT:C853($tiDocRef; aDBNames{$i})
	
	// write the itemCount

	SAX OPEN XML ELEMENT:C853($tiDocRef; "ItemsCount")
	SAX ADD XML ELEMENT VALUE:C855($tiDocRef; "1")
	SAX CLOSE XML ELEMENT:C854($tiDocRef)
	
	// write the Item1

	SAX OPEN XML ELEMENT:C853($tiDocRef; "Item1")
	SAX ADD XML ELEMENT VALUE:C855($tiDocRef; aDBValues{$i})
	SAX CLOSE XML ELEMENT:C854($tiDocRef)
	
	SAX CLOSE XML ELEMENT:C854($tiDocRef)
End for 

SAX CLOSE XML ELEMENT:C854($tiDocRef)

$0:=$tiDocRef

