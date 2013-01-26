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
static NSUInteger const kTotalHeartTypes = 4;


static NSString *const kKeyStandard = @"standard";
static NSString *const kKeyRobot = @"robot";
static NSString *const kKeyMeaty = @"meaty";
static NSString *const kKeyAlien = @"alien";
static NSString *const kKeyNoSound = @"no sound";


static NSString *const kSoundStandard = @"Heart 1.caf";
static NSString *const kSoundRobot = @"Heart Robot 1.caf";
static NSString *const kSoundMeaty = @"Heart Meaty 1.caf";
static NSString *const kSoundAlien = @"NEEDS FILE";

typedef enum
{
    kBeatTypeNone,
    kBeatTypeStandard,
    kBeatTypeRobot,
    kBeatTypeMeaty,
    kBeatTypeAlien
}kBeatType;


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
        _patternCount = 0;
        _finalPattern = [DataUtils sequencePattern:sequence];
        _dynamicPattern = [NSMutableArray array];
        [_dynamicPattern addObjectsFromArray:[NSArray arrayWithObjects:
                                              kKeyNoSound,
                                              kKeyNoSound,
                                              kKeyNoSound,
                                              kKeyNoSound,
                                              kKeyNoSound,
                                              kKeyNoSound,
                                              kKeyNoSound,
                                              kKeyNoSound, nil]];
        
        
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

    // touch final pattern button to play final pattern
    if (CGRectContainsPoint(self.finalPatternButton.boundingBox, touchPosition)) {
        [self scheduleFinalPattern];
        return YES;
    }
    
    // touch dynamic pattern button to play dynamic pattern
    // needs implementation

    
    // add heart beat to sequencer if touch on grid
    GridCoord cell = [GridUtils gridCoordForAbsolutePosition:touchPosition unitSize:kSizeGridUnit origin:self.gridOrigin];
    if ([self isValidCell:cell]) {
        
        // always remove whatever graphic is at the current dynamicPattern index -- we only support one beat per tick
        
        if (cell.y == kBeatTypeStandard) {
            [self handleCellSelectionX:cell.x key:kKeyStandard];
        }
        else if (cell.y == kBeatTypeRobot) {
            [self handleCellSelectionX:cell.x key:kKeyRobot];
        }
        else if (cell.y == kBeatTypeMeaty) {
            [self handleCellSelectionX:cell.x key:kKeyMeaty];
        }
        else if (cell.y == kBeatTypeAlien) {
            [self handleCellSelectionX:cell.x key:kKeyAlien];
        }
        
        NSLog(@"self.dynamicPattern: %@", self.dynamicPattern);
        
        return YES;
    }
    
    return YES;
}

- (void)handleCellSelectionX:(int)x key:(NSString *)key
{
    if ([[self.dynamicPattern objectAtIndex:x - 1] isEqualToString:key]) {
        [self.dynamicPattern replaceObjectAtIndex:x - 1 withObject:kKeyNoSound];
        // remove graphic
    }
    else {
        [self.dynamicPattern replaceObjectAtIndex:x - 1 withObject:key];
        // add graphic
    }
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

#pragma mark - custom cell helpers

- (BOOL)isValidCell:(GridCoord)cell
{
    if (cell.x >= 1 && cell.x <= kTotalPatternTicks && cell.y >= 1 && cell.y <= kTotalHeartTypes) {
        return YES;
    }
    return NO;
}
@end
