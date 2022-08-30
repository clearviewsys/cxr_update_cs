//%attributes = {"publishedWeb":true}
// GraphPieArray (->Area;->seriesArray;->valueArray)

C_POINTER:C301($1; $2; $3; valuesArrayPtr; seriesArrayPtr)
C_LONGINT:C283($area)
seriesArrayPtr:=$2  // name of the fields
valuesArrayPtr:=$3  // values of the fields
//_O_ARRAY STRING(10;$categoryArray;1)
ARRAY TEXT:C222($categoryArray; 1)
$categoryArray{1}:="Category"

$Area:=($1->)

C_LONGINT:C283($chart)
//Ô14500;4Ô ($Area)  // Clear the graph

If (Size of array:C274(valuesArrayPtr->)>0)
	//$chart:=Ô14500;27Ô ($Area;6;1;seriesArrayPtr->;$categoryArray;valuesArrayPtr->)
	//Ô14500;109Ô ($Area;$Chart;2;2;0;"###.#%")  // display percentage values P.81
	//Ô14500;117Ô ($Area;$Chart;5;0;1;2)
	
	Chart showLegend($Area; $chart; True:C214; True:C214; 3)  //Don't display legend P.94
	chartTurnOffDisplays($area)
	
End if 
