setFieldAsPassword(Self:C308)

setVisibleIff((vNewPassword1=Get edited text:C655) & (Length:C16(vNewPassword1)>0); "bChangePassword")
setVisibleIff((vNewPassword1=Get edited text:C655) & (vNewPassword1#""); "checkmark")
