//
//  UIViewController+ExpandTransition.h
//  SequencerGame
//
//  Created by Scott Andrus on 5/4/13.
//
//

#import <UIKit/UIKit.h>

@interface UIViewController (ExpandTransition)

- (void)presentViewController:(UIViewController *)viewController expandedFromView:(UIView *)view animated:(BOOL)animated completion:(void (^)(void))completion;

- (void)dismissViewControllerBackToView:(UIView *)view animated:(BOOL)animated completion:(void (^)(void))completion;

@end
