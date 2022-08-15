C_TEXT:C284(vTemplateID)
vTemplateID:=""

pickLetterTemplates(->vTemplateID)

[Letters:52]Body:4:=[LetterTemplates:53]Body:3
[Letters:52]Recepients:7:=[LetterTemplates:53]recepient:2
[Letters:52]Subject:3:=[LetterTemplates:53]TemplateName:1
//[Letters]BodyRichText_:=[LetterTemplates]BodyRichText_

If (Is license available:C714(4D Write license:K44:2))
	//‘12000;142‘ (BodyRichText;[LetterTemplates]BodyRichText_)
End if 