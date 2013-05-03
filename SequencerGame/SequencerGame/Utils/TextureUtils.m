//
//  TextureUtils.m
//  Sequencer Game
//
//  Created by John Saba on 2/2/13.
//
//

#import "TextureUtils.h"
#import "cocos2d.h"

@implementation TextureUtils

NSString *const kImageNameImage = @"image";

// don't forget to load the images
+ (void)loadTextures
{
    [[CCTextureCache sharedTextureCache] addImage:kImageNameImage];
}

@end
