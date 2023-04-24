//%attributes = {}
// this method should be called from the [Customers];"ListBox_Match" form
C_LONGINT:C283($shade; $white; $black)
$shade:=(255 << 16)+(230 << 8)+230
$white:=(255 << 16)+(255 << 8)+255
$black:=0

If (Form:C1466.current.fullName=Form:C1466.selected.FullName)
	Form:C1466.match:=Form:C1466.match+1
	OBJECT SET RGB COLORS:C628(*; "currentFullName"; $black; $shade)
	OBJECT SET RGB COLORS:C628(*; "selectedFullName"; $black; $shade)
	OBJECT SET VISIBLE:C603(*; "lineName"; True:C214)
Else 
	OBJECT SET RGB COLORS:C628(*; "currentFullName"; $black; $white)
	OBJECT SET RGB COLORS:C628(*; "selectedFullName"; $black; $white)
End if 

If ((Form:C1466.current.dob=Form:C1466.selected.DOB) & (Form:C1466.current.dob#!00-00-00!))  // if a DOB exist
	Form:C1466.match:=Form:C1466.match+2
	OBJECT SET RGB COLORS:C628(*; "currentDOB"; $black; $shade)
	OBJECT SET RGB COLORS:C628(*; "selectedDOB"; $black; $shade)
	OBJECT SET VISIBLE:C603(*; "lineDOB"; True:C214)
Else 
	OBJECT SET RGB COLORS:C628(*; "currentDOB"; $black; $white)
	OBJECT SET RGB COLORS:C628(*; "selectedDOB"; $black; $white)
	OBJECT SET VISIBLE:C603(*; "lineDOB"; False:C215)
End if 

If ((Form:C1466.current.email=Form:C1466.selected.Email) & (Form:C1466.current.email#""))
	Form:C1466.match:=Form:C1466.match+4
	OBJECT SET RGB COLORS:C628(*; "currentEmail"; $black; $shade)
	OBJECT SET RGB COLORS:C628(*; "selectedEmail"; $black; $shade)
	OBJECT SET VISIBLE:C603(*; "lineEmail"; True:C214)
Else 
	OBJECT SET RGB COLORS:C628(*; "currentEmail"; $black; $white)
	OBJECT SET RGB COLORS:C628(*; "selectedEmail"; $black; $white)
	OBJECT SET VISIBLE:C603(*; "lineEmail"; False:C215)
End if 

If ((Form:C1466.current.pictureID=Form:C1466.selected.PictureID_Number) & (Form:C1466.current.pictureID#""))
	Form:C1466.match:=Form:C1466.match+8
	OBJECT SET RGB COLORS:C628(*; "currentPictureID"; $black; $shade)
	OBJECT SET RGB COLORS:C628(*; "selectedPictureID"; $black; $shade)
	OBJECT SET VISIBLE:C603(*; "linePictureID"; True:C214)
Else 
	OBJECT SET RGB COLORS:C628(*; "currentPictureID"; $black; $white)
	OBJECT SET RGB COLORS:C628(*; "selectedPictureID"; $black; $white)
	OBJECT SET VISIBLE:C603(*; "linePictureID"; False:C215)
End if 

If ((Form:C1466.current.sin=Form:C1466.selected.SIN_No) & (Form:C1466.current.sin#""))
	Form:C1466.match:=Form:C1466.match+16
	OBJECT SET RGB COLORS:C628(*; "currentSIN"; $black; $shade)
	OBJECT SET RGB COLORS:C628(*; "selectedSIN"; $black; $shade)
	OBJECT SET VISIBLE:C603(*; "lineSIN"; True:C214)
Else 
	OBJECT SET RGB COLORS:C628(*; "currentSIN"; $black; $white)
	OBJECT SET RGB COLORS:C628(*; "selectedSIN"; $black; $white)
	OBJECT SET VISIBLE:C603(*; "lineSIN"; False:C215)
	
End if 

If (Form:C1466.match>=4)
	stampText("stamp"; "Exact Match!"; "red")
Else 
	stampText("stamp"; "Possible Duplicate!"; "orangered")
End if 