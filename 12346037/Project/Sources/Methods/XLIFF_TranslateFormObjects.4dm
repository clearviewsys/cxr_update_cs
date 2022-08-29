//%attributes = {}
// TODO: Uncomment
//
//
//// --------------------------------------------------------------------------------------
//  // Method: XLIFF_TranslateFormObjects ({language})
//  // languages: es-ES, de-CH, fr-CH, it-CH, sv-SE
//  // Get all form object tiltles and find the translation into the [Keywords] table
//  // --------------------------------------------------------------------------------------
//
//  // Define variables
//C_TEXT($title;$language;$1)
//ARRAY TEXT($arrFormObjects;0)
//ARRAY POINTER($arrVars;0)
//ARRAY LONGINT($arrPages;0)
//C_TEXT($systemLang)
//
//  // Set current System Languages
//XLIFF_SetLanguages
//
//
//Case of 
//: (Count parameters=0)
//$systemLang:=GetCurrentLocalization
//
//: (Count parameters=1)
//$systemLang:=$1
//Else 
//assertInvalidNumberOfParams (Current method name;Count parameters)
//End case 
//
//  // Get all form objects
//FORM GET OBJECTS($arrFormObjects;$arrVars;$arrPages;Form all pages)
//$maxObjects:=Size of array($arrFormObjects)
//
//$process:=True
//
//  // For each object find the translation in the [Keywords] Table, if doesn't exist use the current title.
//For ($i;1;$maxObjects)
//
//$objType:=OBJECT Get type(*;$arrFormObjects{$i})
//$title:=OBJECT Get title(*;$arrFormObjects{$i})
//
//Case of 
//
//: ($objType=Object type static text)
//$process:=True
//
//: ($objType=Object type 3D button)
//$process:=True
//
//: ($objType=Object type 3D checkbox)
//$process:=False
//
//: ($objType=Object type 3D radio button)
//$process:=False
//
//: ($objType=Object type button grid)
//$process:=False
//
//: ($objType=Object type checkbox)
//$process:=True
//
//: ($objType=Object type combobox)
//$process:=False
//
//: ($objType=Object type dial)
//$process:=False
//
//: ($objType=Object type group)
//$process:=False
//
//: ($objType=Object type groupbox)
//$process:=True
//
//: ($objType=Object type hierarchical list)
//$process:=False
//
//: ($objType=Object type hierarchical popup menu)
//$process:=False
//
//: ($objType=Object type highlight button)
//$process:=False
//
//: ($objType=Object type invisible button)
//$process:=False
//
//: ($objType=Object type line)
//$process:=False
//
//: ($objType=Object type listbox)
//
//ARRAY TEXT($arrListBoxObjs;0)
//LISTBOX GET OBJECTS(*;$arrFormObjects{$i};$arrListBoxObjs)
//
//For ($j;1;Size of array($arrListBoxObjs))
//
//$type:=OBJECT Get type(*;$arrListBoxObjs{$j})
//
//Case of 
//
//: ($type=Object type listbox header)
//
//$title:=OBJECT Get title(*;$arrListBoxObjs{$j})
//
//If (($title#"") & (Length($title)>1))
//$newTitle:=XLIFF_GetTranslationFromTable($title;$systemLang)
//OBJECT SET TITLE(*;$arrListBoxObjs{$j};$newTitle)
//End if 
//
//: ($objType=Object type listbox column)
//: ($objType=Object type listbox footer)
//: ($objType=Object type listbox header)
//  // Do nothing
//
//Else 
//  // Do nothing
//End case 
//
//
//End for 
//
//$process:=False
//
//
//: ($objType=Object type matrix)
//$process:=False
//
//: ($objType=Object type oval)
//$process:=False
//
//: ($objType=Object type picture button)
//$process:=False
//
//: ($objType=Object type picture input)
//$process:=False
//
//: ($objType=Object type picture popup menu)
//$process:=False
//
//: ($objType=Object type picture radio button)
//$process:=False
//
//: ($objType=Object type plugin area)
//$process:=False
//
//: ($objType=Object type popup dropdown list)
//$process:=False
//
//: ($objType=Object type progress indicator)
//$process:=False
//
//: ($objType=Object type push button)
//$process:=True
//
//: ($objType=Object type radio button)
//$process:=True
//
//: ($objType=Object type radio button field)
//$process:=True
//
//: ($objType=Object type rectangle)
//$process:=False
//
//: ($objType=Object type rounded rectangle)
//$process:=False
//
//: ($objType=Object type ruler)
//$process:=False
//
//: ($objType=Object type splitter)
//$process:=False
//
//: ($objType=Object type static picture)
//$process:=False
//
//: ($objType=Object type static text)
//$process:=True
//
//: ($objType=Object type subform)
//$process:=False
//
//: ($objType=Object type tab control)
//$process:=False
//
//
//: ($objType=Object type text input)
//$process:=False
//
//: ($objType=Object type unknown)
//$process:=False
//
//: ($objType=Object type web area)
//$process:=False
//
//Else 
//$process:=False
//
//End case 
//
//If ($process)
//$newTitle:=XLIFF_GetTranslationFromTable($title;$systemLang)
//OBJECT SET TITLE(*;$arrFormObjects{$i};$newTitle)
//End if  
//
//
//End for 