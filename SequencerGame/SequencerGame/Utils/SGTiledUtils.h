//
//  PGTiledUtils.h
//  PipeGame
//
//  Created by John Saba on 3/2/13.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameConstants.h"

// tiled object groups
FOUNDATION_EXPORT NSString *const kTLDGroupTickResponders;

// tiled objects
FOUNDATION_EXPORT NSString *const kTLDObjectSequence;
FOUNDATION_EXPORT NSString *const kTLDObjectEntry;
FOUNDATION_EXPORT NSString *const kTLDObjectTone;
FOUNDATION_EXPORT NSString *const kTLDObjectArrow;

// tiled object properties
FOUNDATION_EXPORT NSString *const kTLDPropertyLayer;
FOUNDATION_EXPORT NSString *const kTLDPropertyDirection;
FOUNDATION_EXPORT NSString *const kTLDPropertyEvents;

@interface SGTiledUtils : NSObject

+(kDirection) directionNamed:(NSString *)direction;

@end
