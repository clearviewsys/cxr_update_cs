//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 01/28/12, 08:29:17
// Copyright 2009 -- IBB Consulting, LLC
// ----------------------------------------------------
// Method: webBuildCompilerWeb
// Description
// 
//     builds a compiler web code on clipboard

// Parameters
// ----------------------------------------------------


C_TEXT:C284($compilerWeb)

$compilerWeb:=""
C_LONGINT:C283($i; $j; $type)
C_POINTER:C301($fieldPtr)
For ($i; 1; Get last table number:C254)
	If (Is table number valid:C999($i))
		
		For ($j; 1; Get last field number:C255($i))
			If (Is field number valid:C1000($i; $j))
				//$theVarPtr:=Get pointer("web"+Field name($i;$j))
				//$theVarPtr->:=""
				
				$fieldPtr:=Field:C253($i; $j)
				$type:=Type:C295($fieldPtr->)
				
				Case of 
					: ($type=Is alpha field:K8:1)
						$compilerWeb:=$compilerWeb+"C_STRING(80;"+"web"+Field name:C257($i; $j)+")"
					: ($type=Is text:K8:3)
						$compilerWeb:=$compilerWeb+"C_TEXT("+"web"+Field name:C257($i; $j)+")"
					: ($type=Is date:K8:7)
						$compilerWeb:=$compilerWeb+"C_DATE("+"web"+Field name:C257($i; $j)+")"
						
					: ($type=Is time:K8:8)
						$compilerWeb:=$compilerWeb+"C_TIME("+"web"+Field name:C257($i; $j)+")"
						
					: ($type=Is boolean:K8:9)
						$compilerWeb:=$compilerWeb+"C_BOOLEAN("+"web"+Field name:C257($i; $j)+")"
						
					: ($type=Is integer:K8:5)
						$compilerWeb:=$compilerWeb+"C_INTEGER("+"web"+Field name:C257($i; $j)+")"
						
					: ($type=Is longint:K8:6)
						$compilerWeb:=$compilerWeb+"C_LONGINT("+"web"+Field name:C257($i; $j)+")"
						
					: ($type=Is real:K8:4)
						$compilerWeb:=$compilerWeb+"C_REAL("+"web"+Field name:C257($i; $j)+")"
						
					: ($type=Is BLOB:K8:12)
						$compilerWeb:=$compilerWeb+"C_BLOB("+"web"+Field name:C257($i; $j)+")"
						
					: ($type=Is picture:K8:10)
						$compilerWeb:=$compilerWeb+"C_PICTURE("+"web"+Field name:C257($i; $j)+")"
						
						
					Else 
						TRACE:C157
						
						//: ($type=Is Integer 64 bits)
						//$compilerWeb:=$compilerWeb+"C_TEXT("+"web"+Field name($i;$j)+")"
						//
						//: ($type=Is Float)
						//$compilerWeb:=$compilerWeb+"C_TEXT("+"web"+Field name($i;$j)+")"
						
				End case 
				
				$compilerWeb:=$compilerWeb+Char:C90(Carriage return:K15:38)
				
			End if 
		End for 
		
		
	End if 
End for 

SET TEXT TO PASTEBOARD:C523($compilerWeb)

myAlert("COMPILER_WEB is on the clipboard. Paste into your method.")
