If (False:C215)
	ARRAY TEXT:C222(arrWorkstationDetection; 5)
End if 

//[ServerSettings]WorkstationDetectionMethod:=arrWorkstationDetection{arrWorkstationDetection}
bindPopUpToIntegerField(Self:C308; ->[ServerPrefs:27]WorkstationDetectionMethod:76)

