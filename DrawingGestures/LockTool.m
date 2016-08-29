//
//  Created by 张文晏
//  Copyright © 2016年 张文晏. All rights reserved.
//
#import "LockTool.h"

#define kPassword @"password"

@implementation LockTool

+ (void)savePassword:(NSString *)password {
    
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:kPassword];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getPassword {
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:kPassword];
}

@end
