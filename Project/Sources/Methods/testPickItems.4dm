//%attributes = {}
C_TEXT:C284($item)

pickItems(->$item)
//ALERT($item)
displaySelectedRecords(->[Items:39])
// [items];"pick"
myAlert("Picked "+$item)

pickItems(->$item; True:C214)  // force opening 
