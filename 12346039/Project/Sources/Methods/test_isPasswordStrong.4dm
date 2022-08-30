//%attributes = {}
// A unit test is written by @Zoya

C_TEXT:C284($error)

ASSERT:C1129(isPasswordStrong(""; ->$error)=False:C215)  // too short

ASSERT:C1129(isPasswordStrong("abc"; ->$error)=False:C215)
ASSERT:C1129(isPasswordStrong("ABC"; ->$error)=False:C215)
ASSERT:C1129(isPasswordStrong("abcABC"; ->$error)=False:C215)
ASSERT:C1129(isPasswordStrong("abcABC123"; ->$error)=False:C215)
ASSERT:C1129(isPasswordStrong("abcABC123!@#"; ->$error)=True:C214)


