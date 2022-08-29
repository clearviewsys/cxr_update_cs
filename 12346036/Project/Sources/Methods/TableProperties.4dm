//%attributes = {}
/*C_LONGINT($TableNum; $lastField)
ARRAY TEXT($fieldTitles; 160)
ARRAY LONGINT($fieldNums; 160)
C_TEXT($myfield; $eachField)
$TableNum:=$1
$lastField:=Get last field number(3)
GET FIELD TITLES([Customers]; $fieldTitles; $fieldNums)
/*$myfield:=JSON Stringify($fieldTitles)
$0:=ALERT($myfield)*/
C_COLLECTION($titlesCollection)
$titlesCollection:=New collection
ARRAY TO COLLECTION($titlesCollection; $fieldTitles)
//C_OBJECT($eachField)
//$eachField:=New object
For each ($eachField; $titlesCollection)
$myfield:=$myfield+" "+$eachField)
End for each 

SET TEXT TO PASTEBOARD($myfield)

//$0:=ALERT($titlesCollection[10])
*/

ARRAY TEXT:C222($prop; 0)
OB GET PROPERTY NAMES:C1232(ds:C1482.Customers; $prop)

//SET TEXT TO PASTEBOARD($prop)


