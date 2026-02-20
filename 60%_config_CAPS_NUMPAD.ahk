#Requires AutoHotkey v2.0
#SingleInstance Force
SetCapsLockState "AlwaysOff"
tapThreshold := 180       ; temps max (ms) pour considérer un "tap"
SetKeyDelay 1, 1

; ---- Dual role: CapsLock maintenu = Ctrl, tap isolé = Esc (non intercepté) ----
$*CapsLock:: capsTap("CapsLock")
$*SC03A::   capsTap("SC03A")   ; certains claviers exposent CapsLock via scancode 03A

capsTap(keyName) {
    global tapThreshold

    downTick := A_TickCount
    Send "{Ctrl down}"          ; pour que Caps+C, Caps+V, etc. répondent instantanément
    KeyWait keyName
    Send "{Ctrl up}"

    elapsed := A_TickCount - downTick

    ; Détection "aucune autre touche pressée" selon les variations de firmware
    vk := GetKeyVK("CapsLock"), sc := GetKeySC("CapsLock")
    priorIsCaps := (A_PriorKey = "CapsLock")
                 || (A_PriorKey = Format("vk{1:02X}", vk))
                 || (A_PriorKey = Format("sc{1:03X}", sc))

    if (elapsed <= tapThreshold) && priorIsCaps {
        ; IMPORTANT : envoyer un Esc qui n'active PAS le hotkey Esc:: ci-dessous
        SendLevel 0
        SendEvent "{Esc}"
    }
}

; ---- Esc physique -> dead key ` / ~ (US-International with dead keys) ----
#InputLevel 1              ; ce niveau ignore le SendLevel 0 de l'Esc synthétique
Esc::Send "{sc029}"        ; dead ` (OEM_GRAVE)
+Esc::Send "+{sc029}"      ; dead ~ (Shift + OEM_GRAVE)
#InputLevel 0


; --------- Toggle par Right Ctrl (tap) ; maintien = vrai Ctrl ----------
; --------- Paramètres ----------
global NumLayer := false

$*RControl::
{
    global NumLayer, tapThreshold

    downTick := A_TickCount

    ; On joue le vrai Ctrl pour permettre RCtrl + (autre touche)
    Send "{RCtrl down}"
    KeyWait "RControl"
    Send "{RCtrl up}"

    elapsed := A_TickCount - downTick

    ; Détection "RCtrl seul"
    vk := GetKeyVK("RControl"), sc := GetKeySC("RControl")
    priorIsRctrl := (A_PriorKey = "RControl")
        || (A_PriorKey = Format("vk{1:02X}", vk))
        || (A_PriorKey = Format("sc{1:03X}", sc))

    ; Tap rapide et isolé → toggle du layer
    if (elapsed <= tapThreshold) && priorIsRctrl {
        NumLayer := !NumLayer
    }
}

; --------- Layer Numpad (actif seulement si NumLayer = true, ET sans modif.) ----------
; On évite d’intercepter si Ctrl/Alt/Win sont enfoncés → les combos restent natifs.
#HotIf NumLayer
   && !GetKeyState("Ctrl","P")
   && !GetKeyState("Alt","P")
   && !GetKeyState("LWin","P")
   && !GetKeyState("RWin","P")

j::Send "{Numpad1}"
k::Send "{Numpad2}"
l::Send "{Numpad3}"

u::Send "{Numpad4}"
i::Send "{Numpad5}"
o::Send "{Numpad6}"

7::Send "{Numpad7}"
8::Send "{Numpad8}"
9::Send "{Numpad9}"

m::Send "{Numpad0}"
p::Send "{+}"
`;::Send "{Enter}"
0::Send "{-}"

e::Send "{Up}"
d::Send "{Down}"
s::Send "{Left}"
f::Send "{Right}"


#HotIf


; --- Remap Emacs-like navigation ---
^m:: Send "{Enter}"
