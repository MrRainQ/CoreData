//
//  MainViewController.m
//  CoreData
//
//  Created by sen5labs on 15/1/16.
//  Copyright (c) 2015年 sen5labs. All rights reserved.
//

#import "MainViewController.h"
#import <CoreData/CoreData.h>
#import "DataManager.h"
#import "Person.h"
#import "EditPersonController.h"

@interface MainViewController ()<NSFetchedResultsControllerDelegate, UISearchBarDelegate>
{
    // 查询结果控制器
    NSFetchedResultsController *_fetchedResultsController;
    
    NSArray *_dataList;
}
@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 初始化数据
    [self loadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_fetchedResultsController.sections[0] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"myCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    Person *person = [_fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = person.name;
    
    return cell;
}


- (void)loadData
{
    NSManagedObjectContext *context = [[DataManager sharedDataManager] sharedContext];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    
    NSSortDescriptor * sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = @[sort];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    _fetchedResultsController.delegate = self;
    NSError *error = nil;
    if ([_fetchedResultsController performFetch:&error]) {
        NSLog(@"查询成功");
        NSLog(@"%@", _fetchedResultsController.sections);
    }else {
        NSLog(@"查询失败");
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UITableViewCellEditingStyleDelete == editingStyle) {
        
        Person *person = [_fetchedResultsController objectAtIndexPath:indexPath];
        
        NSManagedObjectContext *context = [[DataManager sharedDataManager] sharedContext];
        [context deleteObject:person];
        
        if ([context save:nil]) {
            NSLog(@"删除成功");
        }else{
            NSLog(@"删除失败");
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    [self performSegueWithIdentifier:@"aaaa" sender:indexPath];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *identifier = segue.identifier;
    
    if ([identifier isEqualToString:@"aaaa"]) {
        
        NSIndexPath *indexPath = sender;
        
        Person *person = [_fetchedResultsController objectAtIndexPath:indexPath];
    
        EditPersonController *edit = segue.destinationViewController;
        
        edit.editPerson = person;

    }
}

#pragma mark - 
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    // 在CoreDada中做模糊查询
    NSFetchRequest *request = _fetchedResultsController.fetchRequest;
    
    if (searchText.length > 0 ) {
        
        request.predicate = [NSPredicate predicateWithFormat:@"name CONTAINS %@",searchText];
    }else {
        request.predicate = nil;
    }
    
    if ([_fetchedResultsController performFetch:nil]) {
        NSLog(@"刷新成功");
        [self.tableView reloadData];
    }
}

@end
