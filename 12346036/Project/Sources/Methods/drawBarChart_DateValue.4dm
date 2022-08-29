//%attributes = {}
//  // ----------------------------------------------------
//  // User name (OS): JJF
//  // Date and time: 06/17/15, 09:08:27
//  // ----------------------------------------------------
//  // Method: GRH_BarChart($ptrTable;$ptrField(&D);$ptrValueField(&N);XAxisLabel(&T);YAxisLabel(&T))
//  // Description
//  //  Wrapper method to create bar chart using GrapheSVG
//  //  Assume selection of records exist when called
//  // Parameters:
//  //  $1 - pointer to Table
//  //  $2 - pointer field of X axis
//  //  $3 - pointer field1 of Y axis
//  //  $4 - pointer field2 of Y axis {optional}
//  //  $5 - label for X axis (abcissa) {optional}
//  //  $6 - label for Y axis (ordinate) {optional}
//  //  $7 - label for Y1 axis {optional}
//  //  $8 - label for Y2 axis {optional}
//  //  $9 - Title  {optional}
//  // 
//  // ----------------------------------------------------
//C_BOOLEAN($u150617;$u150625;$u150706)
//C_LONGINT($0)
//C_POINTER($1;$2;$3;$4;$ptrTable;$ptrField_X;$ptrField_Y1;$ptrField_Y2)
//C_TEXT($5;$6;$7;$8;$9;$abscissa_XLabel;$ordinate_YLabel;$axisY1_Label_t;$axisY2_Label_t)
//C_LONGINT($tableNbr;$fieldNbrX;$fieldNbrY1;$fieldNbrY2)
//C_LONGINT($titleFontSize;$a2d_Values1_rFontSize;$LegendFontSize;$BarWidth;$SpaceBar;$TitleOffSet)
//C_LONGINT($nbrY_Series)
//ARRAY TEXT($aParamNames_t;0)
//ARRAY TEXT($aOrdinals_t;12)
//ARRAY REAL($a2d_Values1_r;2;12)  // can be as many as two sets of data (determine based upon $nbrY_Series)


//$ptrTable:=$1
//$ptrField_X:=$2
//$ptrField_Y1:=$3
//$tableNbr:=Table($ptrTable)
//$fieldNbrX:=Field($ptrField_X)
//$fieldNbrY1:=Field($ptrField_Y1)

//If (Not(Is nil pointer($4)))
//$ptrField_Y2:=$4
//$fieldNbrY2:=Field($ptrField_Y2)
//$nbrY_Series:=2
//Else 
//$nbrY_Series:=1
//End if 

//If (Count parameters>4)
//$abscissa_XLabel:=$5
//Else 
//If ($fieldNbrX>0)
//$abscissa_XLabel:=Field name($tableNbr;$fieldNbrX)
//End if 
//End if 

//If (Count parameters>5)
//$ordinate_YLabel:=$6
//End if 

//If (Count parameters>6)
//$axisY1_Label_t:=$7
//Else 
//If ($fieldNbrY1>0)
//$axisY1_Label_t:=Field name($tableNbr;$fieldNbrY1)
//End if 
//End if 

//If (Count parameters>7)
//$axisY2_Label_t:=$8
//Else 
//If ($fieldNbrY2>0)
//$axisY2_Label_t:=Field name($tableNbr;$fieldNbrY2)
//End if 
//End if 

//If (Count parameters>8)
//$title:=$9
//Else 
//$title:="Monthly Transaction Volume for "+vCurrency+" "+vAccountID+" (in thousands)"+" in "+String(vYear)
//End if 

//If (Is table number valid($tableNbr))  // must exist

//If (Is field number valid($tableNbr;$fieldNbrX) & Is field number valid($tableNbr;$fieldNbrY1))  // at least one X and one Y

//C_LONGINT(cbCheckBox)
//C_TEXT($grapheType;$title;$branchID;$accountID)

//$alignement:="Vertical"
//$grapheType:="Line"
//$TitleFontSize:=48
//$LegendFontSize:=36

//  //appendToStringOnCondition((vBranchID#"");->$title;" for "+Uppercase(vBranchID))

//ARRAY TEXT($aGraphDataName_t;0)
//ARRAY TEXT($aGraphData_t;0)

//APPEND TO ARRAY($aGraphDataName_t;"Title")
//APPEND TO ARRAY($aGraphData_t;$title)  // 1 - Title of graph

//APPEND TO ARRAY($aGraphDataName_t;"GraphOrientation")
//APPEND TO ARRAY($aGraphData_t;$alignement)  // 2 - orientation abcisses"

//  // abscissa: (in a system of coordinates) the x -coordinate, the distance from a  
//  // point to the vertical or y -axis measured parallel to the horizontal or x -axis.
//APPEND TO ARRAY($aGraphDataName_t;"abscissaName")
//APPEND TO ARRAY($aGraphData_t;$abscissa_XLabel)  // 3 - wording of abcisses

//APPEND TO ARRAY($aGraphDataName_t;"ordinateName")
//APPEND TO ARRAY($aGraphData_t;$ordinate_YLabel)  // 4 - wording of ordinates

//APPEND TO ARRAY($aGraphDataName_t;"ShowLegend")
//APPEND TO ARRAY($aGraphData_t;"Yes")  // 5 - Display of the legend

//APPEND TO ARRAY($aGraphDataName_t;"GraphBGColor")
//APPEND TO ARRAY($aGraphData_t;"White")  // 6 - Background Color

//APPEND TO ARRAY($aGraphDataName_t;"ForcingScalesToZero")
//APPEND TO ARRAY($aGraphData_t;"Yes")  // 7 - Forcing zero scales

//APPEND TO ARRAY($aGraphDataName_t;"ValueFormat")
//APPEND TO ARRAY($aGraphData_t;"$###,##0")  // formatting

//APPEND TO ARRAY($aGraphDataName_t;"GraphFont")
//APPEND TO ARRAY($aGraphData_t;"Arial")  // 8 - Police legends and scales

//APPEND TO ARRAY($aGraphDataName_t;"ShowZeroValues")
//APPEND TO ARRAY($aGraphData_t;"no")

//APPEND TO ARRAY($aGraphDataName_t;"TitleFontStyle")
//APPEND TO ARRAY($aGraphData_t;String(Bold))

//APPEND TO ARRAY($aGraphDataName_t;"TitleFontSize")
//APPEND TO ARRAY($aGraphData_t;String($titleFontSize))

//APPEND TO ARRAY($aGraphDataName_t;"X-LegendOrientation")  // normal - Quinconce - rotation:30
//APPEND TO ARRAY($aGraphData_t;"rotation:-45")

//APPEND TO ARRAY($aGraphDataName_t;"X-FontSize")
//APPEND TO ARRAY($aGraphData_t;String($LegendFontSize))

//APPEND TO ARRAY($aGraphDataName_t;"Y-FontSize")
//APPEND TO ARRAY($aGraphData_t;String($LegendFontSize))

//APPEND TO ARRAY($aGraphDataName_t;"Y-FontStyle")
//APPEND TO ARRAY($aGraphData_t;String(Underline))

//APPEND TO ARRAY($aGraphDataName_t;"Ratio")
//APPEND TO ARRAY($aGraphData_t;"66")  // 40

//  //Setting different curves
//ARRAY TEXT($a2d_SeriesParams_t;1;13)  //N curves (here 5) with their 9 settings
//$a2d_SeriesParams_t{1}{1}:=$grapheType  //type curve
//$a2d_SeriesParams_t{1}{2}:="blue"  //color
//$a2d_SeriesParams_t{1}{3}:="2"  //Order tracking
//$a2d_SeriesParams_t{1}{4}:=<>BASECURRENCY  //Unit
//$a2d_SeriesParams_t{1}{5}:="0"  //Number of decimal places
//$a2d_SeriesParams_t{1}{6}:="square"  //Brand Values (Only for curves) non / square / circle / triangle
//$a2d_SeriesParams_t{1}{7}:="yes"  //Display of values and position 
//$a2d_SeriesParams_t{1}{8}:=""  //Display font size values of the curve (24)
//$a2d_SeriesParams_t{1}{9}:="75"  //Transparency
//$a2d_SeriesParams_t{1}{10}:="1"  // perimeter symbols
//APPEND TO ARRAY($aParamNames_t;$axisY1_Label_t)  // "Bought")
//  // want drop area uncomment these
//  //$a2d_SeriesParams_t{1}{11}:="darkblue"  // Font color values
//  //$a2d_SeriesParams_t{1}{12}:="white"  //First color for the gradient
//  //$a2d_SeriesParams_t{1}{13}:="blue"  //Second color for the gradient

//If ($nbrY_Series=2)
//ARRAY TEXT($a2d_SeriesParams_t;2;13)  //N curves (here 5) with their 9 settings
//$a2d_SeriesParams_t{2}{1}:=$grapheType  //type curve
//$a2d_SeriesParams_t{2}{2}:="red"  //color
//$a2d_SeriesParams_t{2}{3}:="2"  //Order tracking
//$a2d_SeriesParams_t{2}{4}:=<>BASECURRENCY  //Unit
//$a2d_SeriesParams_t{2}{6}:="circle"  //Brand Values (Only for curves) non / square / circle / triangle
//$a2d_SeriesParams_t{2}{7}:="yes"  //Display of values and position 
//$a2d_SeriesParams_t{2}{8}:=""  //Display font size values of the curve (24)
//$a2d_SeriesParams_t{2}{9}:="75"  //Transparency
//$a2d_SeriesParams_t{2}{10}:="1"  // perimeter symbols
//APPEND TO ARRAY($aParamNames_t;$axisY2_Label_t)  // "Sold")
//End if 

//  //  //Generation and data filling (??? Why are these here???)
//  //$year:=vYear
//  //$curr:=vCurrency
//  //$branchID:=vBranchID
//  //$accountID:=vAccountID

//  // Create month buckets
//  // $u150706: Flatten
//  //  GRH_BuildOrdinalLabels ($ptrTable;->$aOrdinals_t;$ptrField_X)
//C_TEXT($year_t)
//C_LONGINT($ndx;$size;$count_Rec;$month;$divInto_l)
//C_POINTER($a2d_Values_ptr)

//  // Need year of date range (grab first record in selection)
//FIRST RECORD($ptrTable->)

//$year_t:=String(Year of($ptrField_X->))

//UNLOAD RECORD($ptrTable->)

//$size:=Size of array($aOrdinals_t)

//  //Generation and data filling
//For ($ndx;1;$size)
//$aOrdinals_t{$ndx}:=String($ndx)+"/ "+$year_t
//End for 

//  // $u150706: Flatten
//  // GRH_BuildDataSeriesValues (->$a2d_Values1_r{1};$ptrTable;$ptrField_X;$ptrField_Y1)
//$a2d_Values_ptr:=->$a2d_Values1_r{1}
//$divInto_l:=1
//If (Size of array($a2d_Values_ptr->)=12)  // make sure 12 elements (months) $a2d_Values_ptr->{1}
//$count_Rec:=Records in selection($ptrTable->)
//FIRST RECORD($ptrTable->)
//For ($ndx;1;$count_Rec)
//$month:=Month of($ptrField_X->)

//If ($month>0) & ($month<13)
//$a2d_Values_ptr->{$month}:=Round($a2d_Values_ptr->{$month}+(($ptrField_Y1->)/$divInto_l);2)
//End if 

//NEXT RECORD($ptrTable->)
//  // UNLOAD RECORD($ptrTable->)
//End for 

//End if 

//If ($nbrY_Series=2)
//  // $u150706: Flatten
//  // GRH_BuildDataSeriesValues (->$a2d_Values1_r{2};$ptrTable;$ptrField_X;$ptrField_Y2)

//$a2d_Values_ptr:=->$a2d_Values1_r{2}
//If (Size of array($a2d_Values_ptr->)=12)  // make sure 12 elements (months) $a2d_Values_ptr->{1}
//$count_Rec:=Records in selection($ptrTable->)
//FIRST RECORD($ptrTable->)
//For ($ndx;1;$count_Rec)
//$month:=Month of($ptrField_X->)

//If ($month>0) & ($month<13)
//$a2d_Values_ptr->{$month}:=Round($a2d_Values_ptr->{$month}+(($ptrField_Y2->)/$divInto_l);2)
//End if 

//NEXT RECORD($ptrTable->)
//  // UNLOAD RECORD($ptrTable->)
//End for 

//End if 

//End if 

//SVGGraph:=SGR_Generate_Graph (->$aGraphDataName_t;->$aGraphData_t;->$aParamNames_t;->$aOrdinals_t;->$a2d_Values1_r;->$a2d_SeriesParams_t)  // ;->$a2d_Values2_r;->$texteSVG

//End if 

//End if 
