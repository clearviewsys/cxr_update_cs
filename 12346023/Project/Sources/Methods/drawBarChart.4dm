//%attributes = {}


C_POINTER:C301($graphPtr; $xArrPtr; $valuePtr)
C_OBJECT:C1216($settings)  //Initialize graph settings

Case of 
	: (Count parameters:C259=3)
		$graphPtr:=$1
		$xArrPtr:=$2
		$valuePtr:=$3
	: (Count parameters:C259=4)
		$graphPtr:=$1
		$xArrPtr:=$2
		$valuePtr:=$3
		$settings:=$4
	Else 
		
End case 

If (Count parameters:C259=3)
	$settings:=New object:C1471
	$settings[Graph type:K82:1]:=1
	$settings[Graph background color:K82:34]:="#FFFFFF"
	$settings[Graph yGrid:K82:9]:=False:C215
	$settings[Graph display legend:K82:10]:=False:C215
	$settings[Graph background shadow color:K82:35]:="#FFFFFF"
	$settings[Graph background opacity:K82:36]:=0
	$settings[Graph document background opacity:K82:24]:=0
	$settings[Graph colors:K82:22]:="#EFEFFF"
	$settings[Graph document background color:K82:23]:="#FFFFFF"
	$settings[Graph font color:K82:21]:="#AAAAAA"
	$settings[Graph line width:K82:28]:=0
	$settings[Graph xGrid:K82:8]:=False:C215
	$settings[Graph yGrid:K82:9]:=True:C214
End if 

GRAPH:C169($graphPtr->; $settings; $xArrPtr->; $valuePtr->)  //Draw graph
