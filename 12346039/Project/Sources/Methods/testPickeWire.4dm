//%attributes = {}
C_TEXT:C284($picked)
// [ewires];"Pick"
pickeWire(->$picked)
myAlert($picked)  // displays the pick
$picked:=""
pickeWire(->$picked)  // should not open the dialog
myAlert($picked)  // displays the pick
