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


@interface TickDispatcher : NSObject

@property (assign) int sequenceLength;
@property (nonatomic, strong) NSMutableDictionary *eventSequence;

- (id)initWithEventSequence:(NSDictionary *)sequence;
- (void)registerTickResponder:(id<TickResponder>)responder;

@end
