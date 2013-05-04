//
//  NSObject+BlockAfterDelay.h
//  SequencerGame
//
//  Created by Scott Andrus on 5/4/13.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (BlockAfterDelay)

- (void)performBlock:(void (^)(void))block
          afterDelay:(NSTimeInterval)delay;
- (void)fireBlockAfterDelay:(void (^)(void))block;

@end
