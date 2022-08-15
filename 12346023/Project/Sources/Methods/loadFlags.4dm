//%attributes = {}

C_LONGINT:C283($i; $n)
C_TEXT:C284($path; $fileName)
C_PICTURE:C286($pic)

ALL RECORDS:C47([Flags:19])
$n:=Records in selection:C76([Flags:19])
$path:=Select folder:C670("Flags"; "")
If (OK=1)
	READ WRITE:C146([Flags:19])
	For ($i; 1; $n)
		GOTO SELECTED RECORD:C245([Flags:19]; $i)
		//LOAD RECORD([Flags])
		$fileName:=$path+[Flags:19]CurrencyCode:1+".jpg"
		If (Test path name:C476($fileName)=Is a document:K24:1)
			loadPicture($fileName; ->$pic)
			[Flags:19]flag:4:=$pic
			SAVE RECORD:C53([Flags:19])
		End if 
		GOTO SELECTED RECORD:C245([Flags:19]; $i)
		SAVE RECORD:C53([Flags:19])
		UNLOAD RECORD:C212([Flags:19])
	End for 
	
	READ ONLY:C145([Flags:19])
End if 
