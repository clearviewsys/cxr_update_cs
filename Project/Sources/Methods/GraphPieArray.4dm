//%attributes = {"publishedWeb":true}
//  // GraphPieArray (->Area;->seriesArray;->valueArray)

//C_POINTER($1;$2;$3;valuesArrayPtr;seriesArrayPtr)
//C_LONGINT($area)
//seriesArrayPtr:=$2  // name of the fields
//valuesArrayPtr:=$3  // values of the fields
//ARRAY TEXT($categoryArray;1)
//$categoryArray{1}:="Category"

//$Area:=($1->)

//C_LONGINT($chart)
//  //Ô14500;4Ô ($Area)  // Clear the graph
//ARRAY LONGINT($cWheel;10)
//$cWheel{1}:=7377056
//$cWheel{2}:=2121888
//$cWheel{3}:=2130096
//$cWheel{4}:=2138288
//$cWheel{5}:=2146480
//$cWheel{6}:=2146432
//$cWheel{7}:=5292112
//$cWheel{8}:=9486416
//$cWheel{9}:=12632144
//$cWheel{10}:=16760912


//If (Size of array(valuesArrayPtr->)>0)
//$chart:=Ô14500;27Ô($Area;6;1;seriesArrayPtr->;$categoryArray;valuesArrayPtr->)
//  //Ô14500;109Ô ($Area;$Chart;0;2;0;"###.#%")  // display percentage values P.81
//  //Ô14500;117Ô ($Area;$Chart;5;0;1;2)

//For ($series;1;Size of array(seriesArrayPtr->))
//  //Ô14500;36Ô ($area;$chart;8;100*$series;3;getChartColour ($cWheel{$series}))
//  //Ô14500;36Ô ($area;$chart;8;0;2;getChartColour ($cWheel{$series}))
//OBJECT SET RGB COLORS(*;"L_"+seriesArrayPtr->{$series};0x00FFFFFF;($cWheel{$series}))
//OBJECT SET RGB COLORS(*;"rectangle"+String($series);0x00FFFFFF;($cWheel{$series}))
//End for 
//Chart showLegend ($Area;$chart;False;True;3)  //Don't display legend P.94
//  //chartTurnOffDisplays($area)
//  //CT SET DISPLAY ($area;1;0)  ` turn off menu bar
//  //Ô14500;75Ô ($area;-1;0)  // deselect all objects
//End if 