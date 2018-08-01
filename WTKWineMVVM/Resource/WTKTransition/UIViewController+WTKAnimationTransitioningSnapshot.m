//
//  UIViewController+WTKAnimationTransitioningSnapshot.m
//  WTKPushAndPopAnimation
//
//  Created by 王同科 on 16/9/22.
//  Copyright © 2016年 王同科. All rights reserved.
//

#import "UIViewController+WTKAnimationTransitioningSnapshot.h"
#import "WTKShoppingManager.h"
#import <objc/runtime.h>
@implementation UIViewController (WTKAnimationTransitioningSnapshot)

- (UIView *)snapshot
{
    UIView *view = objc_getAssociatedObject(self, @"WTKAnimationTransitioningSnapshot");
    if (!view)
    {
        
//        view = [self.navigationController.view snapshotViewAfterScreenUpdates:NO];
        view = [self.tabBarController.view snapshotViewAfterScreenUpdates:YES];
//        view=  [self imageFromView:self.view];
//        view = [self.tabBarController.view resizableSnapshotViewFromRect:self.tabBarController.view.frame afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
      
        [self setSnapshot:view];
    }
    return view;
}

- (void)setSnapshot:(UIView *)snapshot
{
    objc_setAssociatedObject(self, @"WTKAnimationTransitioningSnapshot", snapshot, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (UIView *)topSnapshot
{
    UIView *view = objc_getAssociatedObject(self, @"WTKAnimationTransitioningTopSnapshot");
    if(!view)
    {
        view = [self.navigationController.view resizableSnapshotViewFromRect:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), 64) afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
        
        [self setTopSnapshot:view];
    }
    return view;
}
- (void)setTopSnapshot:(UIView *)topSnapshot
{
    objc_setAssociatedObject(self, @"WTKAnimationTransitioningTopSnapshot", topSnapshot, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (UIView *)viewSnapshot
{
    UIView *view = objc_getAssociatedObject(self, @"WTKAnimationTransitioningViewSnapshot");
    if (!view)
    {
        view = [self.navigationController.view resizableSnapshotViewFromRect:CGRectMake(0, 64, CGRectGetWidth([[UIScreen mainScreen] bounds]), CGRectGetHeight([[UIScreen mainScreen] bounds]) - 64) afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
        [self setViewSnapshot:view];
    }
    return view;
}

- (void)setViewSnapshot:(UIView *)viewSnapshot
{
    objc_setAssociatedObject(self, @"WTKAnimationTransitioningViewSnapshot", viewSnapshot, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)imageFromView:(UIView *)snapView {
//    UIGraphicsBeginImageContext(snapView.frame.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [snapView.layer renderInContext:context];
//    UIImage *targetImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    UIImageView *tmpView = [[UIImageView alloc] initWithImage:targetImage];
//    tmpView.frame = snapView.frame;
//    return tmpView;
    
    UIGraphicsBeginImageContextWithOptions(snapView.bounds.size, snapView.opaque, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [snapView.layer renderInContext:context];
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *tmpView = [[UIImageView alloc] initWithImage:snapshot];
    tmpView.frame = snapView.frame;
    return tmpView;
    
    
}
@end
