//
//  Person.h
//  CoreData
//
//  Created by sen5labs on 15/1/16.
//  Copyright (c) 2015年 sen5labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * phoneNo;
@property (nonatomic, retain) NSString * qq;
@property (nonatomic, retain) NSString * weibo;
@property (nonatomic, retain) NSData * icon;

@end
