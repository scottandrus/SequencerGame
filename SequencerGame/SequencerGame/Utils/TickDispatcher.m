//
//  TickDispatcher.m
//  SequencerGame
//
//  Created by John Saba on 4/30/13.
//
//

#import "TickDispatcher.h"
#import "GameConstants.h"
#import "Tone.h"
#import "Arrow.h"
#import "SGTiledUtils.h"

static NSInteger const kBPM = 120;



@interface TickDispatcher ()

@property (strong, nonatomic) NSMutableArray *responders;
@property (assign) GridCoord startingCell;
@property (assign) GridCoord currentCell;
@property (assign) GridCoord nextCell;
@property (assign) kDirection startingDirection;

@end


@implementation TickDispatcher

- (id)initWithEventSequence:(NSDictionary *)sequence
{
    self = [super init];
    if (self) {
        NSString *rawEventSeq = [sequence objectForKey:kTLDPropertyEvents];
        NSArray *groupByTick = [rawEventSeq componentsSeparatedByString:@";"];
        self.sequenceLength = groupByTick.count;
        
        int i = 0;
        self.eventSequence = [NSMutableDictionary dictionary];
        for (NSString *event in groupByTick) {
            NSLog(@"event: %@", event);
            NSArray *eventChain = [event componentsSeparatedByString:@","];
            [self.eventSequence setObject:eventChain forKey:@(i)];
            i++;
        }
        
        NSLog(@"event seq: %@", self.eventSequence);
    }
    return self;
}


- (void)registerTickResponder:(id<TickResponder>)responder
{
    NSAssert(![responder conformsToProtocol:@protocol(TickResponder)], @"registered tick responders much conform to TickResponder protocol");
    [self.responders addObject:responder];
}

- (void)tick
{
    // tick and collect responders 
    NSMutableArray *filtered = [NSMutableArray array];

    for (id<TickResponder> responder in self.responders) {
        GridCoord cell = [responder responderCell];
        if ([GridUtils isCell:cell equalToCell:self.currentCell]) {
            
            // tones
            if ([responder isKindOfClass:[Tone class]]) {
                BOOL duplicate = NO;
                for (Tone *stored in filtered) {
                    if (stored.midiValue == ((Tone *)responder).midiValue) {
                        duplicate = YES;
                        break;
                    }
                }
                if (!duplicate) {
                    [filtered addObject:responder];
                    [responder tick:kBPM];
                }
            } 
            
            // arrows
            
            
            
            
            
        
            
//            id event = [responder tick:kBPM];
//                        
//            if ([event isKindOfClass:[Tone class]]) {
//                NSUInteger duplicateTone;
//                duplicateTone = [filteredEvents indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
//                    if ([obj isKindOfClass:[Tone class]]) {
//                        return ((Tone *)obj).midiValue == ((Tone *)event).midiValue;
//                    }
//                    return NO;
//                }];
//                if (duplicateTone != NSNotFound) {
//                    [filteredEvents addObject:event];
//                }
//            }
//            if ([event isKindOfClass:[Direction class]]) {
//                NSUInteger duplicateDirection;
//                duplicateDirection = [filteredEvents indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
//                    if ([obj isKindOfClass:[Direction class]]) {
//                        return ((Direction *)obj).direction == ((Direction *)event).direction;
//                    }
//                    return NO;
//                }];
//                if (duplicateDirection != NSNotFound) {
//                    [filteredEvents addObject:event];
//                }
//            }
//            if ([event isKindOfClass:[Dissolve class]]) {
//                BOOL duplicateDissolve = NO;
//                for (id events in filteredEvents) {
//                    if ([event isKindOfClass:[Dissolve class]]) {
//                        duplicateDissolve = YES;
//                        break;
//                    }
//                }
//                if (!duplicateDissolve) {
//                    [filteredEvents addObject:event];
//                }
//            }
        }
    }
    
    // handle events
}

@end
