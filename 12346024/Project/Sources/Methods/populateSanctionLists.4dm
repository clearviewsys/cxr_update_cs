//%attributes = {}
// [SanctionLists];"Listbox"
// [SanctionLists];"Entry"
// [sanctionLists];"View"

ARRAY TEXT:C222($SLName; 0)
ARRAY TEXT:C222($SLDescription; 0)

ALL RECORDS:C47([SanctionLists:113])
SELECTION TO ARRAY:C260([SanctionLists:113]ShortName:2; $SLName; [SanctionLists:113]Description:3; $SLDescription)
C_TEXT:C284($name; $description)

$name:="UK"
$description:="UK Consolidated Sanction List"
appendKeyValueToArrays(->$SLName; ->$SLDescription; $name; $description; True:C214)


//$name:="OSFI"
//$description:="OSFI (Canadian) Sanction List"
//appendKeyValueToArrays (->$SLName;->$SLDescription;$name;$description;True)
// getBuild


$name:="OFAC"
$description:="OFAC SDN (USA) Sanction List"
appendKeyValueToArrays(->$SLName; ->$SLDescription; $name; $description; True:C214)


$name:="AUSTRAC"
$description:="Australia Consolidated Sanction List"
appendKeyValueToArrays(->$SLName; ->$SLDescription; $name; $description; True:C214)


$name:="NZ"
$description:="New Zealand Police Sanction List"
appendKeyValueToArrays(->$SLName; ->$SLDescription; $name; $description; True:C214)

$name:="SEMA"
$description:="Special Economic Measures Act Sanction Lists"
appendKeyValueToArrays(->$SLName; ->$SLDescription; $name; $description; True:C214)


$name:="SWISS"
$description:="Swiss Sanction Lists"
appendKeyValueToArrays(->$SLName; ->$SLDescription; $name; $description; True:C214)


$name:="EU"
$description:="European Union Consolidated Sanction List"
appendKeyValueToArrays(->$SLName; ->$SLDescription; $name; $description; True:C214)

$name:="UNSC"
$description:="United Nations Security Council Sanction List"
appendKeyValueToArrays(->$SLName; ->$SLDescription; $name; $description; True:C214)

$name:="PSCA"
$description:="Public Safety Canada List"
appendKeyValueToArrays(->$SLName; ->$SLDescription; $name; $description; True:C214)

$name:="RELE"
$description:="Regulations Establishing a List of Entities - Canada"
appendKeyValueToArrays(->$SLName; ->$SLDescription; $name; $description; True:C214)

$name:="PEP"
$description:="International PEP (Politically Exposed Person) List"
appendKeyValueToArrays(->$SLName; ->$SLDescription; $name; $description; True:C214)

//SORT ARRAY($SLName;$SLDescription)
ARRAY TO SELECTION:C261($SLName; [SanctionLists:113]ShortName:2; $SLDescription; [SanctionLists:113]Description:3)
UNLOAD RECORD:C212([SanctionLists:113])

READ ONLY:C145([SanctionLists:113])  //5/23/18 IBB added

allRecordsSanctionLists