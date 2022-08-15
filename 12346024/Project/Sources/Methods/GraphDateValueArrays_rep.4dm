//%attributes = {"publishedWeb":true}
// GraphDateValueArrays (->Area;->dateArray;->valueArray;type;colour)
// POST : this method modifies vars dateArrarPtr, valueArrayPtr, vSum, vMin, vMax,
// POST: this method modifes vars: vStdv;

C_POINTER:C301($1; $2; $3)
C_LONGINT:C283($Area; $chart)

$Area:=$1->  // dereference the the area pointer

//$chart:=graphDateValueArrays ($1;$2;$3)
//Ô14500;37Ô ($Area;$chart;4;0;Ô14500;85Ô ("Arial");6;0;Ô14500;80Ô (16))  // Set the horizontal axis font
//Ô14500;37Ô ($Area;$chart;4;2;Ô14500;85Ô ("Arial");6;0;Ô14500;80Ô (16))  // set The vertical axis

// write any customization code in this space