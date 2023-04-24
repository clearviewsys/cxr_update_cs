//%attributes = {}
// getAbbrMonthName (month:int)->string
// ex :getAbbrMonthName(1) -> "Jan"
C_TEXT:C284($0)
C_LONGINT:C283($1)
//_O_ARRAY STRING(3;$monthsArray;12)
ARRAY TEXT:C222($monthsArray; 12)

$monthsArray{1}:="Jan"
$monthsArray{2}:="Feb"
$monthsArray{3}:="Mar"
$monthsArray{4}:="Apr"
$monthsArray{5}:="May"
$monthsArray{6}:="Jun"
$monthsArray{7}:="Jul"
$monthsArray{8}:="Aug"
$monthsArray{9}:="Sep"
$monthsArray{10}:="Oct"
$monthsArray{11}:="Nov"
$monthsArray{12}:="Dec"

$0:=$monthsArray{$1%12}
