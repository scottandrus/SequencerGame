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
#import "CCTMXTiledMap+Utils.h"

static NSInteger const kBPM = 120;
static CGFloat const kTickInterval = 0.5;


@interface TickDispatcher ()

@property (strong, nonatomic) NSMutableArray *responders;
@property (assign) GridCoord startingCell;
@property (assign) GridCoord currentCell;
@property (assign) GridCoord nextCell;
@property (assign) kDirection startingDirection;
@property (assign) kDirection currentDirection;
@property (assign) int sequenceIndex;

@end


@implementation TickDispatcher

- (id)initWithEventSequence:(NSMutableDictionary *)sequence entry:(NSMutableDictionary *)entry tiledMap:(CCTMXTiledMap *)tiledMap
{
    self = [super init];
    if (self) {
        NSString *rawEventSeq = [sequence objectForKey:kTLDPropertyEvents];
        NSArray *groupByTick = [rawEventSeq componentsSeparatedByString:@";"];
        self.sequenceLength = groupByTick.count;
        
        int i = 0;
        self.eventSequence = [NSMutableDictionary dictionary];
        for (NSString *event in groupByTick) {
            NSArray *eventChain = [event componentsSeparatedByString:@","];
            [self.eventSequence setObject:eventChain forKey:@(i)];
            i++;
        }
        
        self.startingDirection = [SGTiledUtils directionNamed:[entry objectForKey:kTLDPropertyDirection]];
        self.startingCell = [tiledMap gridCoordForObject:entry];
        
        self.sequenceIndex = 0;
    
    }
    return self;
}


- (void)registerTickResponder:(id<TickResponder>)responder
{
    NSAssert(![responder conformsToProtocol:@protocol(TickResponder)], @"registered tick responders much conform to TickResponder protocol");
    [self.responders addObject:responder];
}

// public method to kick off the sequence
- (void)start
{
    [self schedule:@selector(tick) interval:kTickInterval repeat:kCCRepeatForever delay:0];
}

// public method to stop the sequence
- (void)stop
{
    [self unschedule:@selector(tick)];
}

// play the sound from the stored sequence an index
- (void)play:(int)index
{
    if ((index >= self.sequenceLength) || (index < 0)) {
        NSLog(@"warning: index out of TickDispatcher range");
        return;
    }
    
    // play sound in eventSequence
}

// schedule the stored sequence we want to solve for from the top
- (void)scheduleSequence
{
    self.sequenceIndex = 0;
    [self schedule:@selector(advanceSequence)];
    
}

// play an item from the stored sequence and progress
- (void)advanceSequence
{
    if (self.sequenceIndex >= self.sequenceLength) {
        NSLog(@"finished ticking");
        [self unschedule:@selector(tick)];
        return;
    }
    [self play:self.sequenceIndex];
    self.sequenceIndex++;
}

// moves the ticker along the grid
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
            
        }
    }
    
    NSLog(@"filtered: %@", filtered);
    
    // handle events
    
    
    
    
}

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
@end
