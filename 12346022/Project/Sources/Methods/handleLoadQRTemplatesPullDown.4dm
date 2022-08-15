//%attributes = {}
// handleLoadQRTemplatesPullDown (self; longint: quickreport area; current form table)


// handlePullDownShowTables (self: pulldownobject)


C_POINTER:C301($selfPtr; $1; $objectPtr)
C_REAL:C285($2; $quickReportArea)
C_POINTER:C301($3; $quickReportTablePtr)

C_LONGINT:C283(MyQReport)
C_TEXT:C284($filePath; $folderPath)

Case of 
		
	: (Count parameters:C259=2)
		$objectPtr:=$1
		$quickReportArea:=$2
		$quickReportTablePtr:=quickReportTablePtr
		
	: (Count parameters:C259=3)
		$objectPtr:=$1
		$quickReportArea:=$2
		$quickReportTablePtr:=$3
		
	Else 
		$objectPtr:=Self:C308
		$quickReportArea:=MyQReport
		$quickReportTablePtr:=quickReportTablePtr
		
End case 

If (False:C215)
	ARRAY TEXT:C222(arrDocumentList; 0)
End if 

setErrorTrap("QuickReportPage Button"; "Something went wrong in generating the report; possibly file path is invalid")
Case of 
		
	: (Form event code:C388=On Load:K2:1)  // load all the files from the file path
		ARRAY TEXT:C222(arrDocumentList; 0)
		$filePath:=getFilePathByID("ReportTemplatesPath")
		
		
		If ($filePath="")
			myAlert("A file path has not been defined to pick the reports from")
			displayListFilePaths
		Else 
			
			$folderPath:=$filePath+Table name:C256($quickReportTablePtr)+Folder separator:K24:12
			If (Test path name:C476($folderPath)=Is a folder:K24:2)
				$filePath:=$folderPath
			End if 
			
			DOCUMENT LIST:C474($filePath; arrDocumentList)
			
		End if 
		
		
	: (Form event code:C388=On Clicked:K2:4)
		
		If (arrDocumentList>0)
			loadQuickReportIntoObject(->$quickReportArea; arrDocumentList{arrDocumentList})
		End if 
		
		
End case 
endErrorTrap

