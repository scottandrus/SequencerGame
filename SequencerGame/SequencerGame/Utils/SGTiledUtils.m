//
//  PGTiledUtiles.m
//  PipeGame
//
//  Created by John Saba on 3/2/13.
//
//

#import "SGTiledUtils.h"
#import "ColorUtils.h"

// tiled object groups
NSString *const kTLDGroupTickResponders = @"Tick Responders";

// tiled objects
NSString *const kTLDObjectSequence = @"sequence";
NSString *const kTLDObjectEntry = @"entry";
NSString *const kTLDObjectTone = @"tone";
NSString *const kTLDObjectArrow = @"arrow";

// tiled object properties
NSString *const kTLDPropertyLayer = @"midiValue";
NSString *const kTLDPropertyDirection = @"direction";
NSString *const kTLDPropertyEvents = @"events";


@implementation SGTiledUtils

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
