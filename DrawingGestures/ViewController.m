//
//  Created by 张文晏
//  Copyright © 2016年 张文晏. All rights reserved.
//
#import "ViewController.h"
#import "LockViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


#pragma mark
#pragma mark - 绘制手势密码
- (IBAction)drawGesturePassword:(id)sender {
    
    LockViewController *lockController = [[LockViewController alloc] init];
    
    // 设置类型
    lockController.type = LockViewTypeDraw;
    
    [self.navigationController pushViewController:lockController animated:YES];
    
}


#pragma mark
#pragma mark - 绘制解锁密码
- (IBAction)drawUnlockPassword:(id)sender {
    
    // 实例化控制器
    LockViewController *lockController = [[LockViewController alloc] init];
    
    
    // 实例化导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:lockController];
    
    // 设置类型
    lockController.type = LockViewTypeUnlock;
    
    [self presentViewController:nav animated:YES completion:nil];
    
    
    
}

@end
