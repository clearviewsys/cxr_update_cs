//%attributes = {}
// CLICK IN COLOR THERMOMETER Project Method

OBJECT SET RGB COLORS:C628(vsColor; 0x00FFFFFF; (thRed << 16)+(thGreen << 8)+thBlue)
vsColorValue:=String:C10((thRed << 16)+(thGreen << 8)+thBlue; "&x")
If (thRed=0)
	vsColorValue:=Substring:C12(vsColorValue; 1; 2)+"0000"+Substring:C12(vsColorValue; 3)
End if 