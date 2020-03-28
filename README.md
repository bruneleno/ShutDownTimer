# ShutDownTimer
ShutDownTimer is a simple GUI for the windows "shutdown" command. You can schedule a shutdown and it gives you a handy timer window.

You know when you leave you PC downloading, uploading, or doing whatever, and you don't want to wait for it to complete so you can shut it off? You can schedule a shutdown trought windows cmd, but you'd have to memorize the command, and convert the time you want to seconds. If you want to cancel the shutdown, well, that's another command to memorize. ShutDown Timer does all of that for you while giving you a handy little timer.


# Installing
If you want to support me AND get a pre-compiled, ready to run portable version of the app, you can get it, for $0,99 with [![paypal](https://www.paypalobjects.com/webstatic/en_US/i/buttons/pp-acceptance-small.png)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=8HG3DXFNS9FNU) .
If you're a bit more advanced and my eternal gratitude is not valuable enough for you, you can get it for free by compiling it yourself, following the instructions below (it's not that hard):


# Compilation
First, download the repo with all it's files, and keep them in a folder. Then you can either <a href="https://www.autohotkey.com/docs/Scripts.htm#ahk2exe">compile it yourself</a> or run the .ahk file with <a href="https://www.autohotkey.com/">AutoHotkey</a> installed in your machine. You're gonna have to install AHK anyway, but if you compile the ahk file to an exe you can uninstall ahk later (if you want to carry it on a usb stick, for example).


# Software utilization
This uses AutoHotkey to do the trick. It converts the time you input to seconds and sends a cmd shutdown command.
