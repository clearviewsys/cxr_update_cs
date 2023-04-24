//%attributes = {}
// handleLinkNameEntryField (->fieldPtr)
// call this method inside [customers]firstName or lastName field object on the form

C_POINTER:C301($fieldPtr; $1)
$fieldPtr:=$1
C_BOOLEAN:C305($ok1; $ok2)

//clearPictureField(->latestLinkIcon7)
$fieldPtr->:=removeEnclosingSpaces(toTitleCase($fieldPtr))
//checkLinkFullName
sl_handleLinksScreening(sl_LinksPerson+sl_ForInputBox)
//C_TEXT($name)
//If (([Links]FirstName#"") & ([Links]LastName#""))
//$name:=makeFullName([Links]FirstName; [Links]LastName)
//sl_handlePersonNameCompliance(False; $name; ->[Links]LinkID; New object(\
"pointers"; New object("resultIconPtr"; ->latestLinkIcon7); \
"options"; New object(\
"namePartsFilled"; (([Links]FirstName#"") & ([Links]LastName#""))\
)))
//End if



