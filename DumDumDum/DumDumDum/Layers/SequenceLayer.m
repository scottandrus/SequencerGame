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
#import "SpriteUtils.h"

static NSUInteger const kTotalPatternTicks = 8;

static NSString *const kKeyStandard = @"standard";
static NSString *const kKeyRobot = @"robot";
static NSString *const kKeyMeaty = @"meaty";
static NSString *const kKeyNoSound = @"no sound";


static NSString *const kSoundStandard = @"Heart 1.caf";
static NSString *const kSoundRobot = @"Heart Robot 1.caf";
static NSString *const kSoundMeaty = @"Heart Meaty 1.caf";


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
        _dynamicPattern = [NSMutableArray arrayWithCapacity:8];
        _patternCount = 0;
        
        // buttons
        _finalPatternButton = [CCSprite spriteWithFile:@"armUnit.png"];
        _finalPatternButton.position = CGPointMake(950, 700);
        [self addChild:_finalPatternButton];
        
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

    float delay = .5; // Number of seconds between each call of myTimedMethod:
    [self schedule:@selector(playFinalPatternItem:) interval:delay repeat:kTotalPatternTicks - 1 delay:0];
    
    
}

- (void)playFinalPatternItem:(ccTime)dt
{
    
    NSLog(@"pattern count: %i", self.patternCount);
    
    NSString *key = [self.finalPattern objectAtIndex:self.patternCount];
    
    if ([key isEqualToString:@""] == NO) {
        [[SimpleAudioEngine sharedEngine] playEffect:[self soundNameForKey:key]];
    }
    
    self.patternCount += 1;
    if (self.patternCount == kTotalPatternTicks) {
        self.patternCount = 0;
        NSLog(@"reset pattern count");
    }
}

# pragma mark - targeted touch delegate

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    
    CGPoint touchPosition = [self convertTouchToNodeSpace:touch];

    if (CGRectContainsPoint(self.finalPatternButton.boundingBox, touchPosition)) {
        NSLog(@"final pattern button");
        [self scheduleFinalPattern];
        return YES;
    }

    
    
    return YES;
}

#pragma mark - sound access

- (NSString *)soundNameForKey:(NSString *)key
{
    if ([key isEqualToString:kKeyStandard]) {
        return kSoundStandard;
    }
    else if ([key isEqualToString:kKeyRobot]) {
        return kSoundRobot;
    }
    else if ([key isEqualToString:kKeyMeaty]) {
        return kSoundMeaty;
    }
    else if ([key isEqualToString:kKeyNoSound]) {
        return @"";
    }
    else {
        NSLog(@"warning: sound not found");
        return @"";
    }
    
}

@end
