//%attributes = {}
/** Method called during an exception from sanction check module

#see sl_pullCXRBlacklistServer, sl_pullKYC2020Server
*/
ARRAY LONGINT:C221($codesArray; 0)
ARRAY TEXT:C222($intCompArray; 0)
ARRAY TEXT:C222($textArray; 0)

GET LAST ERROR STACK:C1015($codesArray; $intCompArray; $textArray)

myAlert($textArray{1})