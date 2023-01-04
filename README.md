# MacOS - Device Handler Service (DHS)

Application to run as a service that detecs a given device and then 
swiches the keyboard layout and scroll direction.

## Keyboard Handler

**Build from source**: 

```sh
clang -framework Carbon -framework Foundation ./Keyboard-Handler/src/SwitchKeyboard.m -o ./Keyboard-Handler/SwitchKeyboard
```

_Requires Xcode tools_

## Scroll Handler

.

## Setting up the Service

.

### Running the Service

**Set up an Automator Application**:

Set the application to have `Run Shell Script` action with the following shell command:

```sh
/usr/local/bin/CheckDeviceStatus "<Device to Monitor>" &>/dev/null &
```

**Provide DSH with Permissions**: 
- System Preferences --> Security & Privacy --> Click the lock to make changes --> Add DHS to the list

### Killing the Service

```sh
kill -9 $(ps aux | grep '/usr/local/bin/CheckDeviceStatus' | awk '{print $2}' | head -n 1)
```
