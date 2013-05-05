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

@class CellObjectLibrary, TickDispatcher;

@interface SequenceLayer : CCLayer
{
    PdDispatcher *_dispatcher;
    void *_patch;
}


@property (nonatomic, strong) CCTMXTiledMap *tileMap;
@property (nonatomic, strong) CellObjectLibrary *cellObjectLibrary;
@property (nonatomic, strong) TickDispatcher *tickDispatcher;

@property (nonatomic, strong) NSMutableArray *tones;
@property (nonatomic, strong) NSMutableArray *arrows;

@property (assign) GridCoord gridSize;


//////////
@property (assign) CGPoint gridOrigin;
//////////

+ (CCScene *)sceneWithSequence:(int)sequence;
+ (CGPoint)sharedGridOrigin;

- (void)playUserSequence;
- (void)playSolutionSequence;

@end
