//%attributes = {}
// makeHTMLTitle5 ( row; str1; str2; str3; str4;str5) -> text

// row: integer 

// str1-str5: string to be tabulized in HTML format

// Returns an  HTML Table with  the fields in 5 columns 



C_LONGINT:C283($1)
C_TEXT:C284($0)
C_TEXT:C284($2; $3; $4; $5; $6; vBGcolor)
C_TEXT:C284($openFont; $endFont)
$openFont:="<font size=2 face='Arial, Helvetica, sans-serif'>"
$endFont:="</font>"

vbgcolor:=Quotify("#E7E7E7")

If ($1%2=0)
	$0:="<tr bgcolor="+vbgcolor+">"
Else 
	$0:="<tr>"
End if 

$0:=$0+"<td>"+$openfont+$2+"<td>"+$openfont+$3+"<td>"+$openfont+$4+"<td>"+$openfont+$5+"<td>"+$openfont+$6+$endFont+"</tr>"+Char:C90(10)+Char:C90(13)
