//
//  TickerView.h
//  SequencerGame
//
//  Created by Lane on 5/4/13.
//
//

#import <UIKit/UIKit.h>

@interface TickerView : UIView
{
    NSUInteger currentTick;
    NSUInteger numberTicks;
    float interval;
    UIView *thumb;
}

- (id)initWithFrame:(CGRect)frame andTickCount:(NSUInteger)ticks;
- (void)nextTick;
- (void)setTick:(NSUInteger)tick;
- (void)resetTicker;

- (NSUInteger)findNearestTick:(CGFloat)touch;

@end
