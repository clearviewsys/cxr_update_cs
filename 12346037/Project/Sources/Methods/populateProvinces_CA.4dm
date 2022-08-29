//%attributes = {}
// populateProvinces_CA

// this will populate the States table with provinces of Canada
// ([States];"Listbox")

ARRAY TEXT:C222($arrKeys; 0)
ARRAY TEXT:C222($arrValues; 0)

ALL RECORDS:C47([States:61])

SELECTION TO ARRAY:C260([States:61]StateCode:1; $arrKeys; [States:61]StateName:3; $arrValues)

populateProvincesArrays_CA(->$arrKeys; ->$arrValues)

ARRAY TO SELECTION:C261($arrKeys; [States:61]StateCode:1; $arrValues; [States:61]StateName:3)

UNLOAD RECORD:C212([States:61])
READ ONLY:C145([States:61])