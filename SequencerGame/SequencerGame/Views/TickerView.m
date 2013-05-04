//
//  TickerView.m
//  SequencerGame
//
//  Created by Lane on 5/4/13.
//
//

#import "TickerView.h"

@implementation TickerView

- (id)initWithFrame:(CGRect)frame andTickCount:(NSUInteger)ticks
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        currentTick = 0;
        numberTicks = ticks;
        interval = frame.size.width / ticks;
        
        // Set up top level view
        [self setBackgroundColor:[UIColor clearColor]];
        
        // Set up the "thumb."
        thumb = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, frame.size.height)];
        [thumb setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:thumb];
    }
    return self;
}

- (void)nextTick;
{
    if (currentTick < numberTicks)
    {
        [self setTick:++currentTick];
    }
}

- (void)setTick:(NSUInteger)tick;
{
    currentTick = tick;
    float center = currentTick * interval;
    CGRect rect = CGRectMake(center, thumb.frame.origin.y, thumb.frame.size.width, thumb.frame.size.height);
    [thumb setFrame:rect];
}

- (void)resetTicker;
{
    [self setTick:0];
}

// Moves the thumb to the nearest tick
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view];
    
    [self setTick:[self findNearestTick:location.x]];
}

- (NSUInteger)findNearestTick:(CGFloat)touch
{
    NSUInteger curClosestTick;
    CGFloat minDifference = CGFLOAT_MAX;
    for (NSUInteger i = 0; i < numberTicks; i++)
    {
        CGFloat calcVal = fabs((i*interval) - touch);
        if (calcVal < minDifference)
        {
            minDifference = calcVal;
            curClosestTick = i;
        }
    }
    
    return curClosestTick;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
