//%attributes = {}
// ----------------------------------------------------
// User name (OS): Milan Adamov
// Date and time: 05/01/09, 13:44:19
// ----------------------------------------------------
// Modified by: Milan Adamov (17/09/19) -- added code for object field type
// ------------------
// Method: UTIL_BLOB_to_Record
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1; $TableNum)
C_POINTER:C301($2; $BLOB_ptr)
C_LONGINT:C283($0; $Err)
$Err:=0

C_LONGINT:C283($FieldNum_l; $FieldType_l)
C_LONGINT:C283($i; $NumFields; $NumFieldsInBLOB; $Offset)
C_POINTER:C301($Table_ptr; $Field_ptr)
C_BLOB:C604($Record_x)
SET BLOB SIZE:C606($Record_x; 0)

// ---- temporary variables to build the Blob ---
C_TEXT:C284($TextVar_t)
C_LONGINT:C283($LongintVar_l)
C_REAL:C285($RealVar_r)
C_PICTURE:C286($PictureVar_pict)
C_DATE:C307($DateVar_d)
C_TIME:C306($TimeVar_h)
C_BOOLEAN:C305($BooleanVar_b)
C_BLOB:C604($BlobVar_b)
C_OBJECT:C1216($ObjectVar_obj)


If (Count parameters:C259>=2)
	
	$TableNum:=$1
	$BLOB_ptr:=$2
	$Table_ptr:=Table:C252($TableNum)
	$Offset:=0
	
	BLOB TO VARIABLE:C533($BLOB_ptr->; $NumFieldsInBLOB; $Offset)
	$NumFields:=Get last field number:C255($TableNum)
	
	If ($NumFieldsInBLOB<=$NumFields)
		
		If ($NumFieldsInBLOB<=$NumFields)
			$Err:=$NumFields-$NumFieldsInBLOB
			$NumFields:=$NumFieldsInBLOB
		End if 
		
		For ($i; 1; $NumFields)
			
			If (Is field number valid:C1000($TableNum; $i))
				// Get the type of the field
				GET FIELD PROPERTIES:C258($TableNum; $i; $FieldType_l)
				// Get a pointer to the field
				$Field_ptr:=Field:C253($TableNum; $i)
				
				// Depending on the type of the field, copy (or not) its data in the appropriate manner
				Case of 
					: (($FieldType_l=Is alpha field:K8:1) | ($FieldType_l=Is text:K8:3))
						BLOB TO VARIABLE:C533($BLOB_ptr->; $Record_x; $Offset)
						$Field_ptr->:=Convert to text:C1012($Record_x; "UTF-16")
						
					: ($FieldType_l=Is real:K8:4)
						BLOB TO VARIABLE:C533($BLOB_ptr->; $RealVar_r; $Offset)
						$Field_ptr->:=$RealVar_r
						
					: (($FieldType_l=Is integer:K8:5) | ($FieldType_l=Is longint:K8:6))
						BLOB TO VARIABLE:C533($BLOB_ptr->; $LongintVar_l; $Offset)
						$Field_ptr->:=$LongintVar_l
						
					: ($FieldType_l=Is date:K8:7)
						BLOB TO VARIABLE:C533($BLOB_ptr->; $DateVar_d; $Offset)
						$Field_ptr->:=$DateVar_d
						
					: ($FieldType_l=Is time:K8:8)
						BLOB TO VARIABLE:C533($BLOB_ptr->; $TimeVar_h; $Offset)
						$Field_ptr->:=$TimeVar_h
						
					: ($FieldType_l=Is boolean:K8:9)
						BLOB TO VARIABLE:C533($BLOB_ptr->; $BooleanVar_b; $Offset)
						$Field_ptr->:=$BooleanVar_b
						
					: ($FieldType_l=Is picture:K8:10)
						BLOB TO VARIABLE:C533($BLOB_ptr->; $PictureVar_pict; $Offset)
						$Field_ptr->:=$PictureVar_pict
						
					: ($FieldType_l=Is BLOB:K8:12)
						BLOB TO VARIABLE:C533($BLOB_ptr->; $BlobVar_b; $Offset)
						$Field_ptr->:=$BlobVar_b
						
					: ($FieldType_l=Is object:K8:27)
						BLOB TO VARIABLE:C533($BLOB_ptr->; $ObjectVar_obj; $Offset)
						$Field_ptr->:=$ObjectVar_obj
						
					Else 
						
						
				End case 
				
			End if 
			
		End for 
		
	Else 
		$Err:=-2
	End if 
Else 
	$Err:=-1
End if 

$0:=$Err
