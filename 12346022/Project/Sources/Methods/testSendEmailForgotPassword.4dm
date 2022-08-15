//%attributes = {}
loadServerPreferences
sendEmail("blakepickard@hotmail.com"; "Test email from 4d"; "<html><body><h1>Test mail </h1> This is just a test e-mail <br /> Please ignore it</body></html>")

//This method below is an easier way to send an email, once upgraded past v17R5
//C_OBJECT($email;$smtp)
//$email:=New object
C_OBJECT:C1216($smtp)
$smtp:=New object:C1471

//$email.from:=<>SMTPFROMEMAIL
//$email.to:="blakepickard@hotmail.com"
//$email.subject:="Test new email method"
//$email.textBody:="Test mail \r\n This is just a test e-mail \r\n Please ignore it"
//$email.htmlBody:="<html><body><h1>Test mail </h1> This is just a test e-mail <br /> Please ignore it</body></html>"

//$smtp.host:=<>SMTPSERVER
//$smtp.port:=<>SMTPPORTNO
//$smtp.user:=<>SMTPUSERNAME
//$smtp.password:=<>SMTPPASSWORD
//The below commands are part of 4Dv17R5
//$smtpTransporter:=SMTP New Transporter($smtp)

//$status:=$smtpTransporter.send($email)


