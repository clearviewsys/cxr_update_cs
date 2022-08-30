//%attributes = {"shared":true,"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 04/11/18, 22:21:13
// ----------------------------------------------------



C_POINTER:C301($1)  //option - pointer to array to fill
C_POINTER:C301($2)  //option value
C_POINTER:C301($3)  //option label


READ ONLY:C145([PictureIDTypes:92])

ALL RECORDS:C47([PictureIDTypes:92])

ORDER BY:C49([PictureIDTypes:92]; [PictureIDTypes:92]Description:14; >)
SELECTION TO ARRAY:C260([PictureIDTypes:92]TemplateID:1; $2->)
SELECTION TO ARRAY:C260([PictureIDTypes:92]Description:14; $1->)


INSERT IN ARRAY:C227($1->; 1)
$1->{1}:="-Select a Primary ID-"
INSERT IN ARRAY:C227($2->; 1)
$2->{1}:=""