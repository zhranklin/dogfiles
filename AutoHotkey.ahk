; IMPORTANT INFO ABOUT GETTING STARTED: Lines that start with a
; semicolon, such as this one, are comments.  They are not executed.

; This script has a special filename and path because it is automatically
; launched when you run the program directly.  Also, any text file whose
; name ends in .ahk is associated with the program, which means that it
; can be launched simply by double-clicking it.  You can have as many .ahk
; files as you want, located in any folder.  You can also run more than
; one .ahk file simultaneously and each will get its own tray icon.

; Note: From now on whenever you run AutoHotkey directly, this script
; will be loaded.  So feel free to customize it to suit your needs.

; Please read the QUICK-START TUTORIAL near the top of the help file.
; It explains how to perform common automation tasks such as sending
; keystrokes and mouse clicks.  It also explains more about hotkeys.

;; すでに 実行していればウィンドウをアクティベート、それ以外なら起動
;; gvim
#v::
Process,Exist,gvim.exe
if ErrorLevel<>0
    WinActivate,ahk_pid %ErrorLevel%
else
    Run C:\home\vim\vim73-kaoriya-win64\gvim.exe
Return

;; Google Chrome
#g::
Process,Exist,chrome.exe
if ErrorLevel<>0
    WinActivate,ahk_pid %ErrorLevel%
else
    Run C:\Program Files (x86)\Google\Chrome\Application\chrome.exe
Return

;; Outlook

;;  Alt + , で最大化⇔元に戻す
!,::
WinGet, tmp, MinMax, A
If tmp = 1
    WinRestore, A
Else
    WinMaximize, A
Return

;;;;;;;;;;;;;;;;
;; emacs.ahk  ;;
;;;;;;;;;;;;;;;;

;;
;; An autohotkey script that provides emacs-like keybinding on Windows
;;
#InstallKeybdHook
#UseHook

; Ripped from http://www49.atwiki.jp/ntemacs/pages/20.html
; Thanks a lot!
SetKeyDelay 0

; turns to be 1 when ctrl-x is pressed
is_pre_x = 0
; turns to be 1 when ctrl-space is pressed
is_pre_spc = 0

; Applications you want to disable emacs-like keybindings
; (Please comment out applications you don't use)
is_target()
{
  IfWinActive,ahk_class ConsoleWindowClass ; Cygwin
    Return 1 
  IfWinActive,ahk_class MEADOW ; Meadow
    Return 1 
  IfWinActive,ahk_class cygwin/x X rl-xterm-XTerm-0
    Return 1
  IfWinActive,ahk_class MozillaUIWindowClass ; keysnail on Firefox
    Return 1
  ; Avoid VMwareUnity with AutoHotkey
  IfWinActive,ahk_class VMwareUnityHostWndClass
    Return 1
  IfWinActive,ahk_class Vim ; GVIM
    Return 1
;  IfWinActive,ahk_class SWT_Window0 ; Eclipse
;    Return 1
;   IfWinActive,ahk_class Xming X
;     Return 1
;   IfWinActive,ahk_class SunAwtFrame
;     Return 1
;   IfWinActive,ahk_class Emacs ; NTEmacs
;     Return 1  
;   IfWinActive,ahk_class XEmacs ; XEmacs on Cygwin
;     Return 1
  Return 0
}

delete_char()
{
  Send {Del}
  global is_pre_spc = 0
  Return
}
delete_backward_char()
{
  Send {BS}
  global is_pre_spc = 0
  Return
}
kill_line()
{
  Send {ShiftDown}{END}{SHIFTUP}
  Sleep 50 ;[ms] this value depends on your environment
  Send ^x
  global is_pre_spc = 0
  Return
}
open_line()
{
  Send {END}{Enter}{Up}
  global is_pre_spc = 0
  Return
}
quit()
{
  Send {ESC}
  global is_pre_spc = 0
  Return
}
newline()
{
  Send {Enter}
  global is_pre_spc = 0
  Return
}
indent_for_tab_command()
{
  Send {Tab}
  global is_pre_spc = 0
  Return
}
newline_and_indent()
{
  Send {Enter}{Tab}
  global is_pre_spc = 0
  Return
}
isearch_forward()
{
  Send ^f
  global is_pre_spc = 0
  Return
}
isearch_backward()
{
  Send ^f
  global is_pre_spc = 0
  Return
}
kill_region()
{
  Send ^x
  global is_pre_spc = 0
  Return
}
kill_ring_save()
{
  Send ^c
  global is_pre_spc = 0
  Return
}
yank()
{
  Send ^v
  global is_pre_spc = 0
  Return
}
undo()
{
  Send ^z
  global is_pre_spc = 0
  Return
}
find_file()
{
  Send ^o
  global is_pre_x = 0
  Return
}
save_buffer()
{
  Send, ^s
  global is_pre_x = 0
  Return
}
kill_emacs()
{
  Send !{F4}
  global is_pre_x = 0
  Return
}

move_beginning_of_line()
{
  global
  if is_pre_spc
    Send +{HOME}
  Else
    Send {HOME}
  Return
}
move_end_of_line()
{
  global
  if is_pre_spc
    Send +{END}
  Else
    Send {END}
  Return
}
previous_line()
{
  global
  if is_pre_spc
    Send +{Up}
  Else
    Send {Up}
  Return
}
next_line()
{
  global
  if is_pre_spc
    Send +{Down}
  Else
    Send {Down}
  Return
}
forward_char()
{
  global
  if is_pre_spc
    Send +{Right}
  Else
    Send {Right}
  Return
}
backward_char()
{
  global
  if is_pre_spc
    Send +{Left} 
  Else
    Send {Left}
  Return
}
scroll_up()
{
  global
  if is_pre_spc
    Send +{PgUp}
  Else
    Send {PgUp}
  Return
}
scroll_down()
{
  global
  if is_pre_spc
    Send +{PgDn}
  Else
    Send {PgDn}
  Return
}


; ^x::
;   If is_target()
;     Send %A_ThisHotkey%
;   Else
;     is_pre_x = 1
;   Return 
!f::
  If is_target()
    Send %A_ThisHotkey%
  Else
  {
    If is_pre_x
      find_file()
    Else
      forward_char()
  }
  Return  
; ^c::
;   If is_target()
;     Send %A_ThisHotkey%
;   Else
;   {
;     If is_pre_x
;       kill_emacs()
;   }
;   Return  
!d::
  If is_target()
    Send %A_ThisHotkey%
  Else
    delete_char()
  Return
!h::
  If is_target()
    Send %A_ThisHotkey%
  Else
    delete_backward_char()
  Return
!k::
  If is_target()
    Send %A_ThisHotkey%
  Else
    kill_line()
  Return
!o::
  If is_target()
    Send %A_ThisHotkey%
  Else
    open_line()
  Return
!g::
  If is_target()
    Send %A_ThisHotkey%
  Else
    quit()
  Return
!j::
  If is_target()
    Send %A_ThisHotkey%
  Else
    newline_and_indent()
  Return
!m::
  If is_target()
    Send %A_ThisHotkey%
  Else
    newline()
  Return
!i::
  If is_target()
    Send %A_ThisHotkey%
  Else
    indent_for_tab_command()
  Return
!s::
  If is_target()
    Send %A_ThisHotkey%
  Else
  {
    If is_pre_x
      save_buffer()
    Else
      isearch_forward()
  }
  Return
!r::
  If is_target()
    Send %A_ThisHotkey%
  Else
    isearch_backward()
  Return
!w::
  If is_target()
    Send %A_ThisHotkey%
  Else
    kill_region()
  Return
!q::
  If is_target()
    Send %A_ThisHotkey%
  Else
    kill_ring_save()
  Return
!y::
  If is_target()
    Send %A_ThisHotkey%
  Else
    yank()
  Return
!/::
  If is_target()
    Send %A_ThisHotkey%
  Else
    undo()
  Return  
  
;$^{Space}::
!vk20sc039::
  If is_target()
    Send {CtrlDown}{Space}{CtrlUp}
  Else
  {
    If is_pre_spc
      is_pre_spc = 0
    Else
      is_pre_spc = 1
  }
  Return
!@::
  If is_target()
    Send %A_ThisHotkey%
  Else
  {
    If is_pre_spc
      is_pre_spc = 0
    Else
      is_pre_spc = 1
  }
  Return
!a::
  If is_target()
    Send %A_ThisHotkey%
  Else
    move_beginning_of_line()
  Return
!e::
  If is_target()
    Send %A_ThisHotkey%
  Else
    move_end_of_line()
  Return
!p::
  If is_target()
    Send %A_ThisHotkey%
  Else
    previous_line()
  Return
!n::
  If is_target()
    Send %A_ThisHotkey%
  Else
    next_line()
  Return
!b::
  If is_target()
    Send %A_ThisHotkey%
  Else
    backward_char()
  Return
!v::
  If is_target()
    Send %A_ThisHotkey%
  Else
    scroll_down()
  Return
!c::
  If is_target()
    Send %A_ThisHotkey%
  Else
    scroll_up()
  Return