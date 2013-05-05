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
#import "MainSynth.h"

static NSInteger const kBPM = 120;
static CGFloat const kTickInterval = 0.5;


@interface TickDispatcher ()

@property (strong, nonatomic) NSMutableArray *responders;
@property (strong, nonatomic) NSMutableArray *lastTickedResponders;
@property (assign) GridCoord startingCell;
@property (assign) GridCoord currentCell;
@property (assign) GridCoord nextCell;
@property (assign) kDirection startingDirection;
@property (assign) kDirection currentDirection;
@property (assign) int sequenceIndex;
@property (assign) GridCoord gridSize;
@property (strong, nonatomic) MainSynth *mainSynth;

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
        self.responders = [NSMutableArray array];
        self.gridSize = [GridUtils gridCoordFromSize:tiledMap.mapSize];
        self.lastTickedResponders = [NSMutableArray array];
        
        self.mainSynth = [[MainSynth alloc] init];
    }
    return self;
}


- (void)registerTickResponder:(id<TickResponder>)responder
{
    NSAssert([responder conformsToProtocol:@protocol(TickResponder)], @"registered tick responders much conform to TickResponder protocol");
    [self.responders addObject:responder];
}

// public method to kick off the sequence
- (void)start
{
    self.currentCell = self.startingCell;
    self.currentDirection = self.startingDirection;
    [self schedule:@selector(tick:) interval:kTickInterval];
}

// public method to stop the sequence
- (void)stop
{
    [self unschedule:@selector(tick:)];
}

// play the sound from the stored sequence an index
- (void)play:(int)index
{
    if ((index >= self.sequenceLength) || (index < 0)) {
        NSLog(@"warning: index out of TickDispatcher range");
        return;
    }
    
    // play sound in eventSequence
    NSLog(@"playing %@", [self.eventSequence objectForKey:@(index)]);
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
- (void)tick:(ccTime)dt
{
    NSLog(@"current cell: %i, %i", self.currentCell.x, self.currentCell.y);
    
    for (id<TickResponder> responder in self.lastTickedResponders) {
        [responder afterTick:kBPM];
    }

    // stop if we are off the grid
    if (![GridUtils isCellInBounds:self.currentCell gridSize:self.gridSize]) {
        [self stop];
        NSLog(@"out of bounds stopping tick");
        return;
    }
    
    // tick and collect events
    NSMutableArray *events = [NSMutableArray array];
    for (id<TickResponder>responder in self.responders) {
        if ([GridUtils isCell:[responder responderCell] equalToCell:self.currentCell]) {
            [events addObject:[responder tick:kBPM]];
            [self.lastTickedResponders addObject:responder];
        }
    }
    
    // handle events
    for (NSString *event in events) {
                
        // change direction for arrows
        if ([TickDispatcher isArrowEvent:event]) {
            self.currentDirection = [GridUtils directionForString:event];
        }
    }
    
    // send events to MainSynth which will talk to our PD patch
    [self.mainSynth loadEvents:events];
    
    // advance cell 
    self.currentCell = [GridUtils stepInDirection:self.currentDirection fromCell:self.currentCell];    
}
             
+ (BOOL)isArrowEvent:(NSString *)event
{
    if ([event isEqualToString:@"up"] || [event isEqualToString:@"down"] || [event isEqualToString:@"right"] || [event isEqualToString:@"left"]) {
        return YES;
    }
    return NO;
}


@end
