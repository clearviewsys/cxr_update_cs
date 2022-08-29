//%attributes = {}
// assumes you have authenticated the machine running this command

//https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html

//$aws configure
//AWS Access Key ID[None]: AKIAIOSFODNN7EXAMPLE
//AWS Secret Access Key[None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
//Default region name[None]: us-west-2
//Default output format [None]: json

// the cp command uses your configure above

//NZ S3 bucket
//aws s3 cp C:\Surinder\AWS\NZ\rateswithcss.xmls3:  //nz-lotusfx-web/files/   (“Localpath”: C:\Surinder\AWS\NZ\rateswithcss.xml, “S3 Bucket name and path” : nz-lotusfx-web/files/)

//AU S3 bucket
//aws s3 cp C:\Surinder\AWS\AU\rateswithcss.xmls3:  //au-lotusfx-web/files/  

//FJ S3 bucket
//aws s3 cp C:\Surinder\AWS\FJ\rateswithcss.xml s3://fj-lotusfx-web/files/  


C_TEXT:C284($1; $localPath)
C_TEXT:C284($2; $remotePath)

C_OBJECT:C1216($0; $status)


C_TEXT:C284($cmd; $input; $output; $error; $binPath)


$localPath:=$1
$remotePath:=$2  //s3://fj-lotusfx-web/files/ 

$status:=New object:C1471("success"; True:C214; "statusText"; ""; "status"; 0)


If (Is Windows:C1573)
	$binPath:="c:\\Program Files\\Amazon\\AWSCLIV2\\aws.exe"
Else 
	$binPath:="/usr/local/bin/aws"
	$localPath:=Convert path system to POSIX:C1106($localPath)
End if 

$cmd:=$binPath+" s3 cp "+$localPath+" "+$remotePath

SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")
//SET ENVIRONMENT VARIABLE("_4D_OPTION_BLOCKING_EXTERNAL_PROCESS";"false")
LAUNCH EXTERNAL PROCESS:C811($cmd; $input; $output; $error)

Case of 
	: ($output="Completed@")
		$status.success:=True:C214
		$status.statusText:=Replace string:C233($output; "\n"; "\r")
		
	: ($error#"")
		$status.success:=False:C215
		$status.statusText:=Replace string:C233($error; "\n"; "\r")
		$status.status:=-1
		
	: ($output#"")
		$status.success:=False:C215
		$status.statusText:=Replace string:C233($output; "\n"; "\r")
		$status.status:=-2
		
	Else 
		$status.success:=True:C214
End case 


$0:=$status