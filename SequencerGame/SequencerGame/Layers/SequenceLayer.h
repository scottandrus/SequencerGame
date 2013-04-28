//
//  SequenceLayer.h
//  DumDumDum
//
//  Created by John Saba on 1/26/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GridUtils.h"
#import "PdDispatcher.h"

@interface SequenceLayer : CCLayer
{
    PdDispatcher *_dispatcher;
    void *_patch;
}

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

- (IBAction)playE:(id)sender;
- (IBAction)playA:(id)sender;
- (IBAction)playD:(id)sender;
- (IBAction)playG:(id)sender;
- (IBAction)playB:(id)sender;
- (IBAction)playE2:(id)sender;

@end