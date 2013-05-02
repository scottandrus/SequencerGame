//
//  TickDispatcher.h
//  SequencerGame
//
//  Created by John Saba on 4/30/13.
//
//

#import <Foundation/Foundation.h>
#import "GridUtils.h"

typedef enum
{
    kTickEventUp = 0,
    kTickEventRight,
    kTickEventDown,
    kTickEventLeft,
    kTickEventDissolve,
} kTickEvent;

@protocol TickResponder <NSObject>
- (kTickEvent)tick:(NSInteger)bpm;
- (GridCoord)responderCell;
@end


@interface TickDispatcher : NSObject

@end
