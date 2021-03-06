//
//  UIViewController+ExpandTransition.m
//  SequencerGame
//
//  Created by Scott Andrus on 5/4/13.
//
//

#import "UIViewController+ExpandTransition.h"

@interface NSObject (BlockAfterDelay)

- (void)performBlock:(void (^)(void))block
          afterDelay:(NSTimeInterval)delay;
- (void)fireBlockAfterDelay:(void (^)(void))block;

@end

@implementation NSObject (BlockAfterDelay)

// http://stackoverflow.com/questions/4007023/blocks-instead-of-performselectorwithobjectafterdelay

- (void)performBlock:(void (^)(void))block
          afterDelay:(NSTimeInterval)delay {
    block = [block copy];
    [self performSelector:@selector(fireBlockAfterDelay:)
               withObject:block
               afterDelay:delay];
}

- (void)fireBlockAfterDelay:(void (^)(void))block {
    block();
}

@end

@implementation UIViewController (ExpandTransition)

- (void)presentViewController:(UIViewController *)viewController
             expandedFromView:(UIView *)view
                     animated:(BOOL)animated
                   completion:(void (^)(void))completion {
    CGRect oldFrame = view.frame;
    NSUInteger oldIndex = [view.superview.subviews indexOfObject:view];
    UIView *mySuperView = view.superview;
    [view removeFromSuperview];
    [self.view addSubview:view];
    
    
    NSLog(@"%@", self.view);
    [UIView animateWithDuration:.25
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         view.frame = CGRectMake(0.0f,
                                                 0.0f,
                                                 self.view.frame.size.height,
                                                 self.view.frame.size.width);
                     }
                     completion:^(BOOL finished) {
                         [self performBlock:^{
                             viewController.modalTransitionStyle =
                             UIModalTransitionStyleCrossDissolve;
                             [self presentViewController:viewController
                                                animated:animated
                                              completion:^{
                                                  [view removeFromSuperview];
                                                  [mySuperView insertSubview:view
                                                                     atIndex:oldIndex];
                                                  view.frame = oldFrame;
                                              }];
                         } afterDelay:.1];
                     }];
}

- (void)dismissViewControllerBackToView:(UIView *)view animated:(BOOL)animated
                             completion:(void (^)(void))completion {
    [self dismissViewControllerAnimated:animated completion:completion];
}

@end
