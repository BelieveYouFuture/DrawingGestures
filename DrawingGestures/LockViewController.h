//
//  Created by 张文晏
//  Copyright © 2016年 张文晏. All rights reserved.
//
#import <UIKit/UIKit.h>

// 定义枚举, 用来表示 绘制的类型
typedef NS_ENUM(NSInteger, LockViewType) {
    
    // 绘制解锁密码
    LockViewTypeDraw,
    
    // 输入解锁密码
    LockViewTypeUnlock
};

@interface LockViewController : UIViewController


@property (nonatomic, assign) LockViewType type;

@end
