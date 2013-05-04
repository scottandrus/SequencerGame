//
//  SequenceLayer.h
//  SequencerGame
//
//  Created by John Saba on 1/26/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GridUtils.h"
#import "PdDispatcher.h"

@class CellObjectLibrary;

@interface SequenceLayer : CCLayer
{
    PdDispatcher *_dispatcher;
    void *_patch;
}


@property (nonatomic, strong) CCTMXTiledMap *tileMap;
@property (nonatomic, strong) CellObjectLibrary *cellObjectLibrary;

//@property (nonatomic, strong) 

@property (nonatomic, strong) NSMutableArray *tones;





//////////

@property (assign) int sequence;
@property (assign) GridCoord gridSize;
@property (assign) CGPoint gridOrigin;
@property (assign) BOOL isAnySequencePlaying;

// pattern
@property (nonatomic, strong) NSArray *finalPattern;
@property (nonatomic, strong) NSMutableArray *dynamicPattern;
@property (assign) NSUInteger patternCount;

// buttons
@property (nonatomic, strong) CCSprite *finalPatternButton;
@property (nonatomic, strong) CCSprite *dynamicPatternButton;
@property (nonatomic, strong) CCSprite *previousButton;
@property (nonatomic, strong) CCSprite *nextButton;

// heart sprites
@property (nonatomic, strong) NSMutableDictionary *heartSprites;

// tick indicator
@property (nonatomic, strong) CCSprite *tickIndicator;

@property (nonatomic, strong) CCSprite *screenImage;

+ (CCScene *)sceneWithSequence:(int)sequence;
+ (CGPoint)sharedGridOrigin;

- (IBAction)playE;
- (IBAction)playA;
- (IBAction)playD;
- (IBAction)playG;
- (IBAction)playB;
- (IBAction)playE2;

@end
