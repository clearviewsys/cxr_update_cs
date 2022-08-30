//%attributes = {}
// behaviour expected for picker

// up and down arrow shoud work
// double click a record should pick that record
// searching the record should work with enter key (to select the first item on the list)
// if only one item available om the screen, enter key should pick that
// if cancel is pressed, nothing is picked and the last result remains
// closing the picker form should not pick anything

C_TEXT:C284($picked)
// [List_RiskFactors];"Pick"
pickList_RiskFactors(->$picked; True:C214)
pickList_RiskFactors(->$picked; False:C215)  // should not open the dialog
myAlert($picked)  // displays the pick
pickList_RiskFactors(->$picked; True:C214)  // should open the dialog with a default picked
myAlert($picked)  // displays the pick
