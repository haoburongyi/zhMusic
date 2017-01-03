//
//  CustomTransitionAnimation.m
//  iOS7TransitionDemo
//
//  Created by 陈爱彬 on 15/4/8.
//  Copyright (c) 2015年 陈爱彬. All rights reserved.
//

#import "CustomTransitionAnimation.h"

@interface CustomTransitionAnimation()
<UIViewControllerAnimatedTransitioning>

@property (nonatomic,assign) CCAnimationType animationType;
@property (nonatomic) BOOL interacting;
@property (nonatomic,strong) UIPercentDrivenInteractiveTransition *interactiveTransition;

@end

@implementation CustomTransitionAnimation

- (void)setPresentingVC:(UIViewController *)presentingVC
{
    _presentingVC = presentingVC;
    //添加手势
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [_presentingVC.view addGestureRecognizer:panGesture];
}
#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    //设置Present和Dismiss的动画时间都是0.5秒
    return 0.5;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    if (self.animationType == CCAnimationTypePresent) {
        /*弹出动画*/
        //获取containerView视图
        UIView *containerView = [transitionContext containerView];
        //获取新的Present视图
        UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        //对要Present出来的视图设置初始位置
        CGRect boundsRect = [[UIScreen mainScreen] bounds];
        CGRect finalFrame = [transitionContext finalFrameForViewController:toVc];
        toVc.view.frame = CGRectOffset(finalFrame, 0, boundsRect.size.height);
        //添加Present视图
        [containerView addSubview:toVc.view];
        //UIView动画切换,在这里用Spring动画做效果
        NSTimeInterval interval = [self transitionDuration:transitionContext];
        toVc.view.frame = finalFrame;
        [transitionContext completeTransition:YES];return;
        [UIView animateWithDuration:interval delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
            toVc.view.frame = finalFrame;
        }completion:^(BOOL finished) {
            //通知动画已经完成
            [transitionContext completeTransition:YES];
        }];
    }else if (self.animationType == CCAnimationTypeDismiss) {
        /*消失动画*/
        //获取containerView视图
        UIView *containerView = [transitionContext containerView];
        //获取已经在最前的Present视图
        UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        //获取Dismiss完将要显示的VC
        UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        //在Present视图下面插入视图
        [containerView insertSubview:toVc.view belowSubview:fromVc.view];
        //设置最终位置
        CGRect boundsRect = [[UIScreen mainScreen] bounds];
        CGRect originFrame = [transitionContext initialFrameForViewController:fromVc];
        CGRect finalFrame = CGRectOffset(originFrame, 0, boundsRect.size.height);
        //UIView动画切换
        NSTimeInterval interval = [self transitionDuration:transitionContext];
        [UIView animateWithDuration:interval delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            //            fromVc.view.alpha = 0.f;
            fromVc.view.frame = finalFrame;
        }completion:^(BOOL finished) {
            //通知动画是否完成
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
}
#pragma mark - UIPanGestureRecognizer Handler
- (void)handlePan:(UIPanGestureRecognizer *)gesture
{
    CGPoint tranlation = [gesture translationInView:_presentingVC.view];
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            //设置交互标识为YES
            self.interacting = YES;
            //生成UIPercentDrivenInteractiveTransition对象
            self.interactiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
            //DismissViewController
            [_presentingVC dismissViewControllerAnimated:YES completion:nil];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            //计算当前百分比值
            CGFloat percent = tranlation.y / CGRectGetHeight(_presentingVC.view.frame);
            percent = MIN(MAX(0.0, percent), 1.0);
            //用updateInteractiveTransition通知更新的百分比
            [self.interactiveTransition updateInteractiveTransition:percent];
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            //设置交互标识为NO
            self.interacting = NO;
            //判断是否完成交互
            if (tranlation.y > 200) {
                [self.interactiveTransition finishInteractiveTransition];
            }else{
                [self.interactiveTransition cancelInteractiveTransition];
            }
            //置空UIPercentDrivenInteractiveTransition对象
            self.interactiveTransition = nil;
        }
            break;
        default:
            break;
    }
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                   presentingController:(UIViewController *)presenting
                                                                       sourceController:(UIViewController *)source
{
    self.animationType = CCAnimationTypePresent;
    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.animationType = CCAnimationTypeDismiss;
    return self;
}
- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator
{
    return nil;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator
{
    return self.interacting ? self.interactiveTransition : nil;
}

@end
