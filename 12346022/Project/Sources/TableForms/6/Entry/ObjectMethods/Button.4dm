C_TEXT:C284($url)
If ([Currencies:6]ISO4217:31#"")
	If ([Currencies:6]ISO4217:31="CAD")
		$url:="https://en.wikipedia.org/wiki/"+"Canadian_Dollar"
	Else 
		$url:="https://en.wikipedia.org/wiki/"+[Currencies:6]ISO4217:31
	End if 
	WA OPEN URL:C1020(*; "webArea"; $url)
End if 