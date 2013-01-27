//
//  SpriteUtils.m
//  FishSet
//
//  Created by John Saba on 1/20/13.
//
//

#import "SpriteUtils.h"

@implementation SpriteUtils

+ (float)degreesForDirection:(kDirection)direction
{
    if (direction == kDirectionUp) {
        return 0.0f;
    }
    else if (direction == kDirectionRight) {
        return 90.0f;
    }
    else if (direction == kDirectionDown) {
        return 180.0f;
    }
    else if (direction == kDirectionLeft) {
        return  270.0f;
    }
    NSLog(@"warning: %i is an invalid direciton, returning 0.0f", direction);
    return 0.0f;
}

+ (void)switchImageForSprite:(CCSprite *)sprite textureKey:(NSString *)key
{
    [sprite setTexture:[[CCTextureCache sharedTextureCache] textureForKey:key]];
}

+ (CCSprite *)spriteWithSize:(CGSize)size color3B:(ccColor3B)color3B
{
    CCSprite *spr = [CCSprite spriteWithFile:@"blank.png"];
    [spr setTextureRect:CGRectMake(0, 0, size.width, size.height)];
    spr.color = color3B;
    return spr;
}

@end
