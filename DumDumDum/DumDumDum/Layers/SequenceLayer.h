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

@interface SequenceLayer : CCLayer

@property (assign) int sequence;
@property (assign) GridCoord gridSize;
@property (assign) CGPoint gridOrigin;

+ (CCScene *)sceneWithSequence:(int)sequence;
+ (CGPoint)sharedGridOrigin;

@end
