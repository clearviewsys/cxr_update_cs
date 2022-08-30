
C_TEXT:C284($xlsxml)

$xlsxml:=collectionListboxToExcel("listbox"; Form:C1466.mainlist)

SET TEXT TO PASTEBOARD:C523($xlsxml)
