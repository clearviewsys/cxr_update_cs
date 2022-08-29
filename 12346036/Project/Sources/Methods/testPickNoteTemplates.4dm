//%attributes = {}
C_TEXT:C284($picked)
// [NoteTemplates];"Pick"
pickNoteTemplates(->$picked; True:C214)
pickNoteTemplates(->$picked)  // should not open the dialog
myAlert($picked)  // displays the pick
pickNoteTemplates(->$picked; True:C214)  // should open the dialog with a default picked