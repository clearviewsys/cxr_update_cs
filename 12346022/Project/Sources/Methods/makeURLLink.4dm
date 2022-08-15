//%attributes = {}
// MakeURLLink ( URL ; title ;  target ) -> text

// url : text 

// text : text

// target :{ _self, _blank, _top, _parent }

//

// returns a URL link STRING for the given URL with the title and the target



C_TEXT:C284($1; $2; $3)
//<a href="/4DMETHOD/WELCOME" target="_self">Enter Site</a>


$0:="<a href="+Char:C90(34)+$1+Char:C90(34)+" target="+Char:C90(34)+$3+Char:C90(34)+">"+$2+"</a>"

