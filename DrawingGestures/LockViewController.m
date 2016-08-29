//
//  Created by 张文晏
//  Copyright © 2016年 张文晏. All rights reserved.
//
#import "LockViewController.h"
#import "LockView.h"
#import "LockTool.h"

@interface LockViewController ()<LockViewDelegate>

// 用来记录密码的
@property (nonatomic, strong) NSString *lastPassword;

@property (nonatomic, weak) UILabel *noticeLabel;

@end

@implementation LockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
}


#pragma mark
#pragma mark - 设置界面
- (void)setupUI {
    // 添加提醒的label
    UILabel *noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(-30, 80, 375, 40)];
    
    noticeLabel.textAlignment = NSTextAlignmentCenter;
    
    self.noticeLabel = noticeLabel;
    
    // 设置文本
    //    noticeLabel.text = @"请绘制你的手势密码";
    
    if (_type == LockViewTypeDraw) {
        
        _noticeLabel.text =  @"请绘制你的手势密码";
    } else {
        
        _noticeLabel.text = @"请绘制你的解锁密码";
    }
    
    
    [self.view addSubview:noticeLabel];
    
    CGSize viewSize = self.view.bounds.size;
    
    // 添加lockView
    LockView *lockView = [[LockView alloc] initWithFrame:CGRectMake(0, 0, viewSize.width, viewSize.width)];
    
    // 设置lockView的中心点
    lockView.center = CGPointMake(viewSize.width/2, viewSize.height/2);
    
    lockView.delegate = self;
    
    [self.view addSubview:lockView];
    
}

#pragma mark
#pragma mark - 重写 type 的set方法
- (void)setType:(LockViewType)type {
    _type = type;
    
    // 当值传递过来的时候, view 还没有加载, 所以不能放在这里
    //    if (_type == LockViewTypeDraw) {
    //
    //        _noticeLabel.text =  @"请绘制你的手势密码";
    //    } else {
    //
    //        _noticeLabel.text = @"请绘制你的解锁密码";
    //    }
    
}

#pragma mark
#pragma mark -  lockView 的代理方法
- (void)lockView:(LockView *)lockView didFinishDrawWithPassword:(NSString *)password {
    
    // 在解锁状态下, 才需要取出密码
    if (_type == LockViewTypeUnlock) {
        
        _lastPassword =  [LockTool getPassword];
    }
    
    
    
    if (_lastPassword == nil) {
        // 是第一次输入
        _lastPassword = password;
        
        // 修改label文字显示
        [self showNoticeMessageWith:@"请再次绘制手势密码" success:YES];
        
    } else {
        // 表示 第二次绘制
        if ([_lastPassword isEqualToString:password]) {
            // 密码正确
            // 保存密码
            [LockTool savePassword:password];
            
            
            // 修改label文本显示
            
            [self showNoticeMessageWith:@"两次绘制相同, 即将返回首页" success:YES];
            
            
            // 返回主界面
            
            [self backToHome];
            
            
            
        } else {
            // 密码错误
            [self showNoticeMessageWith:@"两次绘制的不同, 请重新绘制" success:NO];
            
            // 通知 lockView 错误的密码, 然后, lockView 进行绘制
            
            lockView.errorPassword = password;
        }
    }
}

#pragma mark
#pragma mark - 返回主界面
- (void)backToHome {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (_type == LockViewTypeUnlock) {
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    });
}


#pragma mark
#pragma mark - 修改noticeLabel的显示效果
- (void)showNoticeMessageWith:(NSString *)text success:(BOOL)success {
    
    _noticeLabel.text = text;
    
    UIColor *color = success ? [UIColor blackColor] : [UIColor redColor];
    
    _noticeLabel.textColor = color;
    
    
    _noticeLabel.transform = CGAffineTransformMakeTranslation(20, 0);
    
    if (!success) {
        // 颤抖吧
        
        [UIView animateWithDuration:0.5
                              delay:0
             usingSpringWithDamping:0.2
              initialSpringVelocity:0.8
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             
                             _noticeLabel.transform = CGAffineTransformIdentity;
                             
                         }
                         completion:^(BOOL finished) {
                             _noticeLabel.transform = CGAffineTransformIdentity;
                             
                         }];
    }
    
}

@end








