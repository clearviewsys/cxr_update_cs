//%attributes = {}
//author: Amir, 8th Oct. 2018
//saveCountOrVolumeInArrElement
//This method is used as a helper method for SR_AnnualSummary report
//saves count or volume (or local volume) of registers (based on user selection) in a given array element.

C_POINTER:C301($1; $arrPtr)
C_LONGINT:C283($2; $arrIndex)
C_BOOLEAN:C305($3; $showBuy)
C_BOOLEAN:C305($4; $showSell)
C_BOOLEAN:C305($5; $showCount)
C_BOOLEAN:C305($6; $showVolume)
C_BOOLEAN:C305($7; $showLocalVolume)
C_REAL:C285($8; $volumeBuy)
C_REAL:C285($9; $volumeSell)
C_REAL:C285($10; $volumeBuyLocal)
C_REAL:C285($11; $volumeSellLocal)
C_LONGINT:C283($12; $countBuy)
C_LONGINT:C283($13; $countSell)

ASSERT:C1129(Count parameters:C259=13; "Expected 13 parameters")

$arrPtr:=$1
$arrIndex:=$2
$showBuy:=$3
$showSell:=$4
$showCount:=$5
$showVolume:=$6
$showLocalVolume:=$7
$volumeBuy:=$8
$volumeSell:=$9
$volumeBuyLocal:=$10
$volumeSellLocal:=$11
$countBuy:=$12
$countSell:=$13

If ($arrIndex#-1)  //if the index is valid (currency of register was found in the list and was not empty string)
	Case of 
		: (($showBuy=True:C214) & ($showSell=True:C214))
			Case of 
				: ($showCount=True:C214)  //count of buy and sell
					$arrPtr->{$arrIndex}:=$countBuy+$countSell
				: ($showVolume=True:C214)
					If ($showLocalVolume=True:C214)  //local volume for buy and sell
						$arrPtr->{$arrIndex}:=$volumeBuyLocal+$volumeSellLocal
					Else   //non-local volume for buy and sell
						$arrPtr->{$arrIndex}:=$volumeBuy+$volumeSell
					End if 
			End case 
		: ($showBuy=True:C214)
			Case of 
				: ($showCount=True:C214)  //count of buy
					$arrPtr->{$arrIndex}:=$countBuy
				: ($showVolume=True:C214)
					If ($showLocalVolume=True:C214)  //local volume for buy
						$arrPtr->{$arrIndex}:=$volumeBuyLocal
					Else   //non-local volume for buy
						$arrPtr->{$arrIndex}:=$volumeBuy
					End if 
			End case 
			
		: ($showSell=True:C214)
			Case of 
				: ($showCount=True:C214)  //count of sell
					$arrPtr->{$arrIndex}:=$countSell
				: ($showVolume=True:C214)
					If ($showLocalVolume=True:C214)  //local volume for sell
						$arrPtr->{$arrIndex}:=$volumeSellLocal
					Else   //non-local volume for sell
						$arrPtr->{$arrIndex}:=$volumeSell
					End if 
			End case 
	End case 
End if 

