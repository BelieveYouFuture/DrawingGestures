//
//  Created by 张文晏
//  Copyright © 2016年 张文晏. All rights reserved.
//
#import <Foundation/Foundation.h>

// 帮用户进行密码管理
// 工具类  --> 专门为程序做单一事情

@interface LockTool : NSObject



+ (void)savePassword:(NSString *)password;

+ (NSString *)getPassword;



@end
