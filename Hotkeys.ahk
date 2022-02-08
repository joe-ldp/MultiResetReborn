; v0.1.0

RAlt::Suspend ; Pause all macros
^LAlt::Reload ; Reload if macro locks up
*I::SetTitles()

*Y::GoToActiveInstance()

#IfWinActive, Minecraft
{
    *U::Reset()

    *Numpad1::BackgroundReset(1)
    *Numpad2::BackgroundReset(2)
    *Numpad3::BackgroundReset(3)
    *Numpad4::BackgroundReset(4)
}