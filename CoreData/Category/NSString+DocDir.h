

#import <Foundation/Foundation.h>

@interface NSString (DocDir)

/**
 *  在指定字符串之前追加沙盒文档路径
 *
 *  @return 包含沙盒文档路径的完整文件路径
 */
- (NSString *)appendDocumentDir;

/**
 *  在指定字符串之前追加沙盒文档路径的URL
 *
 *  @return 包含沙盒文档路径的完整文件路径的URL
 */
- (NSURL *)appendDocumentDirURL;

@end
