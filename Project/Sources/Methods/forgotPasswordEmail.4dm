//%attributes = {}
C_TEXT:C284($1; $resetCode; $2; $email)


Case of 
	: (Count parameters:C259=2)
		$resetCode:=$1
		$email:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

sendEmail($email; "CXR Password Reset"; "<html><div style=\"font-family:verdana; text-align:center;\"><h1>CurrencyXChanger Password Reset</h1><p>Your password reset code is below, enter it into your CXR platform to reset your</p><p>If you did not request a password reset, please contact your s"\
+"ystem administrator</p></div><div style=\" font-family:verdana; text-align:center\"><br><h3>Password reset code:</h3><p>"\
+$resetCode+"</p><p>This code will expire in 15 minutes</p></div><br><br><div style=\"font-size:75%\"><p><b style=\"font-size:150%\">Clear View Systems Ltd.</b><br><b style=\"font-size:120%\">Software Automation for Your Money Exchange Business</b><br>1113-2012 Fullerto"\
+"n Ave.<br>North Vancouver, British Columbia<br>Canada, V7P 3E3<br>clearviewsys.com<br><br>Toll free: 1(888)390-840</p></div></html>"\
)



















