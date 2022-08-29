
C_LONGINT:C283($time)
$time:=Tickcount:C458
printTable(->[Accounts:9]; "printAccountsList"; ->[Accounts:9]MainAccountID:2; ->[Accounts:9]AccountID:1)
$time:=Tickcount:C458-$time
myAlert("Time elapsed in seconds "+String:C10($time/60; "######.##"))

