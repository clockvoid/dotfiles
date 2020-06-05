;================================================================
;auto hot key script for windows
;mac風キーバインド
;================================================================
#InstallKeybdHook
#UseHook

;================================================================
;関数
;================================================================

;----------------------------------------------------------------
;キーバインドを無効にするウィンドウかどうか判断する
; ahk_classはauto hot key付属のAU3_Spy.exeを使用して調べる。
;  引数 なし
;  戻り値 1:キーバインドを無効にするウィンドウ
;         0:キーバインドを有効にするウィンドウ
;----------------------------------------------------------------
is_disable_window()
{
	;gvim
	IfWinActive,ahk_class Vim
	{
		return 1
	}
	;tera term
	IfWinActive,ahk_class VTWin32
	{
		return 1
	}
	;vmware player 
	IfWinActive,ahk_class VMPlayerFrame
	{
		return 1
	}
	;hyper
	IfWinActive,ahk_exe Hyper.exe
	{
		return 1
	}
	;Android Studio
	IfWinActive,ahk_exe studio64.exe
	{
		return 1
	}
	;Intellij
	IfWinActive,ahk_exe idea64.exe
	{
		return 1
	}
    ifWinActive,ahk_exe OpenConsole.exe
    {
        return 1
    }
	
	return 0
}

;----------------------------------------------------------------
;キーを送信する
; キーバインドを無効にするウィンドウでは、送信されたキーをそのまま使用する
; キーバインドを有効にするウィンドウでは、送信されたキーを置き換える
;
;  引数 original_key:キーバインドを無効にするウィンドウの場合、送信するキー
;       replace_key:キーバインドを有効にするウィンドウの場合、送信するキー
;  戻り値 なし
;----------------------------------------------------------------
send_key(original_key,replace_key)
{
	if (is_disable_window())
	{
		Send,%original_key%
		return
	}
	Send,%replace_key%
	return
}

;================================================================
;ctrlキーバインド
;================================================================

;----------------------------------------------------------------
;移動系（shiftキーとの同時押し対応）
;ctrl + n : 下
;ctrl + p : 上
;ctrl + f : 右
;ctrl + b : 左
;ctrl + a : Home
;ctrl + e : End
;----------------------------------------------------------------

<^n::send_key("^n","{Down}")
<^+n::send_key("^+n","+{Down}")
<^p::send_key("^p","{Up}")
<^+p::send_key("^+p","+{Up}")
<^f::send_key("^f","{Right}")
<^+f::send_key("^+f","+{Right}")
<^b::send_key("^b","{Left}")
<^+b::send_key("^+b","+{Left}")
<^a::send_key("^a","{Home}")
<^+a::send_key("^+a","+{Home}")
<^e::send_key("^e","{End}")
<^+e::send_key("^+e","+{End}")

;----------------------------------------------------------------
;編集系
;ctrl + h : BackSpace
;ctrl + d : Delete
;ctrl + m : Enter
;ctrl + k : カーソルから行末まで削除
;----------------------------------------------------------------
 
<^h::send_key("^h","{BS}")
<^d::send_key("^d","{Del}")
<^m::send_key("^m","{Return}")
<^k::send_key("^k","+{End}{Del}")

<!c::send_key("!c","^c")
<!v::send_key("!v","^v")
<!a::send_key("!a","^a")
<!z::send_key("!z","^z")
<!s::send_key("!s","^s")
<!x::send_key("!x","^x")
<!w::send_key("!w","^w")
<!r::send_key("!r","^r")

<!1::send_key("!1","^1")
<!2::send_key("!2","^2")
<!3::send_key("!3","^3")
<!4::send_key("!4","^4")
<!5::send_key("!5","^5")
<!6::send_key("!6","^6")
<!7::send_key("!7","^7")
<!8::send_key("!8","^8")
<!9::send_key("!9","^9")
<!0::send_key("!0","^0")

<!+::send_key("!{+}","^{+}")
<!-::send_key("!{-}","^{-}")

; 上部メニューがアクティブになるのを抑制
*~LAlt::Send {Blind}{vk07}
*~RAlt::Send {Blind}{vk07}

;-----------------------------------------------------------
; IMEの状態をセット
;   SetSts          1:ON / 0:OFF
;   WinTitle="A"    対象Window
;   戻り値          0:成功 / 0以外:失敗
;-----------------------------------------------------------
IME_SET(SetSts, WinTitle="A")    {
    ControlGet,hwnd,HWND,,,%WinTitle%
    if    (WinActive(WinTitle))    {
        ptrSize := !A_PtrSize ? 4 : A_PtrSize
        VarSetCapacity(stGTI, cbSize:=4+4+(PtrSize*6)+16, 0)
        NumPut(cbSize, stGTI,  0, "UInt")   ;    DWORD   cbSize;
        hwnd := DllCall("GetGUIThreadInfo", Uint,0, Uint,&stGTI)
                 ? NumGet(stGTI,8+PtrSize,"UInt") : hwnd
    }

    return DllCall("SendMessage"
          , UInt, DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hwnd)
          , UInt, 0x0283  ;Message : WM_IME_CONTROL
          ,  Int, 0x006   ;wParam  : IMC_SETOPENSTATUS
          ,  Int, SetSts) ;lParam  : 0 or 1
}

; 左 Alt 空打ちで IME を OFF
LAlt up::
    if (A_PriorHotkey == "*~LAlt")
    {
        IME_SET(0)
    }
    Return

; 右 Alt 空打ちで IME を ON
RAlt up::
    if (A_PriorHotkey == "*~RAlt")
    {
        IME_SET(1)
    }
    Return
