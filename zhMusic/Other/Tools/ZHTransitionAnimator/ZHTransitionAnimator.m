//
//  ZHTransitionAnimator.m
//  zhMusic
//
//  Created by 张淏 on 17/1/2.
//  Copyright © 2017年 张淏. All rights reserved.
//

#import "ZHTransitionAnimator.h"

@interface ZHTransitionAnimator ()<UIViewControllerAnimatedTransitioning>

@end

@implementation ZHTransitionAnimator

#pragma mark - <UIViewControllerAnimatedTransitioning>

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
}

#pragma mark - <UIViewControllerTransitioningDelegate>

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return self;
}
@end
