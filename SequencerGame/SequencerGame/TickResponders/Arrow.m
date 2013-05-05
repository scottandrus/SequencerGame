//
//  Arrow.m
//  SequencerGame
//
//  Created by John Saba on 5/4/13.
//
//

#import "Arrow.h"
#import "CCTMXTiledMap+Utils.h"
#import "SGTiledUtils.h"

@implementation Arrow

- (id)initWithArrow:(NSMutableDictionary *)arrow tiledMap:(CCTMXTiledMap *)tiledMap puzzleOrigin:(CGPoint)origin
{
    self = [super init];
    if (self) {
        self.cell = [tiledMap gridCoordForObject:arrow];
        NSString *facing = [CCTMXTiledMap objectPropertyNamed:kTLDPropertyDirection object:arrow];
        self.facing = [SGTiledUtils directionNamed:facing];
        
        
        //        self.colorGroup = [door valueForKey:kTLDPropertyColorGroup];
        //        self.edge = [PGTiledUtils directionNamed:[door valueForKey:kTLDPropertyEdge]];
        //
        //        NSString *imageName = [self imageNameForColorGroup:_colorGroup open:NO];
        //        self.sprite = [SpriteUtils spriteWithTextureKey:imageName];
        //        [self rotateAndPosition:self.sprite edge:self.edge];
        //        [self addChild:self.sprite];
        //
        //        self.layer = [[door valueForKey:kTLDPropertyLayer] intValue];
        //
        
        //        self.position = [GridUtils absolutePositionForGridCoord:self.cell unitSize:kSizeGridUnit origin:origin];
        //
        //        self.isOpen = NO;
        //        
        //        [self registerNotifications];
    }
    return self;

}

#pragma mark - Tick Responder

- (NSString *)tick:(NSInteger)bpm
{
    NSLog(@"arrow item handling tick");
    return [GridUtils directionStringForDirection:self.facing];
}

- (void)afterTick:(NSInteger)bpm
{
    
}

- (GridCoord)responderCell
{
    return self.cell;
}


@end
