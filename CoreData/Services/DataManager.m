//
//  DataManager.m
//  CoreData
//
//  Created by sen5labs on 15/1/16.
//  Copyright (c) 2015年 sen5labs. All rights reserved.
//

#import "DataManager.h"
#import <CoreData/CoreData.h>
#import "NSString+DocDir.h"
static DataManager *_instance;

@implementation DataManager

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    
    return _instance;
}

+ (instancetype)sharedDataManager
{
    if (_instance == nil) {
        _instance = [[DataManager alloc]init];
    }
    return  _instance;
}

- (id)init
{
    self = [super init];
    
    if (self) {
        [self openDB];
    }
    
    return self;
}

- (void)openDB
{
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
   
    NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
    
    // 数据库是一个文件，持久化连接的文件
    NSError *error = nil;
    NSURL *url = [@"my.db" appendDocumentDirURL];

    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
    
    if (error == nil) {
       
        NSLog(@"数据库建立成功");
        
        _sharedContext = [[NSManagedObjectContext alloc]init];
        
        _sharedContext.persistentStoreCoordinator = store;
        
    }else{
        NSLog(@"数据库建立失败");
    }
}

@end
