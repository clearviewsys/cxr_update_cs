//%attributes = {}
// ----------------------------------------------------

// User name (OS): Jonathan Le

// Date and time: 04/02/04, 09:25:23

// ----------------------------------------------------

// Method: BKP_GetDirGlyph

// Description

// 

//

// Parameters

C_TEXT:C284($0)

Case of 
	: (Is macOS:C1572)  // changed by @tiran for v18 
		$0:=":"
	Else 
		$0:="/"
End case 

