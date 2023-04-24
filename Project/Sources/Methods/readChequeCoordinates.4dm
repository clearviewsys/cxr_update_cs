//%attributes = {}
// readChequeCoordinates(fileName)


C_POINTER:C301($objectPtr)
C_TEXT:C284($1; $objectName)
C_TIME:C306($vhDocRef)
C_REAL:C285($r)

$r:=29.45  // number of pixels in a cm

C_TEXT:C284($title; $newLine; $type; $originTop; $originLeft)
C_TEXT:C284($left; $top; $width; $height)
C_TEXT:C284($comments)
C_REAL:C285($originTopN; $originLeftN)
C_REAL:C285($lefNt; $topN; $widthN; $heightN; $leftN)

If (Test path name:C476(getSupportFilesPath+$1)=Is a document:K24:1)
	
	$vhDocRef:=Open document:C264(getSupportFilesPath+$1; "")  // Open a TEXT document
	
	If (OK=1)  // If the document was opened
		
		RECEIVE PACKET:C104($vhDocRef; $comments; "//")  // Read label of field till you see a ; 
		RECEIVE PACKET:C104($vhDocRef; $title; ";")  // Read label of field till you see a ; 
		RECEIVE PACKET:C104($vhDocRef; $originLeft; ";")  // read origin left
		RECEIVE PACKET:C104($vhDocRef; $originTop; ";")  // 
		RECEIVE PACKET:C104($vhDocRef; $newLine; 1)  // 
		
		$originTopN:=Num:C11($originTop)*$r
		$originLeftN:=Num:C11($originLeft)*$r
		
		Repeat   // Loop until no more data 
			
			RECEIVE PACKET:C104($vhDocRef; $type; ";")  // Read label of field till you see a ; 
			RECEIVE PACKET:C104($vhDocRef; $title; ";")  // Read label of field till you see a ; 
			
			// now read the coordinates LEFT, TOP, WIDTH, HEIGHT
			
			
			RECEIVE PACKET:C104($vhDocRef; $left; ";")  // Do same as above for second field 
			RECEIVE PACKET:C104($vhDocRef; $top; ";")  // Do same as above for second field 
			RECEIVE PACKET:C104($vhDocRef; $width; ";")  // Do same as above for second field 
			RECEIVE PACKET:C104($vhDocRef; $height; ";")  // Do same as above for second field 
			RECEIVE PACKET:C104($vhDocRef; $newLine; 1)  // Do same as above for second field 
			
			$leftN:=($r*Num:C11($left))+$originLeftN
			$topN:=($r*Num:C11($top))+$originTopN
			$widthN:=Num:C11($width)*$r
			$heightN:=Num:C11($height)*$r
			
			If (OK=1)  // If we are not beyond the end of the document
				
				// find a pointer to the variable
				
				Case of 
					: ($type="F")  // fields
						
						$objectPtr:=getFieldNamePtr(Table:C252(->[Registers:10]); $title)
						OBJECT MOVE:C664($objectPtr->; $leftN; $topN; $leftN+$widthN; $topN+$heightN; *)
						// move the variable
						
					: ($type="V")  // variables
						
						$objectPtr:=Get pointer:C304($title)
						OBJECT MOVE:C664($objectPtr->; $leftN; $topN; $leftN+$widthN; $topN+$heightN; *)
						// move the variable
						
					: ($type="*")  // objects
						
						OBJECT MOVE:C664(*; $title; $leftN; $topN; $leftN+$widthN; $topN+$heightN; *)
						// move the variable
						
				End case 
				
				
			End if 
		Until (OK=0)
		CLOSE DOCUMENT:C267($vhDocRef)  // Close the document   
		
	End if 
	
Else 
	
	myAlert("Couldn't find template file: \n\n"+getSupportFilesPath+$1)
	
End if 
