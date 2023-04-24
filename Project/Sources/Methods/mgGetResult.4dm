//%attributes = {}
// gets the result of MoneyGram transaction and saves it into WebEWire table
// accepts the main transaction dialog
// called by CALL FORM command from Web Area Window

C_OBJECT:C1216($1)

Form:C1466.result:=$1

Form:C1466.WebewireID:=mgCreateWebEWire(Form:C1466)

Form:C1466.canCloseWindow:=True:C214
