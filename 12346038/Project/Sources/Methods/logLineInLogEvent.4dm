//%attributes = {}
// logs one line in system log in host operating system

#DECLARE($msg : Text)

$msg:="4️⃣🇩 :: "+$msg

LOG EVENT:C667(Into system standard outputs:K38:9; $msg+"\n")
