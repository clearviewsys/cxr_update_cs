//%attributes = {}
// populateOccupations_ISCO88

// this will populate the Occupations table with with ISCO 88 Standard List
// ([Occupations];"Listbox")

Case of 
	: (Count parameters:C259=0)
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

ARRAY TEXT:C222($arrCodes; 0)
ARRAY TEXT:C222($arrOccupations; 0)

ALL RECORDS:C47([Occupations:2])
SELECTION TO ARRAY:C260([Occupations:2]Code:2; $arrCodes; [Occupations:2]Occupation:3; $arrOccupations)

populateOccupationArrays_ISCO08(->$arrCodes; ->$arrOccupations)

ARRAY TO SELECTION:C261($arrCodes; [Occupations:2]Code:2; $arrOccupations; [Occupations:2]Occupation:3)
UNLOAD RECORD:C212([Occupations:2])

READ ONLY:C145([Occupations:2])
