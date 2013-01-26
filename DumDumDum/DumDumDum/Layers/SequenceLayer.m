//
//  SequenceLayer.m
//  DumDumDum
//
//  Created by John Saba on 1/26/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "SequenceLayer.h"
#import "DataUtils.h"
#import "GameConstants.h"
#import "SimpleAudioEngine.h"

@implementation SequenceLayer

+ (CCScene *)sceneWithSequence:(int)sequence
{
    CCScene *scene = [CCScene node];
    
    SequenceLayer *sequenceLayer = [[SequenceLayer alloc] initWithSequence:sequence];
    [scene addChild:sequenceLayer];
    
    return scene;
}




- (id)initWithSequence:(int)sequence
{
    self = [super init];
    if (self) {
        
        [self setIsTouchEnabled:YES];
        
        // setup grid
        _gridSize = [DataUtils sequenceGridSize:sequence];
        _gridOrigin = [SequenceLayer sharedGridOrigin];
        
        // patterns
        _finalPattern = [DataUtils sequencePattern:sequence];
        _dynamicPattern = [NSMutableArray arrayWithCapacity:4];
        
    }
    return self;
}

#pragma mark - shared data

+ (CGPoint)sharedGridOrigin
{
    return CGPointMake(100, 100);
}

#pragma mark - scene management

-(void) onEnterTransitionDidFinish
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];
}
-(void) onExit
{
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
}

# pragma mark - draw

- (void)draw
{
    // grid
    ccDrawColor4F(0.5f, 0.5f, 0.5f, 1.0f);
    [GridUtils drawGridWithSize:self.gridSize unitSize:kSizeGridUnit origin:_gridOrigin];
}

#pragma mark - sequencer

- (void)scheduleFinalPattern
{
    //    CCTimer *myTimer = [[CCTimer alloc] initWithTarget:self selector:@selector(playPatternItem:) interval:delay repeat:1 delay:0];

    float delay = 1.0; // Number of seconds between each call of myTimedMethod:
    [self schedule:@selector(playFinalPatternItem:) interval:delay repeat:0 delay:0];
}

- (void)playFinalPatternItem:(ccTime)dt
{
    
    NSLog(@"dt: %g", dt);
    [[SimpleAudioEngine sharedEngine] playEffect:@"Heart Robot 1.caf"];
}

# pragma mark - targeted touch delegate

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSLog(@"touch began");
    [self scheduleFinalPattern];
    
    return YES;
}

@end
