#!/usr/bin/env bash

# Rofi powermenu (stolen from adi1090x and adapted)

# Theme Elements
prompt="$(hostname)"
mesg="Uptime : $(uptime -p | sed 's/up //g')"

# Options
option_1=$'\UEE2F  Lock'
option_2=$'\UEE11  Logout'
option_3=$'\UEE23  Suspend'
option_4=$'\UEB44  Reboot'
option_5=$'\UEE00  Shutdown'
yes=$'\UEE2C  Yes'
no=$'\UEE12  No'

rofi_cmd() {
    rofi -dmenu \
        -p "$prompt" \
        -mesg "$mesg" \
        -markup-rows \
        -theme ~/.config/rofi/powermenu.rasi
}

run_rofi() {
    echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5" | rofi_cmd
}

confirm_cmd() {
    rofi -theme-str 'window {location: center; anchor: center; width: 300px;}' \
        -theme-str 'mainbox {children: [ "message", "listview" ];}' \
        -theme-str 'listview {columns: 2; lines: 1; spacing: 10px;}' \
        -theme-str 'element-text {horizontal-align: 0.5;}' \
        -theme-str 'textbox {horizontal-align: 0.5;}' \
        -dmenu -p 'Confirmation' -mesg 'Are you Sure?' \
        -theme ~/.config/rofi/powermenu.rasi
}

confirm_exit() {
    echo -e "$yes\n$no" | confirm_cmd
}

confirm_run() {
    selected="$(confirm_exit)"
    if [[ "$selected" == "$yes" ]]; then
        ${1} && ${2} && ${3}
    else
        exit
    fi
}

run_cmd() {
    case "$1" in
        --opt1) i3lock -c 1F1F1F --radius 150 --ring-width 8 --ring-color bc13fe --keyhl-color ffffff --line-color 00000000 --inside-color 1F1F1F --insidever-color 5e35b1 --ringver-color ffffff --screen 1 --clock ;;
        --opt2) confirm_run 'i3-msg exit' ;;
        --opt3) confirm_run 'systemctl suspend' ;;
        --opt4) confirm_run 'systemctl reboot' ;;
        --opt5) confirm_run 'systemctl poweroff' ;;
    esac
}

chosen="$(run_rofi)"
case "$chosen" in
    "$option_1") run_cmd --opt1 ;;
    "$option_2") run_cmd --opt2 ;;
    "$option_3") run_cmd --opt3 ;;
    "$option_4") run_cmd --opt4 ;;
    "$option_5") run_cmd --opt5 ;;
esac
