//
//  NSObject+BlockAfterDelay.m
//  SequencerGame
//
//  Created by Scott Andrus on 5/4/13.
//
//

#import "NSObject+BlockAfterDelay.h"

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
