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
    ifWinActive,ahk_exe WindowsTerminal.exe
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
;ctrl + n : Down
;ctrl + p : Up
;ctrl + f : Right
;ctrl + b : Left
;----------------------------------------------------------------

<^n::send_key("^n","{Down}")
<^+n::send_key("^+n","+{Down}")
<^p::send_key("^p","{Up}")
<^+p::send_key("^+p","+{Up}")
<^f::send_key("^f","{Right}")
<^+f::send_key("^+f","+{Right}")
<^b::send_key("^b","{Left}")
<^+b::send_key("^+b","+{Left}")

;----------------------------------------------------------------
;編集系
;ctrl + h : BackSpace
;ctrl + d : Delete
;ctrl + k : Delete from cursor to the end of line
;----------------------------------------------------------------
 
<^h::send_key("^h","{BS}")
<^d::send_key("^d","{Del}")
<^k::send_key("^k","+{End}{Del}")

