
#import "NSString+DocDir.h"

@implementation NSString (DocDir)

- (NSString *)appendDocumentDir
{
    NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];

    return [docDir stringByAppendingPathComponent:self];
}

- (NSURL *)appendDocumentDirURL
{
    return [NSURL fileURLWithPath:[self appendDocumentDir]];
}

@end
