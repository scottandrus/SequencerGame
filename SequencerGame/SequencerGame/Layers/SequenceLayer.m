//
//  SequenceLayer.m
//  SequencerGame
//
//  Created by John Saba on 1/26/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "SequenceLayer.h"
#import "DataUtils.h"
#import "GameConstants.h"
#import "SimpleAudioEngine.h"
#import "SpriteUtils.h"
#import "CCTMXTiledMap+Utils.h"
#import "SGTiledUtils.h"
#import "TextureUtils.h"
#import "CellObjectLibrary.h"
#import "Tone.h"
#import "TickDispatcher.h"
#import "SGTiledUtils.h"
#import "Arrow.h"

static NSUInteger const kTotalPatternTicks = 8;
static NSUInteger const kTotalHeartTypes = 4;

static NSString *const kKeyStandard = @"standard";
static NSString *const kKeyRobot = @"robot";
static NSString *const kKeyMeaty = @"meaty";
static NSString *const kKeyAlien = @"alien";
static NSString *const kKeyNoSound = @"no sound";

static NSString *const kSoundStandard = @"Heart 4.caf";
static NSString *const kSoundRobot = @"Heart Robot 1.caf";
static NSString *const kSoundMeaty = @"Heart Meaty 2.caf";
static NSString *const kSoundAlien = @"Heart Alien New.caf";

static CGFloat const kPatternDelay = 0.5;

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
        self.isTouchEnabled = YES;
        
        [TextureUtils loadTextures];
        
        NSString *sequenceName = [NSString stringWithFormat:@"seq%i.tmx", sequence];
        self.tileMap = [CCTMXTiledMap tiledMapWithTMXFile:sequenceName];
        self.gridSize = [GridUtils gridCoordFromSize:self.tileMap.mapSize];
        
        // cell object library
        self.cellObjectLibrary = [[CellObjectLibrary alloc] initWithGridSize:_gridSize];

        // setup tick dispatcher with sequence and starting point
        NSMutableDictionary *seq = [self.tileMap objectNamed:kTLDObjectSequence groupNamed:kTLDGroupTickResponders];
        NSMutableDictionary *entry = [self.tileMap objectNamed:kTLDObjectEntry groupNamed:kTLDGroupTickResponders];
        self.tickDispatcher = [[TickDispatcher alloc] initWithEventSequence:seq entry:entry tiledMap:self.tileMap];
        [self addChild:self.tickDispatcher];

        // tones
        self.tones = [NSMutableArray array];
        NSMutableArray *tones = [self.tileMap objectsWithName:kTLDObjectTone groupName:kTLDGroupTickResponders];
        for (NSMutableDictionary *tone in tones) {
            Tone *toneNode = [[Tone alloc] initWithTone:tone tiledMap:self.tileMap puzzleOrigin:self.position];
            [self.tones addObject:toneNode];
            [self.cellObjectLibrary addNode:toneNode cell:toneNode.cell];
            [self.tickDispatcher registerTickResponder:toneNode];
            [self addChild:toneNode];
        }
        
        // arrows
        self.arrows = [NSMutableArray array];
        NSMutableArray *arrows = [self.tileMap objectsWithName:kTLDObjectArrow groupName:kTLDGroupTickResponders];
        for (NSMutableDictionary *arrow in arrows) {
            Arrow *arrowNode = [[Arrow alloc] initWithArrow:arrow tiledMap:self.tileMap puzzleOrigin:self.position];
            [self.arrows addObject:arrowNode];
            [self.cellObjectLibrary addNode:arrowNode cell:arrowNode.cell];
            [self.tickDispatcher registerTickResponder:arrowNode];
            [self addChild:arrowNode];
        }
    }
    return self;
}

+ (CGPoint)sharedGridOrigin
{
    return CGPointMake((1024 - 800)/2, 130);
}

- (void)playUserSequence
{
    [self.tickDispatcher start];
}

- (void)playSolutionSequence
{
    [self.tickDispatcher scheduleSequence];
}

#pragma mark - scene management

- (void)onEnter
{
    [super onEnter];
    
    _dispatcher = [[PdDispatcher alloc] init];
    [PdBase setDelegate:_dispatcher];
    _patch = [PdBase openFile:@"synth.pd" path:[[NSBundle mainBundle] resourcePath]];
    if (!_patch) {
        NSLog(@"Failed to open patch");
        // handle failure
    }    
}

- (void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];
}
- (void)onExit
{
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
    
    [PdBase closeFile:_patch];
    [PdBase setDelegate:nil];

    [super onExit];
}

- (void)draw
{
    // grid
    ccDrawColor4F(0.5f, 0.5f, 0.5f, 1.0f);
    [GridUtils drawGridWithSize:self.gridSize unitSize:kSizeGridUnit origin:_gridOrigin];
}

#pragma mark - Tick Interface

- (void)scheduleFinalPattern
{
    float delay = kPatternDelay; // Number of seconds between each call of myTimedMethod:
    [self schedule:@selector(playFinalPatternItem:) interval:delay repeat:kTotalPatternTicks - 1 delay:0];
}

- (void)scheduleDynamicPattern
{
    float delay = kPatternDelay; // Number of seconds between each call of myTimedMethod:
    [self schedule:@selector(playDynamicPatternItem:) interval:delay repeat:kTotalPatternTicks - 1 delay:0];  
}

//- (void)playFinalPatternItem:(ccTime)dt
//{
//    [self playPatternItem:self.finalPattern];
//}
//
//- (void)playDynamicPatternItem:(ccTime)dt
//{
//    [self playPatternItem:self.dynamicPattern];
//}


//- (void)handleCellSelection:(GridCoord)cell key:(NSString *)key
//{
//    if ([[self.dynamicPattern objectAtIndex:cell.x - 1] isEqualToString:key]) {
//        [self.dynamicPattern replaceObjectAtIndex:cell.x - 1 withObject:kKeyNoSound];        
//        [self removeBeatSpriteFromCell:cell];
//    }
//    else {
//        [self.dynamicPattern replaceObjectAtIndex:cell.x - 1 withObject:key];
////        [self addBeatSpriteToCell:cell];
//    }
//}



#pragma mark - access heart sprites

//- (void)addBeatSpriteToCell:(GridCoord)cell
//{
//    NSString *keyString = [NSString stringWithFormat:@"%i%i", cell.x, cell.y];
//    CCSprite *sprite = [self heartSpriteForBeatType:(kBeatType)cell.y];
//    sprite.position = [GridUtils absoluteSpritePositionForGridCoord:cell unitSize:kSizeGridUnit origin:self.gridOrigin];
//    [self.heartSprites setObject:sprite forKey:keyString];
//    [self addChild:sprite];
//}

//- (void)removeBeatSpriteFromCell:(GridCoord)cell
//{
//    NSString *keyString = [NSString stringWithFormat:@"%i%i", cell.x, cell.y];
//    CCSprite *sprite = [self.heartSprites objectForKey:keyString];
//    
//    if (sprite != nil) {
//        [sprite removeFromParentAndCleanup:YES];
//        [self.heartSprites removeObjectForKey:keyString];
//    }
//}


# pragma mark - targeted touch delegate

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
//    CGPoint touchPosition = [self convertTouchToNodeSpace:touch];
//
//    for (Arrow *arrow in self.arrows) {
//        if (CGRectContainsPoint(arrow.boundingBox, touchPosition)) {
//            self.draggingArrow = arrow;
//        }
//    }
    return YES;
}
//
//- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
//{
//    CGPoint touchPosition = [self convertTouchToNodeSpace:touch];
//
//    if (self.draggingArrow != nil) {
//        self.draggingArrow.position = touchPosition;
//    }
//}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPosition = [self convertTouchToNodeSpace:touch];

    for (Arrow *arrow in self.arrows) {
        if (CGRectContainsPoint(arrow.boundingBox, touchPosition)) {
            [arrow rotateClockwise];
        }
    }
    
}

//- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
//{
//
//    CGPoint touchPosition = [self convertTouchToNodeSpace:touch];
//
//    // touch final pattern button to play final pattern
//    if (CGRectContainsPoint(self.finalPatternButton.boundingBox, touchPosition)) {
//        if (self.isAnySequencePlaying == NO) {
//            self.isAnySequencePlaying = YES;
//            [self scheduleFinalPattern];
//            [SpriteUtils switchImageForSprite:self.finalPatternButton textureKey:kImageFinalButtonSelected];
//            return YES;
//        }
//    }
//    
//    // touch dynamic pattern button to play dynamic pattern
//    if (CGRectContainsPoint(self.dynamicPatternButton.boundingBox, touchPosition)) {
//        if (self.isAnySequencePlaying == NO) {
//            self.isAnySequencePlaying = YES;
//            [self scheduleDynamicPattern];
//            [SpriteUtils switchImageForSprite:self.dynamicPatternButton textureKey:kImageDynamicButtonSelected];            
//            return YES;
//        }
//    }
//    
//    // touch previous button takes us to previous sequence, if there is one
//    if (CGRectContainsPoint(self.previousButton.boundingBox, touchPosition)) {
//        [self previousScene];
//        return YES;
//    }
//    
//    // touch next button takes us to next sequence, if there is one
//    if (CGRectContainsPoint(self.nextButton.boundingBox, touchPosition)) {
//        [self nextScene];
//        return YES;
//    }
//
//    // add heart beat to sequencer if touch on grid
//    GridCoord cell = [GridUtils gridCoordForAbsolutePosition:touchPosition unitSize:kSizeGridUnit origin:self.gridOrigin];
//    if ([self isValidCell:cell]) {
//        
//        // always remove whatever graphic is at the current dynamicPattern index -- we only support one beat per tick
//        [self removeAllBeatSpritesFromTick:cell.x];
//        
//        if (cell.y == kBeatTypeStandard) {
//            [self handleCellSelection:cell key:kKeyStandard];
//        }
//        else if (cell.y == kBeatTypeRobot) {
//            [self handleCellSelection:cell key:kKeyRobot];
//        }
//        else if (cell.y == kBeatTypeMeaty) {
//            [self handleCellSelection:cell key:kKeyMeaty];
//        }
//        else if (cell.y == kBeatTypeAlien) {
//            [self handleCellSelection:cell key:kKeyAlien];
//        }
//        return YES;
//    }
//    
//    return YES;
//}





@end
