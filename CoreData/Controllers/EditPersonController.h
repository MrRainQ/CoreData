//
//  EditPersonController.h
//  CoreData
//
//  Created by sen5labs on 15/1/16.
//  Copyright (c) 2015年 sen5labs. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Person;
@interface EditPersonController : UITableViewController
// 要编辑的个人信息对象
@property (nonatomic, strong) Person *editPerson;

@end
