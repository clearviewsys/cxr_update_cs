//%attributes = {}
C_TEXT:C284($var)
// expect to pick a note template and ....
handlePickNoteTemplateButton(->$var)
myAlert($var)

$var:=""
// expect to get a pick note template overriding the original pick
handlePickNoteTemplateButton(->$var)
myAlert($var)

// expect the picked value to be added to the var
handlePickNoteTemplateButton(->$var)
myAlert($var)
