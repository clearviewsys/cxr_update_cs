// handlePullDownShowTables (self: pulldownobject)

C_POINTER:C301($pdArrayPtr)  //;$1)

$pdArrayPtr:=Self:C308

If (Form event code:C388=On Load:K2:1)
	C_LONGINT:C283($n)
	C_BOOLEAN:C305($isHidden)
	$n:=Get last table number:C254
	ARRAY TEXT:C222(arrModuleNames; $n)  // resize the pointer
	ARRAY LONGINT:C221(arrTableNums; $n)
	ARRAY PICTURE:C279(arrModuleIcons; $n)
	C_LONGINT:C283($i; $hiddenCount)
	$hiddenCount:=0
	For ($i; 1; $n)
		If (Is table number valid:C999($i))  // Jan 16, 2012 17:41:49 -- I.Barclay Berry 
			GET TABLE PROPERTIES:C687($i; $isHidden)
			If (Not:C34($isHidden))
				arrModuleNames{$i-$hiddenCount}:=getElegantTableName(Table:C252($i))
				C_PICTURE:C286($icon)
				loadPictureResource("_"+Table name:C256($i); ->$icon)
				//GET PICTURE FROM LIBRARY("_"+Table name($i); $icon)
				arrModuleIcons{$i-$hiddenCount}:=$icon
				arrTableNums{$i-$hiddenCount}:=$i
				CLEAR VARIABLE:C89($icon)
			Else 
				$hiddenCount:=$hiddenCount+1
			End if 
		End if 
	End for 
	ARRAY TEXT:C222(arrModuleNames; $n-$hiddenCount)  // resize the pointer
	ARRAY LONGINT:C221(arrTableNums; $n-$hiddenCount)
	ARRAY PICTURE:C279(arrModuleIcons; $n-$hiddenCount)
	
	//SORT ARRAY(arrModuleNames;arrTableNums)
End if 

If (Form event code:C388=On Clicked:K2:4)
	C_LONGINT:C283($rowClicked)
	C_POINTER:C301($tablePtr)
	
	$rowClicked:=getListBoxRowNumber($pdArrayPtr)
	$tablePtr:=Table:C252(arrTableNums{$rowClicked})
	displayList($tablePtr)
End if 

If (Form event code:C388=On Unload:K2:2)
	ARRAY TEXT:C222(arrModuleNames; 0)
	ARRAY LONGINT:C221(arrTableNums; 0)
	ARRAY PICTURE:C279(arrModuleIcons; 0)
End if 