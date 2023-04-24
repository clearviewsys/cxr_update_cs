//%attributes = {"shared":true}
//C_TEXT($0)

C_OBJECT:C1216($0; $status)

C_LONGINT:C283($iProcess; $i; $ii; $iLength; $iType)
C_BOOLEAN:C305($bIndexed; $bInvisible; $bUnique)
C_TEXT:C284($tMethodName)

C_TEXT:C284($tFieldName; $tTableName)

$status:=New object:C1471
$tMethodName:=Current method name:C684

If (SOAP Request:C783)
	$iProcess:=Execute on server:C373($tMethodName; 0; $tMethodName)
Else 
	
	For ($i; 1; Get last table number:C254)
		If (Is table number valid:C999($i))
			For ($ii; 1; Get last field number:C255($i))
				GET FIELD PROPERTIES:C258($i; $ii; $iType; $iLength; $bIndexed; $bUnique; $bInvisible)
				If ($bIndexed)
					ARRAY POINTER:C280($apFields; 0)
					APPEND TO ARRAY:C911($apFields; Field:C253($i; $ii))
					
					DELETE INDEX:C967(Field:C253($i; $ii))  //will not affect composite indexes
					$tFieldName:=Field name:C257($i; $ii)
					$tTableName:=Table name:C256($i)
					
					Case of 
						: ($tFieldName="_Sync_ID")
							CREATE INDEX:C966(Table:C252($i)->; $apFields; Standard BTree index:K58:3; $tFieldName+"Idx")
						: ($tFieldName="CurrencyCode")
							CREATE INDEX:C966(Table:C252($i)->; $apFields; Standard BTree index:K58:3; $tFieldName+"Idx")
						: ($tFieldName=Substring:C12($tTableName; 1; Length:C16($tTableName)-1)+"ID")
							CREATE INDEX:C966(Table:C252($i)->; $apFields; Standard BTree index:K58:3; $tFieldName+"Idx")
						Else 
							CREATE INDEX:C966(Table:C252($i)->; $apFields; Cluster BTree index:K58:4; $tFieldName+"Idx")
					End case 
					
				End if 
				
			End for 
		End if 
		
	End for 
	
End if 

$status.success:=True:C214
$status.statusText:="Index Rebuild Started"

$0:=$status
//$0:="Index Rebuild Started"