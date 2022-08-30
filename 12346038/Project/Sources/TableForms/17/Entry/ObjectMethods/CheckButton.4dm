//Case of
//: (Form event code=On Clicked)
////checkLinkFullName (True)
//C_TEXT($name)
//$name:=makeFullName([Links]FirstName; [Links]LastName)
//sl_handlePersonNameCompliance(False; $name; ->[Links]LinkID; New object(\
"pointers"; New object("resultIconPtr"; ->latestLinkIcon7); \
"options"; New object(\
"namePartsFilled"; (([Links]FirstName#"") & ([Links]LastName#""))\
)))
//End case
sl_handleLinksScreening(sl_LinksPerson+sl_ForSLButton)

