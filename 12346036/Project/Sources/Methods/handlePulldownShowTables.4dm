//%attributes = {}
// handlePullDownShowTables (self: pulldownobject)

C_POINTER:C301($pdArrayPtr; $1)
$pdArrayPtr:=$1

If (Form event code:C388=On Load:K2:1)
	C_LONGINT:C283($n)
	C_BOOLEAN:C305($isHidden)
	C_LONGINT:C283($i; $hiddenCount)
	
	$n:=Get last table number:C254
	
	//ARRAY TEXT($pdArrayPtr->;$n)  // resize the pointer
	//ARRAY LONGINT(arrTableNums;$n)
	ARRAY TEXT:C222($pdArrayPtr->; 0)  // resize the pointer
	ARRAY LONGINT:C221(arrTableNums; 0)
	
	//$hiddenCount:=0
	
	For ($i; 1; $n)
		If (Is table number valid:C999($i))  // Jan 16, 2012 17:40:08 -- I.Barclay Berry 
			GET TABLE PROPERTIES:C687($i; $isHidden)
			If (Not:C34($isHidden)) & (Table name:C256($i)#"")  //6/27/19 added not ""
				APPEND TO ARRAY:C911($pdArrayPtr->; getElegantTableName(Table:C252($i)))
				APPEND TO ARRAY:C911(arrTableNums; $i)
				//$pdArrayPtr->{$i-$hiddenCount}:=getElegantTableName (Table($i))
				//arrTableNums{$i-$hiddenCount}:=$i
			Else 
				//$hiddenCount:=$hiddenCount+1
			End if 
		End if 
	End for 
	
	//ARRAY TEXT($pdArrayPtr->;$n-$hiddenCount)  // resize the pointer
	//ARRAY LONGINT(arrTableNums;$n-$hiddenCount)
	SORT ARRAY:C229($pdArrayPtr->; arrTableNums)
End if 

If (Form event code:C388=On Clicked:K2:4)
	If ($pdArrayPtr->>0)
		setErrorTrap("")  // in case the method doesn't exist
		displayLBox(Table:C252(arrTableNums{$pdArrayPtr->}))
		endErrorTrap
	End if 
End if 

If (Form event code:C388=On Unload:K2:2)
	ARRAY LONGINT:C221(arrTableNums; 0)  // release memory
End if 
