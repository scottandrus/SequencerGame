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

- (NSString *)tick:(NSInteger)bpm;
- (void)afterTick:(NSInteger)bpm; // in the future this could also return a value that could trigger more events
- (GridCoord)responderCell;
@end

typedef enum
{
    kTickEventNote = 0,
    kTickEventArrow,
    kTickEventWarp
}kTickEvent;


@interface TickDispatcher : CCNode

@property (assign) int sequenceLength;
@property (nonatomic, strong) NSMutableDictionary *eventSequence;

- (id)initWithEventSequence:(NSMutableDictionary *)sequence entry:(NSMutableDictionary *)entry tiledMap:(CCTMXTiledMap *)tiledMap;
- (void)registerTickResponder:(id<TickResponder>)responder;

- (void)start;
- (void)stop;
- (void)play:(int)index;
- (void)scheduleSequence;

+ (BOOL)isArrowEvent:(NSString *)event;


@end
