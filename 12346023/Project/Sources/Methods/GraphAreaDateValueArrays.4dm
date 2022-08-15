//%attributes = {"publishedWeb":true}
//  // GraphDateValueArrays (Area;->dateArray;->valueArray)

//C_POINTER($2;$3)
//C_POINTER(valueArrayPtr;dateArrayPtr)
//C_LONGINT(offscreenArea;$1;area;chart)
//C_LONGINT($width;$height;$left;$top;$right;$bottom)
//_O_ARRAY STRING(10;$categoryArray;1)
//$categoryArray{1}:="NAVs"
//area:=$1
//dateArrayPtr:=$2
//valueArrayPtr:=$3

//C_LONGINT($range)
//C_REAL(vmin;vmax;vmean;vstd;vSum)
//vGetTendencyVars (valueArrayPtr;->vSum;->vMin;->vMax;->vmean;->vstd)
//$range:=vmax-vmin

//offscreenArea:=Ô14500;10Ô   // Clear the graph

//  //CT Chart arrays (area; type; size; categoryArray; seriesArray; valuesArray)  
//chart:=Ô14500;27Ô (offscreenArea;2;1;dateArrayPtr->;$categoryArray;valueArrayPtr->)

//  //1Area 
//  //2Column 
//  //3 Picture 
//  //4Line

//Ô14500;36Ô (offscreenArea;chart;8;101;-1;Ô14500;78Ô (55000;55000;65530))
//Ô14500;31Ô (offscreenArea;chart;0;3;0;"";(Size of array(dateArrayptr->)\6+1))  // Set the label attributes   
//  //CT SET LABEL ATTRIBUTES (offscreenArea;chart;2;2;0;"";1)  ` Set the label attri
//  //CT SET LABEL ATTRIBUTES (offscreenArea;chart;0;-1;0;"abbreviated")

//Ô14500;34Ô (offscreenArea;chart;0;0;2;valueArrayPtr->{1};0)  // Set the category axis attributes and the origin be 100 
//Ô14500;37Ô (offscreenArea;-1;4;0;Ô14500;85Ô ("Helvetica");9;0)  // Set the horizontal axis font

//Ô14500;34Ô (offscreenArea;chart;0;0;0;0;0)  // turn off minor and major ticks on the x series axis
//Ô14500;34Ô (offscreenArea;chart;2;0;0;0;0)  // turn off minor and major ticks on the y values axis

//  //  CT SET REAL SCALE (area;obj;minAut;maxAut;majIncrA minIncrA;Min;Max;mjorIncr;m
//Ô14500;41Ô (offscreenArea;chart;0;0;0;0;vmin;vmax*1.02;(vmax-vmin)\4+1;250)

//Chart showLegend (offscreenArea;chart;False;True;8)  //Don't display legend P.94  
//Chart showGrid (offscreenArea;chart;True;False;True)  // Show grids
//Chart drawBorder (offscreenArea;chart;Ô14500;80Ô (15);2)  // Draws an outline bor
//Chart ColorizeGrids (offscreenArea;chart;Ô14500;80Ô (15);Ô14500;80Ô (15))  // Colorize grids

//Ô14500;12Ô (area;1;$left;$top;$right;$bottom)
//Ô14500;77Ô (offscreenArea;-1;($right-$left)-20;($bottom-$top)-20)

//chartTurnOffDisplays (offscreenArea)

//Ô14500;4Ô (area)  // Clear the graph
//Ô14500;6Ô (offscreenArea;area;3)
//Ô14500;11Ô (offscreenArea)
