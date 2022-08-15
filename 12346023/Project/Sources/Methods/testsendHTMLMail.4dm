//%attributes = {}
C_TEXT:C284($to; $subject; $body)
C_LONGINT:C283($err)
C_OBJECT:C1216($options)

$options:=New object:C1471

$to:="madamov@adamov.rs"
$subject:="Probamo HTML"
$body:="<html><body><H1>Ovo je u telu poruke, hajde i neki .. </H1></body></html>"

If (True:C214)
	
	C_TEXT:C284($attachdirpath)
	C_COLLECTION:C1488($att)
	
	$attachdirpath:="E:\\milantest\\"
	
	If (Test path name:C476($attachdirpath)=Is a folder:K24:2)
		
		$att:=New collection:C1472
		
		$att.push($attachdirpath+"players.txt")
		$att.push($attachdirpath+"test.pdf")
		$att.push($attachdirpath+"v16.zip")
		
	End if 
	
End if 

$options.URL:="smtp://"+"mail.4d.rs"
$options.PORT:=587
$options.USERNAME:="info@4d.rs"
$options.PASSWORD:="Sr11Ma26"
$options.MAIL_FROM:="info@4d.rs"
$options.MAIL_RCPT:=$to
$options.BODY:=$body
$options.SUBJECT:=$subject

If ($att#Null:C1517)
	$err:=sendEmailviacURL($options; $att)
Else 
	$err:=sendEmailviacURL($options)
End if 

// $err:=sendEmail ($to;$subject;$body;"mail.4d.rs";"info@4d.rs";"info@4d.rs";"Sr11Ma26";587)

//$subject:="Probamo HTML - ovde ga nema"
//$body:="Nema htmla ovde. \nOvo je u telu poruke, hajde i neki naši karakteri Čačak, Žeželj, Ćićevac, Đurđevdan ..\n "
//$body:=$body+"http://www.adamov.rs/q=papazjanija&s=likvno?nestobezveze#iovo%plusovo\n\n"

//$err:=sendEmail ($to;$subject;$body;"mail.4d.rs";"info@4d.rs";"info@4d.rs";"Sr11Ma26";587)


