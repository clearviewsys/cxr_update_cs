//%attributes = {}
//TextMatrixToSelection ($pointervalues;$fieldPointer)
//this was part of the component for CSV

C_POINTER:C301($1; $2)
ASSERT:C1129(Count parameters:C259>1)
ASSERT:C1129(Not:C34(Is nil pointer:C315($1)))
ASSERT:C1129(Not:C34(Is nil pointer:C315($2)))
ASSERT:C1129(Type:C295($1->)=Array 2D:K8:24)
ASSERT:C1129(Type:C295($1->{0})=Text array:K8:16)
ASSERT:C1129(Type:C295($2->)=Pointer array:K8:23)

ARRAY TEXT:C222($values; 0; 0)
COPY ARRAY:C226($1->; $values)

ARRAY POINTER:C280($fieldPtrs; 0)
COPY ARRAY:C226($2->; $fieldPtrs)

C_BOOLEAN:C305($ready)
$ready:=False:C215  //used to protect closing ARRAY TO SELECTION

//temp arrays to hold type cast values
ARRAY LONGINT:C221($al; 0; 0)
ARRAY INTEGER:C220($ai; 0; 0)
ARRAY REAL:C219($ar; 0; 0)
ARRAY BOOLEAN:C223($ab; 0; 0)
ARRAY TIME:C1223($ah; 0; 0)
ARRAY DATE:C224($ad; 0; 0)

C_OBJECT:C1216($o)  //temp object to type cast array
C_LONGINT:C283($valuesCount; $fieldsCount; $count)
$valuesCount:=Size of array:C274($values)
$fieldsCount:=Size of array:C274($fieldPtrs)

If ($fieldsCount<$valuesCount)
	$count:=$fieldsCount
Else 
	$count:=$valuesCount
End if 

C_LONGINT:C283($i; $fieldType; $j)
C_BOOLEAN:C305($ready; $GMT)

For ($i; 1; $count)
	
	$fieldType:=Type:C295($fieldPtrs{$i}->)
	
	Case of 
		: ($fieldType=Is longint:K8:6)
			
			OB SET ARRAY:C1227($o; "a"; $values{$i})
			INSERT IN ARRAY:C227($al; 1)
			OB GET ARRAY:C1229($o; "a"; $al{1})
			CLEAR VARIABLE:C89($o)
			ARRAY TO SELECTION:C261($al{1}; $fieldPtrs{$i}->; *)
			$ready:=True:C214
			
		: ($fieldType=Is integer:K8:5)
			
			OB SET ARRAY:C1227($o; "a"; $values{$i})
			INSERT IN ARRAY:C227($ai; 1)
			OB GET ARRAY:C1229($o; "a"; $ai{1})
			CLEAR VARIABLE:C89($o)
			ARRAY TO SELECTION:C261($ai{1}; $fieldPtrs{$i}->; *)
			$ready:=True:C214
			
		: ($fieldType=Is real:K8:4)
			
			OB SET ARRAY:C1227($o; "a"; $values{$i})
			INSERT IN ARRAY:C227($ar; 1)
			OB GET ARRAY:C1229($o; "a"; $ar{1})
			CLEAR VARIABLE:C89($o)
			ARRAY TO SELECTION:C261($ar{1}; $fieldPtrs{$i}->; *)
			$ready:=True:C214
			
		: ($fieldType=Is text:K8:3) | ($fieldType=Is alpha field:K8:1)
			
			ARRAY TO SELECTION:C261($values{$i}; $fieldPtrs{$i}->; *)
			$ready:=True:C214
			
		: ($fieldType=Is boolean:K8:9)
			
			For ($j; 1; Size of array:C274($values{$i}))
				If ($values{$i}{$j}=String:C10(False:C215))
					$values{$i}{$j}:=""
				End if 
			End for 
			
			OB SET ARRAY:C1227($o; "a"; $values{$i})
			INSERT IN ARRAY:C227($ab; 1)
			OB GET ARRAY:C1229($o; "a"; $ab{1})
			CLEAR VARIABLE:C89($o)
			ARRAY TO SELECTION:C261($ab{1}; $fieldPtrs{$i}->; *)
			$ready:=True:C214
			
		: ($fieldType=Is time:K8:8)
			
			For ($j; 1; Size of array:C274($values{$i}))
				If (Match regex:C1019("\\d{1,2}(\\D)\\d{1,2}\\1\\d{1,2}"; $values{$i}{$j}; *))
					$values{$i}{$j}:=String:C10(0+Time:C179($values{$i}{$j}))+"000"  //time to milliseconds
				End if 
			End for 
			
			OB SET ARRAY:C1227($o; "a"; $values{$i})
			INSERT IN ARRAY:C227($ah; 1)
			OB GET ARRAY:C1229($o; "a"; $ah{1})
			CLEAR VARIABLE:C89($o)
			ARRAY TO SELECTION:C261($ah{1}; $fieldPtrs{$i}->; *)
			$ready:=True:C214
			
		: ($fieldType=Is date:K8:7)
			
			//if 1 (default), the date is converted on retrival, hence we need to use GMT
			$GMT:=(1=Get database parameter:C643(Dates inside objects:K37:73))
			
			For ($j; 1; Size of array:C274($values{$i}))
				If (Match regex:C1019("\\d{1,4}(\\D)\\d{1,4}\\1\\d{1,4}"; $values{$i}{$j}; *))
					If ($GMT)
						$values{$i}{$j}:=String:C10(Date:C102($values{$i}{$j}); ISO date GMT:K1:10)
					Else 
						$values{$i}{$j}:=String:C10(Date:C102($values{$i}{$j}); ISO date:K1:8)
					End if 
				End if 
			End for 
			
			OB SET ARRAY:C1227($o; "a"; $values{$i})
			INSERT IN ARRAY:C227($ad; 1)
			OB GET ARRAY:C1229($o; "a"; $ad{1})
			CLEAR VARIABLE:C89($o)
			ARRAY TO SELECTION:C261($ad{1}; $fieldPtrs{$i}->; *)
			$ready:=True:C214
			
		Else 
			
	End case 
	
End for 

If ($ready)
	ARRAY TO SELECTION:C261
End if 