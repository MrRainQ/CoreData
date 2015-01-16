//
//  DataManager.h
//  CoreData
//
//  Created by sen5labs on 15/1/16.
//  Copyright (c) 2015年 sen5labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

@property (nonatomic, strong, readonly) NSManagedObjectContext *sharedContext;
+ (instancetype)sharedDataManager;
@end
