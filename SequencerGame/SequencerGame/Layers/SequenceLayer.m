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
        
        self.tileMap = [CCTMXTiledMap tiledMapWithTMXFile:@"seq1.tmx"];
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
        
        
        
        
        
        
        // testing tick dispatcher
        
        [self.tickDispatcher start];
        
        
        
        /////////////////
        
    
//        _sequence = sequence;
//        _isAnySequencePlaying = NO;
//        
//        // setup grid
//        _gridSize = [DataUtils sequenceGridSize:sequence];
//        _gridOrigin = [SequenceLayer sharedGridOrigin];
//        
//
//        
//        
//        
//        
//        // patterns
//        _patternCount = 0;
//        _finalPattern = [DataUtils sequencePattern:sequence];
//        _dynamicPattern = [NSMutableArray array];
//        [_dynamicPattern addObjectsFromArray:[NSArray arrayWithObjects:
//                                              kKeyNoSound,
//                                              kKeyNoSound,
//                                              kKeyNoSound,
//                                              kKeyNoSound,
//                                              kKeyNoSound,
//                                              kKeyNoSound,
//                                              kKeyNoSound,
//                                              kKeyNoSound, nil]];
//        
//        // buttons
//        
//        CGFloat buttonSide = [[CCSprite spriteWithFile:@"previousButton.png"] boundingBox].size.height;
//        CGFloat buttonsY = self.gridOrigin.y + (self.gridSize.y * kSizeGridUnit) + buttonSide/2;
//        CGFloat gridWidth = self.gridSize.x * kSizeGridUnit;
//    
//        _previousButton = [CCSprite spriteWithFile:@"previousButton.png"];
//        _previousButton.position = CGPointMake(self.gridOrigin.x + gridWidth/4 - kSizeGridUnit, buttonsY);
//        [self addChild:_previousButton];
//                
//        _dynamicPatternButton = [CCSprite spriteWithFile:kImageDynamicButtonDefault];
//        _dynamicPatternButton.position = CGPointMake(self.gridOrigin.x + gridWidth/2 - kSizeGridUnit, buttonsY);
//        [self addChild:_dynamicPatternButton];
//        
//        _finalPatternButton = [CCSprite spriteWithFile:kImageFinalButtonDefault];
//        _finalPatternButton.position = CGPointMake(self.gridOrigin.x + 3*gridWidth/4 - kSizeGridUnit, buttonsY);
//        [self addChild:_finalPatternButton];
//
//        _nextButton = [CCSprite spriteWithFile:@"nextButton.png"];
//        _nextButton.position = CGPointMake(self.gridOrigin.x + gridWidth - kSizeGridUnit, buttonsY);
//        [self addChild:_nextButton];
//
//        // heart sprites appear in selected sequencer cells
//        _heartSprites = [NSMutableDictionary dictionary];
//        
//        // tick indicator shows what tick we are on
//        _tickIndicator = [CCSprite spriteWithFile:@"arrow.png"];
//        _tickIndicator.visible = NO;
//        [self addChild:_tickIndicator];
        
        
        
    }
    return self;
}

#pragma mark - pure data hooks

- (void)playNote:(int)n
{
    [PdBase sendFloat:n toReceiver:@"midinote"];
    [PdBase sendBangToReceiver:@"trigger"];
}

- (void)playE
{
    NSLog(@"playing E");
    [self playNote:40];
}

- (void)playA
{
    NSLog(@"playing A");
    [self playNote:45];
}

- (void)playD
{
    NSLog(@"playing D");
    [self playNote:50];
}

- (IBAction)playG
{
    NSLog(@"playing G");
    [self playNote:55];
}

- (void)playB
{
    NSLog(@"playing B");
    [self playNote:59];
}

- (void)playE2
{
    NSLog(@"playing E2");
    [self playNote:64];
}

#pragma mark - shared data

+ (CGPoint)sharedGridOrigin
{
    return CGPointMake((1024 - 800)/2, 130);
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

- (void)nextScene
{
    if (self.sequence  < [DataUtils numberOfSequences] - 1) {
        CCScene *scene = [SequenceLayer sceneWithSequence:self.sequence + 1];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionMoveInL transitionWithDuration:0.5 scene:scene]];
    }
    else {
        NSLog(@"no next scene");
    }
}

- (void)previousScene
{
    if (self.sequence > 0) {
        CCScene *scene = [SequenceLayer sceneWithSequence:self.sequence - 1];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionMoveInR transitionWithDuration:0.5 scene:scene]];
    }
    else {
        NSLog(@"no prev scene");
    }
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
    float delay = kPatternDelay; // Number of seconds between each call of myTimedMethod:
    [self schedule:@selector(playFinalPatternItem:) interval:delay repeat:kTotalPatternTicks - 1 delay:0];
}

- (void)scheduleDynamicPattern
{
    float delay = kPatternDelay; // Number of seconds between each call of myTimedMethod:
    [self schedule:@selector(playDynamicPatternItem:) interval:delay repeat:kTotalPatternTicks - 1 delay:0];  
}

- (void)playFinalPatternItem:(ccTime)dt
{
    [self playPatternItem:self.finalPattern];
}

- (void)playDynamicPatternItem:(ccTime)dt
{
    [self playPatternItem:self.dynamicPattern];
}

- (void)playPatternItem:(NSArray *)pattern
{
    NSString *key = [pattern objectAtIndex:self.patternCount];
    
    if ([key isEqualToString:@"no sound"] == NO) {
//        [[SimpleAudioEngine sharedEngine] playEffect:[self soundNameForKey:key]];
        [self playSoundForKey:key];
    }
    if ([pattern isEqualToArray:self.dynamicPattern]) {
        [self positionTickIndicatorForCurrentTick];
    }
    
    self.patternCount += 1;
    if (self.patternCount == kTotalPatternTicks) {
        self.isAnySequencePlaying = NO;
        
        if ([pattern isEqualToArray:self.dynamicPattern]) {
            self.tickIndicator.visible = NO;
                        
            if ([self didWin]) {
                [SpriteUtils switchImageForSprite:self.dynamicPatternButton textureKey:kImageDynamicButtonComplete];
            }
            else {
                [SpriteUtils switchImageForSprite:self.dynamicPatternButton textureKey:kImageDynamicButtonDefault];
            }
        }
        else {
            [SpriteUtils switchImageForSprite:self.finalPatternButton textureKey:kImageFinalButtonDefault];
        }
        
        self.patternCount = 0;
    }
}

- (void)handleCellSelection:(GridCoord)cell key:(NSString *)key
{
    if ([[self.dynamicPattern objectAtIndex:cell.x - 1] isEqualToString:key]) {
        [self.dynamicPattern replaceObjectAtIndex:cell.x - 1 withObject:kKeyNoSound];        
        [self removeBeatSpriteFromCell:cell];
    }
    else {
        [self.dynamicPattern replaceObjectAtIndex:cell.x - 1 withObject:key];
        [self addBeatSpriteToCell:cell];
    }
}

- (void)positionTickIndicatorForCurrentTick
{
    self.tickIndicator.position = [GridUtils absoluteSpritePositionForGridCoord:GridCoordMake(self.patternCount + 1, 0) unitSize:kSizeGridUnit origin:self.gridOrigin];
    self.tickIndicator.visible = YES;
}

#pragma mark - access heart sprites

- (void)addBeatSpriteToCell:(GridCoord)cell
{
    NSString *keyString = [NSString stringWithFormat:@"%i%i", cell.x, cell.y];
    CCSprite *sprite = [self heartSpriteForBeatType:(kBeatType)cell.y];
    sprite.position = [GridUtils absoluteSpritePositionForGridCoord:cell unitSize:kSizeGridUnit origin:self.gridOrigin];
    [self.heartSprites setObject:sprite forKey:keyString];
    [self addChild:sprite];
}

- (void)removeBeatSpriteFromCell:(GridCoord)cell
{
    NSString *keyString = [NSString stringWithFormat:@"%i%i", cell.x, cell.y];
    CCSprite *sprite = [self.heartSprites objectForKey:keyString];
    
    if (sprite != nil) {
        [sprite removeFromParentAndCleanup:YES];
        [self.heartSprites removeObjectForKey:keyString];
    }
}

- (void)removeAllBeatSpritesFromTick:(int)tick
{
    for (int y = 1; y < 5; y++) {
        [self removeBeatSpriteFromCell:GridCoordMake(tick, y)];
    }
}


- (CCSprite *)heartSpriteForBeatType:(kBeatType)beatType
{
    if (beatType == kBeatTypeStandard) {
        return [CCSprite spriteWithFile:@"standardHeart.png"];
    }
    else if (beatType == kBeatTypeRobot) {
        return [CCSprite spriteWithFile:@"robotHeart.png"];
    }
    else if (beatType == kBeatTypeMeaty) {
        return [CCSprite spriteWithFile:@"meatyHeart.png"];
    }
    else if (beatType == kBeatTypeAlien) {
        return [CCSprite spriteWithFile:@"alienHeart.png"];
    }
    else {
        return nil;
    }
}

# pragma mark - targeted touch delegate

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    
    CGPoint touchPosition = [self convertTouchToNodeSpace:touch];

    // touch final pattern button to play final pattern
    if (CGRectContainsPoint(self.finalPatternButton.boundingBox, touchPosition)) {
        if (self.isAnySequencePlaying == NO) {
            self.isAnySequencePlaying = YES;
            [self scheduleFinalPattern];
            [SpriteUtils switchImageForSprite:self.finalPatternButton textureKey:kImageFinalButtonSelected];
            return YES;
        }
    }
    
    // touch dynamic pattern button to play dynamic pattern
    if (CGRectContainsPoint(self.dynamicPatternButton.boundingBox, touchPosition)) {
        if (self.isAnySequencePlaying == NO) {
            self.isAnySequencePlaying = YES;
            [self scheduleDynamicPattern];
            [SpriteUtils switchImageForSprite:self.dynamicPatternButton textureKey:kImageDynamicButtonSelected];            
            return YES;
        }
    }
    
    // touch previous button takes us to previous sequence, if there is one
    if (CGRectContainsPoint(self.previousButton.boundingBox, touchPosition)) {
        [self previousScene];
        return YES;
    }
    
    // touch next button takes us to next sequence, if there is one
    if (CGRectContainsPoint(self.nextButton.boundingBox, touchPosition)) {
        [self nextScene];
        return YES;
    }

    // add heart beat to sequencer if touch on grid
    GridCoord cell = [GridUtils gridCoordForAbsolutePosition:touchPosition unitSize:kSizeGridUnit origin:self.gridOrigin];
    if ([self isValidCell:cell]) {
        
        // always remove whatever graphic is at the current dynamicPattern index -- we only support one beat per tick
        [self removeAllBeatSpritesFromTick:cell.x];
        
        if (cell.y == kBeatTypeStandard) {
            [self handleCellSelection:cell key:kKeyStandard];
        }
        else if (cell.y == kBeatTypeRobot) {
            [self handleCellSelection:cell key:kKeyRobot];
        }
        else if (cell.y == kBeatTypeMeaty) {
            [self handleCellSelection:cell key:kKeyMeaty];
        }
        else if (cell.y == kBeatTypeAlien) {
            [self handleCellSelection:cell key:kKeyAlien];
        }
        return YES;
    }
    
    return YES;
}

#pragma mark - sound access

- (void)playSoundForKey:(NSString *)key
{
    if ([key isEqualToString:kKeyStandard]) {
        [self playG];
    }
    else if ([key isEqualToString:kKeyRobot]) {
        [self playD];
    }
    else if ([key isEqualToString:kKeyMeaty]) {
        [self playB];
    }
    else if ([key isEqualToString:kKeyAlien]) {
        [self playE2];
    }
    else {
        NSLog(@"warning: sound with key '%@' not found", key);
    }
}

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
    else if ([key isEqualToString:kKeyAlien]) {
        return kSoundAlien;
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

- (BOOL)didWin
{
    int i = 0;
    for (NSString *key in self.finalPattern) {
        NSLog(@"key: %@", key);
        NSLog(@"in dynamic pattern: %@", [self.dynamicPattern objectAtIndex:i]);
        if ([key isEqualToString:[self.dynamicPattern objectAtIndex:i]] == NO) {
            return NO;
        }
        i++;
    }
    return YES;
}

@end
