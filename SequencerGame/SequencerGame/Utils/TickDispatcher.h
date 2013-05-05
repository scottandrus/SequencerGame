//
//  TickDispatcher.h
//  SequencerGame
//
//  Created by John Saba on 4/30/13.
//
//

#import <Foundation/Foundation.h>
#import "GridUtils.h"


@protocol TickResponder <NSObject>
- (void)tick:(NSInteger)bpm;
- (GridCoord)responderCell;
@end


@interface TickDispatcher : CCNode

@property (assign) int sequenceLength;
@property (nonatomic, strong) NSMutableDictionary *eventSequence;

- (id)initWithEventSequence:(NSMutableDictionary *)sequence entry:(NSMutableDictionary *)entry tiledMap:(CCTMXTiledMap *)tiledMap;
- (void)registerTickResponder:(id<TickResponder>)responder;

- (void)start;
- (void)stop;
- (void)play:(int)index;

@end
