//%attributes = {}
//  // GraphDateValueArrays (->Area;->dateArray;->valueArray;type;colour)
//  // POST : this method modifies vars dateArrarPtr, valueArrayPtr, vSum, vMin, vMax,
//  // POST: this method modifes vars: vStdv;

//C_POINTER($1;$2;$3)
//C_LONGINT($4;$type)
//C_LONGINT($5;$colour)
//C_POINTER(valueArrayPtr;dateArrayPtr)
//C_LONGINT($area;$chart;$0)
//C_LONGINT($width;$height;$left;$top;$right;$bottom)
//_O_ARRAY STRING(10;$categoryArray;1)
//$categoryArray{1}:="NAVs"
//$area:=$1->
//dateArrayPtr:=$2
//valueArrayPtr:=$3
//If (Size of array($2->)>2)
//If (Count parameters=3)
//$type:=4
//$colour:=getChartColour (<>FundColour)
//Else 
//$type:=$4
//$colour:=$5
//End if 

//C_LONGINT($range)
//C_REAL(vmin;vmax;vmean;vStdv)
//vGetTendencyVars (valueArrayPtr;->vSum;->vMin;->vMax;->vmean;->vStdv)
//$range:=vmax-vmin

//_O_ARRAY STRING(8;abbrDateArray;Size of array(dateArrayPtr->))
//vFillAbbrDates (->abbrDateArray;dateArrayPtr->{1};0;1;0)

//Ô14500;4Ô ($area)

//  //CT $chart arrays ($area; type; size; categoryArray; seriesArray; valuesArray)  
//$chart:=Ô14500;27Ô ($area;$type;1;abbrDateArray;$categoryArray;valueArrayPtr->)

//  //1$area 
//  //2Column 
//  //3 Picture 
//  //4Line

//ARRAY INTEGER(aOptions;3)
//aOptions{1}:=0
//aOptions{2}:=0
//aOptions{3}:=0

//Ô14500;87Ô ($area;$chart;aOptions)  // hide the boxes on the lines

//  //CT SET LABEL ATTRIBUTES (area; object; axis; position; orientation; format{; freq  `uency}) 
//Ô14500;31Ô ($area;$chart;0;3;0;"";(Size of array(dateArrayptr->)\6+1))  // Set the label attributes   
//Ô14500;31Ô ($area;$chart;2;3;0;"|General noDec")  // set the vertical label format

//  // set the font
//Ô14500;37Ô ($area;-1;4;0;Ô14500;85Ô ("Helvetica");9;0)  // Set the horizontal axis font

//  //CT SET $chart LINE ATTRIBUTES(area;object;partType;partSpecifics;pattern;color;li  `neWidth)
//Ô14500;35Ô ($Area;$chart;8;100;-1;$colour;2)  // Make the line thicker for Fund and colorize it 
//Ô14500;35Ô ($area;$chart;3;2;-1;Ô14500;80Ô (1);1)  // make the vertical axis white (invisible)

//  //CT SET AXIS ATTRIBUTES (area; object; axis; minorTick; majorTick; location; rever  `se) 
//Ô14500;34Ô ($area;$chart;0;0;2;valueArrayPtr->{1};0)  // Set the category axis attributes and the origin 
//Ô14500;34Ô ($area;$chart;0;0;0;0;0)  // turn off minor and major ticks on the x series axis
//Ô14500;34Ô ($area;$chart;2;0;0;0;0)  // turn off minor and major ticks on the y values axis

//  //  CT SET REAL SCALE ($area;obj;minAut;maxAut;majIncrA minIncrA;Min;Max;mjorIncr;
//Ô14500;41Ô ($area;$chart;0;0;0;0;vmin;vmax*1.02;(vmax-vmin)\4+1;250)

//Chart showLegend ($area;$chart;False;True;8)  //Don't display legend P.94  
//Chart showGrid ($area;$chart;False;False;False)  // Show grids
//Chart drawBorder ($area;$chart;Ô14500;80Ô (1);2)  // Draws an outline border in white 
//Chart ColorizeGrids ($area;$chart;Ô14500;80Ô (15);Ô14500;80Ô (1))  // Colorize grids

//Ô14500;12Ô ($area;1;$left;$top;$right;$bottom)
//Ô14500;77Ô ($area;-1;($right-$left)-40;($bottom-$top)-25)

//chartTurnOffDisplays ($area)
//  //CT NEW DOCUMENT ($area)  ` Clear the graph
//  //CT area TO AREA (offscreenArea;$area;3)
//  //CT DELETE OFFSCREEN area (offscreenArea)

//_O_ARRAY STRING(8;abbrDateArray;0)
//$0:=$chart
//Else 
//  // assert: size of array <=2
//Ô14500;4Ô ($area)  // Clear the graph
//End if 
