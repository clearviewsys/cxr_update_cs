//%attributes = {}
// OCR_ScanPicture ( ->textArray; ->fieldPtr; {$language=eng}; {$isOverlayRequired=false};  {$apiKey}; {$apiURL}; )
// Scan a Picture field and return the texts included on it
// Created By CVS Dev. Team, 04/22/2017
// TODO: Fix Objects


C_POINTER:C301($1; $arrPtr; $2; $fieldPtr)
C_TEXT:C284($3; $language)
C_BOOLEAN:C305($4; $isOverlayRequired; $isErroredOnProcessing)
C_TEXT:C284($5; $apiKey; $6; $url; $errorMsg; $errorMessage; $errorDetails; $tmpDir; $ParsedText)

C_BLOB:C604($sourceBlob)
C_TEXT:C284($base64Text; $jsonResult; $tValue)
C_TEXT:C284($fileName; $inputStream; $errorStream; $outputStream; $cmd; $tmpFileName)

C_LONGINT:C283($httpResult; $platform; $i; $OCRExitCode)
C_OBJECT:C1216($response)

ARRAY TEXT:C222($headerNames; 0)
ARRAY TEXT:C222($headerValues; 0)

C_TEXT:C284($API_KEY; $OCR_URL; $url; $5sss)

C_OBJECT:C1216($resultObj)
C_TEXT:C284($tValue)


// -----------------------------------------------------------------------------------
// API Documentation: https://ocr.space/ocrapi#content-tab-2-1
// TODO: Create preference

$API_KEY:="PKMXB3710888A"
$OCR_URL:="http://apipro1.ocr.space/parse/image"  // It is possible a change in the future

// -----------------------------------------------------------------------------------

Case of 
		
		
	: (Count parameters:C259=2)
		
		$arrPtr:=$1
		$fieldPtr:=$2
		$language:="eng"
		$isOverlayRequired:=False:C215
		$apiKey:=$API_KEY
		$url:=$OCR_URL
		
	: (Count parameters:C259=3)
		
		$arrPtr:=$1
		$fieldPtr:=$2
		$language:=$3
		$isOverlayRequired:=False:C215
		$apiKey:=$API_KEY
		$url:=$OCR_URL
		
		
	: (Count parameters:C259=4)
		
		$arrPtr:=$1
		$fieldPtr:=$2
		$language:=$3
		$isOverlayRequired:=$4
		$apiKey:=$API_KEY
		$url:=$OCR_URL
		
		
	: (Count parameters:C259=5)
		
		$arrPtr:=$1
		$fieldPtr:=$2
		$language:=$3
		$isOverlayRequired:=$4
		$apiKey:=$5
		$url:=$OCR_URL
		
	: (Count parameters:C259=6)
		
		$arrPtr:=$1
		$fieldPtr:=$2
		$language:=$3
		$isOverlayRequired:=$4
		$apiKey:=$5sss
		$url:=$6
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


$tmpDir:=System folder:C487(Desktop:K41:16)+"tmp"
If (Test path name:C476($tmpDir)#Is a folder:K24:2)
	CREATE FOLDER:C475($tmpDir)
End if 

$fileName:=$tmpDir+Folder separator:K24:12+"pic"+String:C10(Random:C100)+".jpg"
If (Is Windows:C1573)
	$cmd:=Char:C90(Double quote:K15:41)+Get 4D folder:C485(Current resources folder:K5:16)+"commands"+Folder separator:K24:12+"curl.exe"+Char:C90(Double quote:K15:41)
Else 
	$cmd:=Char:C90(Double quote:K15:41)+"/usr/bin/curl"+Char:C90(Double quote:K15:41)
End if 


PICTURE TO BLOB:C692($fieldPtr->; $sourceBlob; ".jpg")
BLOB TO DOCUMENT:C526($fileName; $sourceBlob)

$tmpFileName:=Convert path system to POSIX:C1106($fileName)

If (OK=1)
	APPEND TO ARRAY:C911($headerNames; "apikey")
	APPEND TO ARRAY:C911($headerValues; $apiKey)
	
	CLEAR VARIABLE:C89($response)
	
	$cmd:=$cmd+" -H "+Char:C90(Double quote:K15:41)+"apikey:"+$apikey+Char:C90(Double quote:K15:41)
	$cmd:=$cmd+" -F "+Char:C90(Double quote:K15:41)+"file="+Char:C90(At sign:K15:46)+$tmpFileName+Char:C90(Double quote:K15:41)
	$cmd:=$cmd+" -F "+Char:C90(Double quote:K15:41)+"language="+$language+Char:C90(Double quote:K15:41)
	If ($isOverlayRequired)
		$cmd:=$cmd+" -F "+Char:C90(Double quote:K15:41)+"isOverlayRequired=true"+Char:C90(Double quote:K15:41)
	Else 
		$cmd:=$cmd+" -F "+Char:C90(Double quote:K15:41)+"isOverlayRequired=false"+Char:C90(Double quote:K15:41)
	End if 
	$cmd:=$cmd+" -m 30 "  // time out
	$cmd:=$cmd+$url
	
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_BLOCKING_EXTERNAL_PROCESS"; "true")  // Sync Mode
	
	LAUNCH EXTERNAL PROCESS:C811($cmd; $inputStream; $outputStream; $errorStream)
	
	
	If (Length:C16($outputStream)>0)
		
		$response:=JSON Parse:C1218($outputStream)
		
		
		If (Not:C34(OB Is empty:C1297($response)))
			
			$resultObj:=OB Copy:C1225($response)
			$tValue:=OB Get:C1224($resultObj; "OCRExitCode")
			
			$OCRExitCode:=OB Get:C1224($response; "OCRExitCode"; Is longint:K8:6)
			$isErroredOnProcessing:=OB Get:C1224($response; "IsErroredOnProcessing"; Is boolean:K8:9)
			$errorMessage:=OB Get:C1224($response; "ErrorMessage")
			$errorDetails:=OB Get:C1224($response; "ErrorDetails")
			
			Case of 
					
				: ($isErroredOnProcessing=False:C215)
					
					Case of 
							
							// 1: Parsed Successfully (Image / All pages parsed successfully)
							// 2: Parsed Partially (Only few pages out of all the pages parsed successfully)
							
						: (($OCRExitCode=1) | ($OCRExitCode=2))
							
							ARRAY OBJECT:C1221($arrParsedResults; 0)
							
							OB GET ARRAY:C1229($response; "ParsedResults"; $arrParsedResults)
							
							For ($i; 1; Size of array:C274($arrParsedResults))
								$errorMsg:=OB Get:C1224($arrParsedResults{$i}; "ErrorMessage")
								
								If ($errorMsg="")
									
									$ParsedText:=OB Get:C1224($arrParsedResults{$i}; "ParsedText")
									
									//SET TEXT TO PASTEBOARD($ParsedText)
									$ParsedText:=Replace string:C233($ParsedText; Char:C90(CR ASCII code:K15:14)+Char:C90(LF ASCII code:K15:11); "|")
									$ParsedText:=Replace string:C233($ParsedText; Char:C90(LF ASCII code:K15:11); "")
									$ParsedText:=Replace string:C233($ParsedText; " |"; "|")
									
									OCR_ExplodeString($ParsedText; "|"; $arrPtr)
								Else 
									myAlert($errorMsg)
								End if 
								
							End for 
							
						Else 
							myAlert("Image could not be Parsed Successfully")
							
					End case 
					
				: ($isErroredOnProcessing)
					
					// 3: Image / All the PDF pages failed parsing (This happens maily because the Parsing engine fails to parse an image)
					// 4: Error occurred when attempting to parse (This happens when a fatal error occurs during parsing image / PDF)
					Case of 
							
						: (($OCRExitCode=3) | ($OCRExitCode=4))
							
							$errorMsg:=""
							
							If ($errorMessage#"")
								$errorMsg:=$errorMessage
							End if 
							
							If ($errorDetails#"")
								$errorMsg:=$errorMsg+"\n"+$errorDetails
							End if 
							myAlert($errorMsg)
							
						Else 
							myAlert("Image could not be Parsed Successfully")
							
					End case 
					
			End case 
			
			
			DELETE DOCUMENT:C159($fileName)
		Else 
			myAlert("Image could not be Scanned Successfully. Please try again")
		End if 
		
	Else 
		myAlert("Image could not be Scanned Successfully. Please try again")
	End if 
	
Else 
	myAlert("Image could not be Saved Successfully in temporary folder. Please try again")
End if 


