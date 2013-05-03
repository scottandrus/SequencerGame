//
//  SpriteUtils.h
//  SequencerGame
//
//  Created by John Saba on 1/20/13.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameConstants.h"

@interface SpriteUtils : NSObject

// degrees we need to rotate an upward facing sprite to a face provided direction
+ (float)degreesForDirection:(kDirection)direction;

// switch out a sprite's current image 
+ (void)switchImageForSprite:(CCSprite *)sprite textureKey:(NSString *)key;

+ (CCSprite *)rectSprite:(CGSize)size color3B:(ccColor3B)color3B;

// texture key should be name of image file (see values in TextureUtils)
// won't work unless images have been added to texture utils
+ (CCSprite *)spriteWithTextureKey:(NSString *)key;

@end
