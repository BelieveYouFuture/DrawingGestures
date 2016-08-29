//
//  Created by 张文晏
//  Copyright © 2016年 张文晏. All rights reserved.
//
#import <UIKit/UIKit.h>

@class LockView;

@protocol LockViewDelegate <NSObject>

- (void)lockView:(LockView *)lockView didFinishDrawWithPassword:(NSString *)password;

@end

@interface LockView : UIView

@property (nonatomic, weak) id<LockViewDelegate> delegate;


@property (nonatomic, copy) NSString *errorPassword;

@end
