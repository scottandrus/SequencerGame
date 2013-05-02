//
//  TickDispatcher.m
//  SequencerGame
//
//  Created by John Saba on 4/30/13.
//
//

#import "TickDispatcher.h"

static NSInteger const kBPM = 120;

@interface TickDispatcher ()

@property (strong, nonatomic) NSMutableArray *responders;
@property (assign) GridCoord currentCell;
@property (assign) GridCoord nextCell;

@end


@implementation TickDispatcher

- (void)tick
{
    // events
    
    for (id<TickResponder> responder in self.responders) {
        GridCoord cell = [responder responderCell];
        if ([GridUtils isCell:cell equalToCell:self.currentCell]) {
            NSNumber *event = @([responder tick:kBPM]);
            // send 1 to PD patch 
        }
    }
    
}

@end
