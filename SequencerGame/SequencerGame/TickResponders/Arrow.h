//
//  Arrow.h
//  SequencerGame
//
//  Created by John Saba on 5/4/13.
//
//

#import "CellNode.h"
#import "GameConstants.h"
#import "TickDispatcher.h"

@interface Arrow : CellNode <TickResponder>

@property (assign) kDirection facing;

- (id)initWithArrow:(NSMutableDictionary *)arrow tiledMap:(CCTMXTiledMap *)tiledMap puzzleOrigin:(CGPoint)origin;
- (void)rotateClockwise;

@end
