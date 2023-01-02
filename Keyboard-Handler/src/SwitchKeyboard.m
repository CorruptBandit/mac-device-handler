#include <Carbon/Carbon.h>
#include <Foundation/Foundation.h>

int main (int argc, const char * argv[]) {
    if (argc != 2) {
        NSLog(@"Please provide positional arg: `SwitchKeyboard <layout>`");
        return -1;
    }
    NSString *layout = [NSString stringWithFormat:@"com.apple.keylayout.%s", argv[1]];
    NSArray* sources = CFBridgingRelease(TISCreateInputSourceList((__bridge CFDictionaryRef)@{ (__bridge NSString*)kTISPropertyInputSourceID : layout }, FALSE));
    TISInputSourceRef source = (__bridge TISInputSourceRef)sources[0];
    OSStatus status = TISSelectInputSource(source);
    if (status != noErr) {
        return -1;
    }
    return 0;
}
