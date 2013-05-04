//
//  PGTiledUtiles.m
//  PipeGame
//
//  Created by John Saba on 3/2/13.
//
//

#import "PGTiledUtils.h"
#import "ColorUtils.h"

// tiled object groups
NSString *const kTLDGroupMeta = @"meta";

// tiled objects
NSString *const kTLDObjectEntry = @"entry";
NSString *const kTLDObjectConnection = @"connection";

// tiled object properties
NSString *const kTLDPropertyLayer = @"layer";

// tiled tile layers
NSString *const kTLDLayerPipes1 = @"pipes1";
NSString *const kTLDLayerPipes2 = @"pipes2";

@implementation PGTiledUtils

+(kDirection) directionNamed:(NSString *)direction
{
    if ([direction isEqualToString:@"up"] || [direction isEqualToString:@"top"]) {
        return kDirectionUp;
    }
    else if ([direction isEqualToString:@"down"] || [direction isEqualToString:@"bottom"]) {
        return kDirectionDown;
    }
    else if ([direction isEqualToString:@"left"]) {
        return kDirectionLeft;
    }
    else if ([direction isEqualToString:@"right"]) {
        return kDirectionRight;
    }
    else if ([direction isEqualToString:@"through"]) {
        return kDirectionThrough;
    }
    else {
        return kDirectionNone;
    }
}


@end
