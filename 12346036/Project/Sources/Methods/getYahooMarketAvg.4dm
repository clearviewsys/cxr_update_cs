//%attributes = {}
// getYahooMarketAvg(->HTML)-> real

C_POINTER:C301($1)
C_REAL:C285($0)
C_TEXT:C284($lookFor)
C_LONGINT:C283($position)

Case of 
	: (<>updateSource="Reuters")
		$lookFor:="input type="+Quotify("text")+" name="+Quotify("result")+" value="
		$0:=parseHTMLRealField($1; $lookFor; 0; 17)
	: (<>updateSource="Yahoo")
		$lookFor:="</td><td class="+Quotify("yfnc_tabledata1")+"><b>"
		$position:=Position:C15($lookFor; $1->)
		$1->:=Delete string:C232($1->; 0; $position)
		$0:=parseHTMLRealField($1; $lookFor; 0; 17)
End case 