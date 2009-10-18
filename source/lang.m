#import <Foundation/Foundation.h>
#import "Lang.h"

int main (int argc, const char *argv[]) {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

    if (argc>0) {
        Lang *lang = [[Lang alloc] init];
        NSString *filePath = [NSString stringWithCString:argv[1] encoding:NSUTF8StringEncoding];
        NSString *codeText = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
        [lang run:codeText];
    } else {
        NSLog(@"Provide program file name");
    }
    [pool drain];
    return 0;
}
