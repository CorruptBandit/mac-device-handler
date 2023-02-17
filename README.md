# MacOS - Device Handler Service (DHS)

Application to run as a service that detects a given device and then runs a script when plugged-in and out, as an example the code in this repository will swich the keyboard layout and scroll direction when a certain device.

**Example Usage**
1. Docking Station is plugged in
1. DHS detects this and performs the following actions:
    * Switches the **keyboard layout** to match the new keyboard being used
    * Switches the **scroll direction** to match the new mouse being used
1. Docking station is unplugged
1. DHS detects this and performs the following actions:
    * Reverts the **keyboard layout** to original layout
    * Reverts the **scroll direction** to original scroll direction


## Installation

An install script has been created, running this script will prompt for the device to detect and then to set-up the service.

Download and further instructions can be found on the [Releases](https://github.com/CorruptBandit/mac-device-handler/releases/tag/v0.0.1-alpha)

## Customisation

DHS can run any script when detecting devices, for the sake of this repository it will change the keyboard and mouse layout. 

**Changing Keyboard Layout and Scroll Direction**

Change the the positional parameters for `/usr/local/bin/SwitchKeyboard` & `/usr/local/bin/SwitchScrollDirection` in [CheckDeviceStatus.sh](./CheckDeviceStatus.sh)

**Running custom scripts**

To run custom scripts, change `/usr/local/bin/SwitchKeyboard` & `/usr/local/bin/SwitchScrollDirection` to the script(s) desired.

```bash
then
    /usr/local/bin/SwitchKeyboard "British-PC"
    /usr/local/bin/SwitchScrollDirection "Standard"
else
    /usr/local/bin/SwitchKeyboard "British"
    /usr/local/bin/SwitchScrollDirection "Natural"
```

_The code in the `then` block is when the device is plugged in, the code in the `else` block is when the device is unplugged_

## Killing the Service

To kill the service run the following command:
```sh
kill -9 $(ps aux | grep '/usr/local/bin/CheckDeviceStatus' | awk '{print $2}' | head -n 1)
```

## Extra Information

### Keyboard Handler

The [keyboard handler](./Keyboard-Handler/src/SwitchKeyboard.swift) is built using Swift as the logic for `TISSelectInputSource` & `TISCreateInputSourceList` are closed source. The script takes one positional argument which is the keyboard layout.

**Build from source**: 

```sh
swiftc -framework Carbon -framework Foundation ./Keyboard-Handler/src/SwitchKeyboard.swift
```

_Requires Xcode tools_

## Scroll Handler

The [scroll handler](./Scroll-Handler/SwitchScrollDirection.sh) uses Apple's osascript to open the system preferences and alter the scroll direction, this is because it is not possible to changing this value using a command. The script takes one positional argument which is the scroll direction.

## Setting up the Service

The service is created using [CheckDeviceStatus.sh](/CheckDeviceStatus.sh) -- the script will continiously run `ioreg -p IOUSB` every _x_ seconds to check if any new devices have been plugged in, if a device has been plugged in it will check if this is the `DEVICE_TO_CHECK` then it will perform actions when plugged-in and unplugged.

_The `DEVICE_TO_CHECK` can either be set as an env var or a positional argument_

## Running the Service

The service is best created by having an application that is auto-run on login, this is to avoid Apple's restrictions on services controlling the desktop interactively.

**Set up an Automator Application**:

Set the application to have `Run Shell Script` action with the following shell command:

```sh
/usr/local/bin/CheckDeviceStatus "<Device to Monitor>" &>/dev/null &
```

After exporting, this will provide a `.app`, like the one found on the [repo](./DHS.app/) -- once this app has the required permissions it can run like any other application.

**Provide DHS with Permissions**:

* `System Preferences --> Security & Privacy --> Click the lock to make changes --> Add DHS to the list`

**Enable DHS on login**:

* `System Preferences --> Users & Groups --> <Your User> --> Login Items --> Click the lock to make changes --> Add DHS to the list`
