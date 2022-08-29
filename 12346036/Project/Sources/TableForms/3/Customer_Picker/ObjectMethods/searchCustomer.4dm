

Form:C1466.entitySelection:=Form:C1466.originalEntitySelection
Form:C1466.queryString:="FirstName = :1 or LastName = :2"
Form:C1466.settings:=New object:C1471
Form:C1466.settings.parameters:=New collection:C1472(Get edited text:C655+"@"; Get edited text:C655+"@")
Form:C1466.entitySelection:=queryEntitySelection(Form:C1466.entitySelection; Form:C1466.queryString; Form:C1466.settings)


