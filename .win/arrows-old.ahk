﻿;;; AHK ;;;

;;; GLOBAL
#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

; ^ = CTRL
; ! = ALT
; + = SHIFT
; # = Windows Key
; Full Key List: https://www.autohotkey.com/docs/KeyList.htm

;; Unbind Win+Esc
#Esc::

;; alt+{w/a/s/d} for navigating text
!w::Send {Up}
!s::Send {Down}
!a::Send {Left}
!d::Send {Right}

;; alt+shift+{a/d} ;; jump/move word left and right
>!+a::Send ^{Left}
>!+d::Send ^{Right}

;; alt+backspace ;; delete one word left
>!Backspace::Send ^{Backspace}

;; ^q => close window | ^h => minimize window
^q::Send {AltDown}{F4}{AltUp}
^h::WinMinimize, A

;; LWin+shift+[/]
#+[::Send #{Left}
#+]::Send #{Right}


;;; EXPLORER
#If WinActive("ahk_class CabinetWClass")
^l::Send ^{e}

^i::
    Send !{h}
    Sleep, 1
    Send {p}{r}
    Send {Enter}
Return

^+p::
    Send !{v}
    Sleep, 1
    Send {p}
Return

^+d::
    Send !{v}
    Sleep, 1
    Send {d}
Return

^[::Send !{Left}
^]::Send !{Right}
#If

;;; ONENOTE (for Windows)
#If WinActive("ahk_exe ApplicationFrameHost.exe")
^[::Send !+{Left}
^]::Send !+{Right}
Return
#If


;;; OUTLOOK
#If WinActive("ahk_exe OUTLOOK.EXE")
^+m::
    Send !{h}
    Sleep, 1
    Send {m}{v}
Return
#If


;;; FIREFOX
#If WinActive("ahk_exe firefox.exe")
^,::
    Send !{t}
    Sleep, 1
    Send {o}
Return

^Left::Send !{Left}
^Right::Send !{Right}
#If
