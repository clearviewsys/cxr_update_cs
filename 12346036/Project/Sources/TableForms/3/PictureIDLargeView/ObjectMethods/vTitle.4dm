//Case of 
//
//: (Form event=On Load )
//  ` once the form is loaded, assign the default value of the box to the field
//ARRAY TEXT(vTitle;0)
//LIST TO ARRAY("Titles";vTitle)
//  ` modify record
//vTitle{0}:=[Customers]Title
//
//: (Form event#On Load )
//  ` after the combo box has been selected, assign the field to the new value    
//[Customers]Title:=vTitle{0}
//  `
//End case 

// [Customers];"PictureIDLargeView"
//titleCase(self{0})
handleComboBox(Self:C308; ->[Customers:3]Salutation:2; "Titles")
