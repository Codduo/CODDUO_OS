
if grep -Fqa 'accessibility=' /proc/cmdline &> /dev/null; then
    setopt SINGLE_LINE_ZLE
fi


/usr/local/bin/clear-tty1
~/.codduo-welcome.sh

~/.automated_script.sh
