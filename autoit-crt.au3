#AutoIt3Wrapper_UseX64=n
#RequireAdmin
#include <WinAPI.au3>
#include <Memory.au3>

$PROCESS_NAME = "test_program.exe" ;change this according to your test program's name

_main()

func _main()
	dim $written
	dim $temp_ref
	
	; get the string to memwrite through inputbox
	$str = InputBox("Mem Test", "Enter a string to pass to the remote function")
	if (Not $str) Then return False
	$str &= @CRLF

	; save string in a struct to get the pointer
	$struct = DllStructCreate("char["&StringLen($str)&"]")
	DllStructSetData($struct, 1, $str)
	$ptr = DllStructGetPtr($struct)

	; find the process and open a handle to it
	$PID = ProcessExists($PROCESS_NAME)
	if (Not $PID) Then Return MsgBox(64, "Mem Test", "Could not find the process.")
	$PROC = _WinAPI_OpenProcess(0x1F0FFF, False, $PID)

	; get the address of the remote function
	$function_addr = "0x" & FileRead("addr.txt")

	; allocate memory to save the string inside the process
	$alloc = _MemVirtualAllocEx($PROC, 0, StringLen($str), BitOR($MEM_COMMIT, $MEM_RESERVE), $PAGE_EXECUTE_READWRITE)

	; write the string to the process memory
	$string_addr = _WinAPI_WriteProcessMemory($PROC, $alloc, $ptr, StringLen($str), $written)

	; read the string from the process memory (optional)
	$temp_buf = DllStructCreate("char["&StringLen($str)&"]")
	_WinAPI_ReadProcessMemory($PROC, $alloc, DllStructGetPtr($temp_buf), StringLen($str), $temp_ref)
	ConsoleWrite("["&$alloc&"] " &  $DllStructGetData($temp_buf, 1) & @LF)

	; open handle to Kernel32 and create a new thread on the remote process
	$Kernel32 = DllOpen("Kernel32.dll")
	$res = DllCall($Kernel32, "int", "CreateRemoteThread", "DWORD", $PROC, "int", 0, "int", 0, "DWORD", $function_addr, "DWORD", $alloc, "int", 0, "int", 0)
	$hThread = $res[0]

	; wait for the remote thread to exit and free the allocated memory
	_WinAPI_WaitForSingleObject($hThread)
	_MemVirtualFreeEx($PROC, $alloc, 0, $MEM_RELEASE)

	; start over
	_main()
EndFunc
