//[Flags]flag:=fetchPicturefromURL ("http://registrationserver.net/cxrate/flags/";[Flags]CurrencyCode+".gif")
//OpenURL ("http://registrationserver.net/cxrate/flags/"+[Flags]CurrencyCode+".gif")
// http://www.flags.net/letterindex.php?letter=f&section=CURR

C_TEXT:C284($letter)

$letter:=Substring:C12([Flags:19]Country:3; 1; 1)
If ($letter="")
	$letter:=Substring:C12([Flags:19]CurrencyCode:1; 1; 1)
End if 
OpenURL("http://www.flags.net/letterindex.php?letter="+$letter+"&section=CURR")
