//%attributes = {}
// ----------------------------------------------------
// User name (OS): Milan Adamov
// Date and time: 05/01/09, 13:24:12
// ----------------------------------
// Modified by: Milan Adamov (17/09/19) -- added code for object field type
// ------------------
// Method: UTIL_Record_to_BLOB
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
C_LONGINT:C283($i; $NumFields)
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

If (Count parameters:C259>=2)  // (Two mandatory parameters)
	
	$TableNum:=$1
	$BLOB_ptr:=$2
	$Table_ptr:=Table:C252($TableNum)
	
	If ((Record number:C243($Table_ptr->)>=0) | (Is new record:C668($Table_ptr->)))
		
		$NumFields:=Get last field number:C255($TableNum)
		VARIABLE TO BLOB:C532($NumFields; $Record_x; *)
		
		For ($i; 1; $NumFields)
			
			If (Is field number valid:C1000($TableNum; $i))
				// Get the type of the field
				GET FIELD PROPERTIES:C258($TableNum; $i; $FieldType_l)
				// Get a pointer to the field
				$Field_ptr:=Field:C253($TableNum; $i)
				
				// Depending on the type of the field, copy (or not) its data in the appropriate manner
				Case of 
					: (($FieldType_l=Is alpha field:K8:1) | ($FieldType_l=Is text:K8:3))
						$TextVar_t:=$Field_ptr->
						CONVERT FROM TEXT:C1011($Field_ptr->; "UTF-16"; $BlobVar_b)  // force UTF-16 if not in Unicode mode
						VARIABLE TO BLOB:C532($BlobVar_b; $Record_x; *)
						
					: ($FieldType_l=Is real:K8:4)
						$RealVar_r:=$Field_ptr->
						VARIABLE TO BLOB:C532($RealVar_r; $Record_x; *)
						
					: (($FieldType_l=Is integer:K8:5) | ($FieldType_l=Is longint:K8:6))
						$LongintVar_l:=$Field_ptr->
						VARIABLE TO BLOB:C532($LongintVar_l; $Record_x; *)
						
					: ($FieldType_l=Is date:K8:7)
						$DateVar_d:=$Field_ptr->
						VARIABLE TO BLOB:C532($DateVar_d; $Record_x; *)
						
					: ($FieldType_l=Is time:K8:8)
						$TimeVar_h:=$Field_ptr->
						VARIABLE TO BLOB:C532($TimeVar_h; $Record_x; *)
						
					: ($FieldType_l=Is boolean:K8:9)
						$BooleanVar_b:=$Field_ptr->
						VARIABLE TO BLOB:C532($BooleanVar_b; $Record_x; *)
						
					: ($FieldType_l=Is picture:K8:10)
						$PictureVar_pict:=$Field_ptr->
						VARIABLE TO BLOB:C532($PictureVar_pict; $Record_x; *)
						
					: ($FieldType_l=Is BLOB:K8:12)
						$BlobVar_b:=$Field_ptr->
						VARIABLE TO BLOB:C532($BlobVar_b; $Record_x; *)
						
					: ($FieldType_l=Is object:K8:27)
						$ObjectVar_obj:=$Field_ptr->
						VARIABLE TO BLOB:C532($ObjectVar_obj; $Record_x; *)
						
					Else 
						
						
				End case 
				
			End if 
		End for 
		
		$Err:=0
		$BLOB_ptr->:=$Record_x
		
	Else 
		$Err:=-2
	End if 
	
Else 
	$Err:=-1
End if 

$0:=$Err
