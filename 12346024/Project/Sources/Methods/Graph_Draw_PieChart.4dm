//%attributes = {}

// ----------------------------------------------------
// User name (OS): John J Foster
// Date and time: 10/28/20, 10:33:15
// ----------------------------------------------------
// Method: Graph_Draw_PieChart ($graphPtr;->$arrX;->$arrY;$oSettings)
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_BOOLEAN:C305($u201111)
C_POINTER:C301($graphPtr; $xArrPtr; $valuePtr)
C_OBJECT:C1216($oSettings)  //Initialize graph settings

Case of 
	: (Count parameters:C259=3)
		$graphPtr:=$1
		$xArrPtr:=$2
		$valuePtr:=$3
	: (Count parameters:C259=4)
		$graphPtr:=$1
		$xArrPtr:=$2
		$valuePtr:=$3
		$oSettings:=$4
	Else 
		
End case 

If (Not:C34(OB Is defined:C1231($oSettings)))
	$oSettings:=New object:C1471
End if 

If (OB Is defined:C1231($oSettings))  // shouldn't be needed but...
	
	// 1=Bar, 2=Proportional, 3=Stacked, 4=Line, 5=Surface, 6=Scatter, 7=Pie, 8=Picture
	If (Not:C34(OB Is defined:C1231($oSettings; "Graph type")))
		$oSettings[Graph type:K82:1]:=7
	End if 
	
	If (Not:C34(OB Is defined:C1231($oSettings; "Graph document background color")))
		$oSettings[Graph document background color:K82:23]:="#FFFFFF"
	End if 
	
	If (Not:C34(OB Is defined:C1231($oSettings; "Graph document background opacity")))
		$oSettings[Graph document background opacity:K82:24]:=0
	End if 
	
	If (Not:C34(OB Is defined:C1231($oSettings; "Graph background shadow color")))
		$oSettings[Graph background shadow color:K82:35]:="#FFFFFF"
	End if 
	
	If (Not:C34(OB Is defined:C1231($oSettings; "Graph bottom margin")))
		$oSettings[Graph bottom margin:K82:14]:=12  //  default 12
	End if 
	
	If (Not:C34(OB Is defined:C1231($oSettings; "Graph colors")))
		$oSettings[Graph colors:K82:22]:="#EFEFFF"
	End if 
	
	// Graph column gap //  only for Bar, Proportional, Stacked, default 12
	
	// Graph column width max //  only for Bar, Proportional, Stacked, default 200
	
	// Graph column width min //  only for Bar, Proportional, Stacked, default 10
	
	If (Not:C34(OB Is defined:C1231($oSettings; "Graph default height")))
		$oSettings[Graph default height:K82:16]:=600  //  default 400 (pie=600)
	End if 
	
	If (Not:C34(OB Is defined:C1231($oSettings; "Graph default width")))
		$oSettings[Graph default width:K82:15]:=800  // default 600 (pie=800)
	End if 
	
	If (Not:C34(OB Is defined:C1231($oSettings; "Graph display legend")))
		$oSettings[Graph display legend:K82:10]:=False:C215
	End if 
	
	If (Not:C34(OB Is defined:C1231($oSettings; "Graph background color")))
		$oSettings[Graph background color:K82:34]:="#FFFFFF"
	End if 
	
	If (Not:C34(OB Is defined:C1231($oSettings; "Graph background opacity")))
		$oSettings[Graph background opacity:K82:36]:=0
	End if 
	
	If (Not:C34(OB Is defined:C1231($oSettings; "Graph font color")))
		$oSettings[Graph font color:K82:21]:="#AAAAAA"
	End if 
	
	If (Not:C34(OB Is defined:C1231($oSettings; "Graph left margin")))
		$oSettings[Graph left margin:K82:11]:=12  //  default 12
	End if 
	
	// Graph legend font color
	
	// Graph legend icon gap //  default Graph legend icon height/2
	
	// Graph legend icon height   //  default 20
	
	// Graph legend icon width  //  default 20
	
	// Graph legend labels
	
	If (Not:C34(OB Is defined:C1231($oSettings; "Graph line width")))
		$oSettings[Graph line width:K82:28]:=1  //  only for Line, default 2
	End if 
	
	If (Not:C34(OB Is defined:C1231($oSettings; "Graph pie direction")))
		$oSettings[Graph pie direction:K82:38]:=1  //  only for Pie, default 1
	End if 
	
	If (Not:C34(OB Is defined:C1231($oSettings; "Graph pie font size")))
		$oSettings[Graph pie font size:K82:29]:=16  //  only for Pie, default 16
	End if 
	
	If (Not:C34(OB Is defined:C1231($oSettings; "Graph pie shift")))
		$oSettings[Graph pie shift:K82:30]:=8  //  only for Pie, default 8
	End if 
	
	If (Not:C34(OB Is defined:C1231($oSettings; "Graph pie start angle")))
		$oSettings[Graph pie start angle:K82:39]:=0  //  only for Pie, default 0
	End if 
	
	// Graph plot height  //  only for Line, default 12
	
	// Graph plot radius  //  only for Scatter, default 12
	
	// Graph plot width  //  only for Line, default 12
	
	If (Not:C34(OB Is defined:C1231($oSettings; "Graph right margin")))
		$oSettings[Graph right margin:K82:12]:=2  //  default 2
	End if 
	
	If (Not:C34(OB Is defined:C1231($oSettings; "Graph top margin")))
		$oSettings[Graph top margin:K82:13]:=2  //  default 2
	End if 
	
	If (Not:C34(OB Is defined:C1231($oSettings; "Graph xGrid")))
		$oSettings[Graph xGrid:K82:8]:=False:C215  //  all types except Pie
	End if 
	
	// Graph xMax //  only for Line, Surface, Scatter
	
	// Graph xMin //  only for Line, Surface, Scatter
	
	// Graph xProp  //  only for Line, Surface, Scatter
	
	If (Not:C34(OB Is defined:C1231($oSettings; "Graph yGrid")))
		$oSettings[Graph yGrid:K82:9]:=True:C214  //  all types except Pie
	End if 
	
	// Graph yMax  //  all types except Pie
	
	// Graph yMin  //  all types except Pie
	
End if 

// Graphs a maximum of 8 sets of values (ignores greater than 8)
GRAPH:C169($graphPtr->; $oSettings; $xArrPtr->; $valuePtr->)  //Draw graph