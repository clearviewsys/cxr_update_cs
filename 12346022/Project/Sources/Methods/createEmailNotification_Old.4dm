//%attributes = {}
// createEmailNotification

C_TEXT:C284($1; $to)  //to
C_TEXT:C284($2; $subject)  //subject
C_TEXT:C284($3; $message)  //message
C_TEXT:C284($4; $from)
C_TEXT:C284($5; $cc)
C_TEXT:C284($6; $bcc)
C_TEXT:C284(${7})  //attachment paths


C_COLLECTION:C1488($col)
C_LONGINT:C283($i)

$col:=New collection:C1472

Case of 
	: (Count parameters:C259=3)  //minimum needed
		$to:=$1
		$subject:=$2
		$message:=$3
		$from:=""  //get FROM via system settings?
		$cc:=""
		$bcc:=""
		
	: (Count parameters:C259=4)
		$to:=$1
		$subject:=$2
		$message:=$3
		$from:=$4
		$cc:=""
		$bcc:=""
		
	: (Count parameters:C259=5)
		$to:=$1
		$subject:=$2
		$message:=$3
		$from:=$4
		$cc:=$5
		$bcc:=""
		
	: (Count parameters:C259=6)
		$to:=$1
		$subject:=$2
		$message:=$3
		$from:=$4
		$cc:=$5
		$bcc:=$6
		
	: (Count parameters:C259=7)
		$to:=$1
		$subject:=$2
		$message:=$3
		$from:=$4
		$cc:=$5
		$bcc:=$6
		
		//put attachment paths into collection
		For ($i; 7; Count parameters:C259)
			$col.push(${$i})
		End for 
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


If ($from="")
	$from:=""  //system from
End if 


C_OBJECT:C1216($o)

$o:=New object:C1471

$o.messageType:="email"
$o.createByUser:=Current user:C182
$o.creationDate:=Current date:C33(*)
$o.creationTime:=Current time:C178(*)
$o.to:=$to
$o.from:=$from
$o.cc:=$cc
$o.bcc:=$bcc
$o.replyTo:=$from
$o.subject:=$subject
$o.message:=$message
$o.attachments:=$col


CREATE RECORD:C68([Notifications:158])
[Notifications:158]ID:1:=makeID
[Notifications:158]UUID:2:=Generate UUID:C1066
[Notifications:158]type:3:=1  //email
[Notifications:158]message:4:=$o
OBJ_newResponse(->[Notifications:158]response:5)
[Notifications:158]status:6:=0
[Notifications:158]creationDate:7:=Current date:C33(*)
SAVE RECORD:C53([Notifications:158])