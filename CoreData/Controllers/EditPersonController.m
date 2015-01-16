//
//  EditPersonController.m
//  CoreData
//
//  Created by sen5labs on 15/1/16.
//  Copyright (c) 2015年 sen5labs. All rights reserved.
//

#import "EditPersonController.h"
#import "DataManager.h"
#import "Person.h"
@interface EditPersonController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *iconButton;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UITextField *qqText;
@property (weak, nonatomic) IBOutlet UITextField *weiboText;

@end

@implementation EditPersonController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //    设置按钮变成圆形
    _iconButton.layer.cornerRadius = 30.0;
    // 让所有图层跟随主图图层一起变化
    _iconButton.layer.masksToBounds = YES;
    
    if (_editPerson) {
        
        self.nameText.text = _editPerson.name;
        self.phoneText.text = _editPerson.phoneNo;
        self.qqText.text = _editPerson.qq;
        self.weiboText.text = _editPerson.weibo;
        
        UIImage *image = [UIImage imageWithData:_editPerson.icon];
        [_iconButton setImage:image forState:UIControlStateNormal];
    }
}

- (IBAction)savePerson:(id)sender {
    
    NSManagedObjectContext *context = [[DataManager sharedDataManager] sharedContext];
    
    Person *person = _editPerson;
    if (person == nil) {
        person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:context];
    }
    person.name = self.nameText.text;
    person.phoneNo = self.phoneText.text;
    person.qq =  self.qqText.text;
    person.weibo = self.weiboText.text;
    
    NSData *imageData = UIImagePNGRepresentation(_iconButton.imageView.image);
    person.icon = imageData;
    
    // 让上下文保存
    
    if ([context save:nil]) {
        NSLog(@"保存成功");
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        NSLog(@"保存失败");
    }
}

- (IBAction)selectPhoto
{
    // 1. 实例化照片选择控制器
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    // 2. 指定照片来源
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    // 允许编辑
    picker.allowsEditing = YES;
    
    // 3. 设置代理
    picker.delegate = self;
    
    // 4. 显示控制器
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - 照片选择代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    // 设置按钮的图像
    [_iconButton setImage:image forState:UIControlStateNormal];
    
    // 关闭选择器
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
