//
//  ZHButton.m
//  btnDemo
//
//  Created by 张淏 on 17/1/1.
//  Copyright © 2017年 张淏. All rights reserved.
//

#import "ZHButton.h"

@interface ZHButton ()
@property (nonatomic, strong) CAShapeLayer *rippleMask;
@end

@implementation ZHButton {
    CGFloat _ripplePercent;
    UIColor *_rippleColor;
    UIColor *_rippleBackgroundColor;
    UIView *_rippleView;
    UIView *_rippleBackgroundView;
    
    BOOL _rippleOverBounds;
    CGFloat _shadowRippleRadius;
    BOOL _shadowRippleEnable;
    BOOL _trackTouchLocation;
    double _touchUpAnimationTime;
    
    CGFloat _tempShadowRadius;
    CGFloat _tempShadowOpacity;
    CGPoint _touchCenterLocation;
}

- (CAShapeLayer *)rippleMask {
    if (!_rippleOverBounds) {
        _rippleMask = [CAShapeLayer layer];
//                _rippleMask.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.layer.cornerRadius].CGPath;
        CGFloat cornerRadies = self.bounds.size.width < self.bounds.size.height ? self.bounds.size.width / 2 : self.bounds.size.height / 2;
        _rippleMask.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadies].CGPath;
        self.clipsToBounds = NO;
        return _rippleMask;
    }
    return nil;
}

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    self->_ripplePercent = 0.8;
    self->_rippleColor = [[UIColor alloc] initWithWhite:0.9 alpha:1];
    self->_rippleBackgroundColor = [[UIColor alloc] initWithWhite:0.95 alpha:1];
    self->_shadowRippleRadius = 1;
    self->_shadowRippleEnable = YES;
    self->_touchUpAnimationTime = 0.6;
    
    
    _rippleBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
    _rippleBackgroundView.backgroundColor = _rippleBackgroundColor;
    [_rippleBackgroundView addSubview:_rippleView];
    _rippleBackgroundView.alpha = 0;
    [self addSubview:_rippleBackgroundView];
    
    self.layer.shadowRadius = 0;
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowColor = [[UIColor alloc] initWithWhite:0.0 alpha:0.5].CGColor;
}


- (void)setupRippleView {
    CGFloat size = self.bounds.size.width * 0.8;
    CGFloat x = (self.bounds.size.width / 2) - (size / 2);
    CGFloat y = (self.bounds.size.height / 2) - (size / 2);
    CGFloat conrner = size / 2;
    
    _rippleView = [[UIView alloc] init];
    _rippleView.backgroundColor = _rippleColor;
    _rippleView.frame = CGRectMake(x, y, size, size);
    _rippleView.layer.cornerRadius = conrner;
}


#pragma mark - 重写
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    
    if (self.imageView.image) {

        [UIView animateWithDuration:0.25 animations:^{
//            self.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1);
            self.imageView.transform = CGAffineTransformMakeScale(0.8, 0.8);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.25 animations:^{
//                self.layer.transform = CATransform3DMakeScale(1, 1, 1);
                self.imageView.transform = CGAffineTransformIdentity;
            }];
        }];
    }
    
    if (_trackTouchLocation) {
        _touchCenterLocation = [touch locationInView:self];
    } else {
        _touchCenterLocation = CGPointZero;
    }
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        _rippleBackgroundView.alpha = 1;
    } completion:nil];
    
    _rippleView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    //    rippleView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    
    [UIView animateWithDuration:0.7 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _rippleView.transform = CGAffineTransformIdentity;
    } completion:nil];
    
    if (_shadowRippleEnable) {
        _tempShadowRadius = self.layer.shadowRadius;
        _tempShadowOpacity = self.layer.shadowOpacity;
        CABasicAnimation *shadowAnim = [CABasicAnimation animationWithKeyPath:@"shadowRadius"];
        shadowAnim.toValue = [NSNumber numberWithFloat:_shadowRippleRadius];
        
        CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"shadowOpacity"];
        opacityAnim.toValue = @1;
        
        CAAnimationGroup *groupAnim = [CAAnimationGroup animation];
        groupAnim.duration = 0.7;
        groupAnim.fillMode = kCAFillModeForwards;
        groupAnim.removedOnCompletion = NO;
        groupAnim.animations = @[shadowAnim, opacityAnim];
        
        [self.layer addAnimation:groupAnim forKey:@"shadow"];
    }
    
    return [super beginTrackingWithTouch:touch withEvent:event];
}

- (void)cancelTrackingWithEvent:(UIEvent *)event {
    [super cancelTrackingWithEvent:event];
    [self animateToNormal];
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super endTrackingWithTouch:touch withEvent:event];
    [self animateToNormal];
}

- (void)animateToNormal {
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        _rippleBackgroundView.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:_touchUpAnimationTime delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            _rippleBackgroundView.alpha = 0;
        } completion:nil];
    }];
    
    [UIView animateWithDuration:0.7 delay:0 options:UIViewAnimationOptionCurveEaseOut | UIViewKeyframeAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^{
        _rippleView.transform = CGAffineTransformIdentity;
        
        CABasicAnimation *shadowAnim = [CABasicAnimation animationWithKeyPath:@"shadowRadius"];
        shadowAnim.toValue = [NSNumber numberWithFloat:_tempShadowRadius];
        
        CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"shadowOpacity"];
        opacityAnim.toValue = [NSNumber numberWithFloat:_tempShadowOpacity];
        
        CAAnimationGroup *groupAnim = [CAAnimationGroup animation];
        groupAnim.duration = 0.7;
        groupAnim.fillMode = kCAFillModeForwards;
        groupAnim.removedOnCompletion = NO;
        groupAnim.animations = @[shadowAnim, opacityAnim];
        
        [self.layer addAnimation:groupAnim forKey:@"shadowBack"];
    } completion:nil];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self setupRippleView];
    
    _rippleView.center = self.center;
    _rippleBackgroundView.layer.frame = self.bounds;
    _rippleBackgroundView.layer.mask = self.rippleMask;
}


@end
