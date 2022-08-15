//%attributes = {}
// ----------------------------------------------------
// User name (OS): John J Foster
// Date and time: 10/28/20, 10:02:48
// ----------------------------------------------------
// Method: Graph_Draw_BarChart ($graphPtr;->$arrX;->$arrY;$oSettings)
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
		$oSettings[Graph type:K82:1]:=1
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
	
	If (Not:C34(OB Is defined:C1231($oSettings; "Graph column gap")))
		$oSettings[Graph column gap:K82:19]:=12  //  only for Bar, Proportional, Stacked, default 12
	End if 
	
	If (Not:C34(OB Is defined:C1231($oSettings; "Graph column width max")))
		$oSettings[Graph column width max:K82:18]:=200  //  only for Bar, Proportional, Stacked, default 200
	End if 
	
	If (Not:C34(OB Is defined:C1231($oSettings; "Graph column width min")))
		$oSettings[Graph column width min:K82:17]:=10  //  only for Bar, Proportional, Stacked, default 10
	End if 
	
	If (Not:C34(OB Is defined:C1231($oSettings; "Graph default height")))
		$oSettings[Graph default height:K82:16]:=400  //  default 400 (pie=600)
	End if 
	
	If (Not:C34(OB Is defined:C1231($oSettings; "Graph default width")))
		$oSettings[Graph default width:K82:15]:=600  // default 600 (pie=800)
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
		$oSettings[Graph line width:K82:28]:=0  //  only for Line, default 2
	End if 
	
	// Graph pie direction  //  only for Pie, default 1
	
	// Graph pie font size  //  only for Pie, default 16
	
	// Graph pie shift  //  only for Pie, default 8
	
	// Graph pie start angle  //  only for Pie, default 0
	
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

GRAPH:C169($graphPtr->; $oSettings; $xArrPtr->; $valuePtr->)  //Draw graph
