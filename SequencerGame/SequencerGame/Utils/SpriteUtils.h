//
//  SpriteUtils.h
//  FishSet
//
//  Created by John Saba on 1/20/13.
//
//

#import <Foundation/Foundation.h>
#import "GameTypes.h"
#import "cocos2d.h"

@interface SpriteUtils : NSObject

+ (float)degreesForDirection:(kDirection)direction;
+ (void)switchImageForSprite:(CCSprite *)sprite textureKey:(NSString *)key;
+ (CCSprite *)spriteWithSize:(CGSize)size color3B:(ccColor3B)color3B;

@end
