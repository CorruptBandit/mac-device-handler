import Carbon
import Foundation

let arguments = CommandLine.arguments
if arguments.count != 2 {
    print("Please provide positional arg: `SwitchKeyboard <layout>`")
    exit(-1)
}
let layout = "com.apple.keylayout.\(arguments[1])"
guard let sources = TISCreateInputSourceList([kTISPropertyInputSourceID: layout] as CFDictionary, false)?.takeRetainedValue() as? [TISInputSource] else {
    exit(-1)
}
let source = sources[0]
let status = TISSelectInputSource(source)
if status != noErr {
    exit(-1)
}
exit(0)
