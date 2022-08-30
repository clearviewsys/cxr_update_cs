//%attributes = {}
//getFolderPathByFileID (filepathID;machinename): filepath
// if a machine is not specified it will search for the current machine only
// if the machinename is sent as blank it will only match for the record that matches a blank record for the machine
// if it cannot find a record it will return an empty string
// returns the full folderpath 

C_TEXT:C284($filePathID; $filePath; $machineName; $0)

Case of 
	: (Count parameters:C259=1)
		$filePathID:=$1
		$machineName:=getCurrentMachineName
	: (Count parameters:C259=2)
		$filePathID:=$1
		$machineName:=$2
	Else 
		$filePathID:="RATEX"
		$machineName:=getCurrentMachineName
End case 

READ ONLY:C145([FilePaths:83])

// first look for the exact record
// if you find it then return the  file path and if not keep looking for a 
// record that has the the same filePatchID but NO machine name

QUERY:C277([FilePaths:83]; [FilePaths:83]FilePathID:1=$filePathID; *)
QUERY:C277([FilePaths:83];  & ; [FilePaths:83]machineName:5=$machineName)
If (Records in selection:C76([FilePaths:83])>=1)
	FIRST RECORD:C50([FilePaths:83])
	$filePath:=[FilePaths:83]FolderPath:3
Else 
	
	QUERY:C277([FilePaths:83]; [FilePaths:83]FilePathID:1=$filePathID; *)
	QUERY:C277([FilePaths:83];  & ; [FilePaths:83]machineName:5="")
	If (Records in selection:C76([FilePaths:83])>=1)
		FIRST RECORD:C50([FilePaths:83])
		$filePath:=[FilePaths:83]FolderPath:3
	End if 
	
End if 


$0:=$filePath