//%attributes = {}
// clearPictureIDVars
C_PICTURE:C286(vPicture)
C_DATE:C307(vExpiryDate)
C_TEXT:C284(vPictureIDRef; vIDType)
C_TEXT:C284(vIssueDate; vIssueCountry)
C_TEXT:C284(vDescriptiveNotes)

vPictureIDRef:=""  //initialize picture ID vars
vIDType:=""
vExpiryDate:=!00-00-00!
clearPictureField(->vPicture)
vIssueCity:=""
vIssueCountry:=""
vDescriptiveNotes:=""
