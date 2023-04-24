//%attributes = {}

#DECLARE($strDate : Text)->$newDate : Date

var $yy; $mm; $dd : Text

$yy:=Substring:C12($strDate; 1; 4)
$mm:=Substring:C12($strDate; 6; 2)
$dd:=Substring:C12($strDate; 9; 2)

$newDate:=Date:C102($mm+"/"+$dd+"/"+$yy)
