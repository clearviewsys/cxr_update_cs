//%attributes = {}

// isDateHourInDateTimeRange ($dateRef; $hourRef; $fromDate;  $fromHour;$toDate; $toHour)
// Given a date and hour return true if $dateRef-$hourRef is between $fromDate-$fromHour and  $toDate-$toHour
// i.e: a document with creation date: 12/31/2000 10:00AM is in range of 12/30/2020 9:00AM to  1/1/2021 07:00AM

C_BOOLEAN:C305($0)
C_DATE:C307($1; $dateRef)
C_TIME:C306($2; $hourRef)

C_DATE:C307($3; $fromDate)
C_TIME:C306($4; $fromHour)

C_DATE:C307($5; $toDate)
C_TIME:C306($6; $toHour)


Case of 
	: (Count parameters:C259=6)
		
		$dateRef:=$1
		$hourRef:=$2
		
		$fromDate:=$3
		$fromHour:=$4
		
		$toDate:=$5
		$toHour:=$6
		
End case 

$0:=True:C214


If (($dateRef>=$fromDate) & ($dateRef<=$toDate))  // In date Range
	
	Case of 
			
		: (($dateRef=$fromDate) & ($hourRef<$fromHour))
			$0:=False:C215
			
		: (($dateRef=$toDate) & ($hourRef>$toHour))
			$0:=False:C215
			
			
	End case 
Else 
	
	$0:=False:C215
End if 



