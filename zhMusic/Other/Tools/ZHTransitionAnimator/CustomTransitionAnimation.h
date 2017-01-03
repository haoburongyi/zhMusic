//
//  CustomTransitionAnimation.h
//  iOS7TransitionDemo
//
//  Created by 陈爱彬 on 15/4/8.
//  Copyright (c) 2015年 陈爱彬. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CCAnimationType) {
    CCAnimationTypePresent,
    CCAnimationTypeDismiss,
};

@interface CustomTransitionAnimation : NSObject
<UIViewControllerTransitioningDelegate>

@property (nonatomic,weak) UIViewController *presentingVC;

@end
