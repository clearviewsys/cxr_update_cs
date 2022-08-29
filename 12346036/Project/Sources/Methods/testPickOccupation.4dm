//%attributes = {}
C_TEXT:C284($occupation)
// [occupations];"PICK"

pickOccupation(->$occupation)
myAlert($occupation+CRLF+[Occupations:2]Code:2+" : "+[Occupations:2]Occupation:3)

displaySelectedRecords(->[Occupations:2])
