#include <Misc.au3>

Global $activeDirection = 0
; 0 = nic
; 1 = A / F6
; 2 = D / F7

Global $aWasDown = False
Global $dWasDown = False

While 1

    If WinActive("STALZONE") Then

        Local $aDown = _IsPressed("41") ; A
        Local $dDown = _IsPressed("44") ; D

        ; ==============================
        ; NOWE NACISNIECIE A
        ; ==============================
        If $aDown And Not $aWasDown Then

            ; Pusc F7
            If $activeDirection = 2 Then
                Send("{F7 up}")
            EndIf

            ; Wcisnij F6
            Send("{F6 down}")
            $activeDirection = 1

        EndIf


        ; ==============================
        ; NOWE NACISNIECIE D
        ; ==============================
        If $dDown And Not $dWasDown Then

            ; Pusc F6
            If $activeDirection = 1 Then
                Send("{F6 up}")
            EndIf

            ; Wcisnij F7
            Send("{F7 down}")
            $activeDirection = 2

        EndIf


        ; ==============================
        ; PUSZCZENIE A
        ; ==============================
        If Not $aDown And $aWasDown Then

            If $activeDirection = 1 Then

                Send("{F6 up}")

                ; D nadal trzymane
                If $dDown Then
                    Send("{F7 down}")
                    $activeDirection = 2
                Else
                    $activeDirection = 0
                EndIf

            EndIf

        EndIf


        ; ==============================
        ; PUSZCZENIE D
        ; ==============================
        If Not $dDown And $dWasDown Then

            If $activeDirection = 2 Then

                Send("{F7 up}")

                ; A nadal trzymane
                If $aDown Then
                    Send("{F6 down}")
                    $activeDirection = 1
                Else
                    $activeDirection = 0
                EndIf

            EndIf

        EndIf


        $aWasDown = $aDown
        $dWasDown = $dDown

    Else

        ; ==============================
        ; STALZONE NIEAKTYWNE
        ; ==============================

        If $activeDirection = 1 Then
            Send("{F6 up}")
        ElseIf $activeDirection = 2 Then
            Send("{F7 up}")
        EndIf

        $activeDirection = 0
        $aWasDown = False
        $dWasDown = False

    EndIf

    Sleep(1)

WEnd
