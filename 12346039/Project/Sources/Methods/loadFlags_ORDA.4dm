//%attributes = {}
// loadFlags
// run this to load all the flags at once. This is like an import
// but only loads the flag pictures into the Flags table
// #ORDA
// loadFlags

C_OBJECT:C1216($eSel; $entity)
C_PICTURE:C286($pic)
C_TEXT:C284($path; $fileName)

$eSel:=ds:C1482.Flags.all().orderBy("CurrencyCode")
//[Flags]CurrencyCode
//[Flags]flag
//[flags];"View"
//[Flags];"Entry"
If ($eSel#Null:C1517)
	$path:=Select folder:C670("Flags"; "")
	If (OK=1)
		For each ($entity; $eSel)
			$fileName:=$path+$entity.CurrencyCode+".jpg"
			If (Test path name:C476($fileName)=Is a document:K24:1)
				loadPicture($fileName; ->$pic)
				$entity.flag:=$pic
				$entity.save()
			End if 
		End for each 
	End if 
End if 