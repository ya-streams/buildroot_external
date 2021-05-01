hciattach /dev/ttyS0 bcm43xx 921600 noflow -
bluetoothctl list
pulseaudio --start
aplay -D bluealsa:DEV=74:D8:3E:C1:DA:CB,PROFILE=a2dp,HCI=hci0 /root/superMusic/wallada.wav
speaker-test -D bluealsa:DEV=74:D8:3E:C1:DA:CB,PROFILE=a2dp,HCI=hci0

bluetoothctl power on
bluetoothctl scan on
bluetoothctl agent on
bluetoothctl pairable on
bluetoothctl discoverable on
bluetoothctl system-alias "ya_streams"

bluetoothctl connect 74:D8:3E:C1:DA:CB
bluetoothctl connect 70:99:1C:5E:F7:C9

bt-device -c 74:D8:3E:C1:DA:CB
bt-device -c 70:99:1C:5E:F7:C9

