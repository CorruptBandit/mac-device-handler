# DSH

Application to run as a service that detecs a given device and then 
swiches the keyboard layout and scroll direction.

## Keyboard Handler

**Build from source**: `clang -framework Carbon -framework Foundation 
./Keyboard-Handler/src/SwitchKeyboard.m -o 
./Keyboard-Handler/SwitchKeyboard`

## Scroll Handler

.

## Setting up the Service

.

### Running the Service

Set up an Automator Application with the following: 
`/usr/local/bin/CheckDeviceStatus "Wireless Headset" &>/dev/null &`

### Killing the Service

Run the following command: `kill -9 $(ps aux | grep 
'/usr/local/bin/CheckDeviceStatus' | awk '{print $2}' | head -n 1)`



# mac-device-handler
# mac-device-handler
# mac-device-handler
