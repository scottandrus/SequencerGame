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

NSString *const kImageDynamicButtonDefault = @"dynamicButtonDefault.png";
NSString *const kImageDynamicButtonSelected = @"dynamicButtonSelected.png";
NSString *const kImageDynamicButtonComplete = @"dynamicButtonComplete.png";
NSString *const kImageFinalButtonDefault = @"finalButtonDefault.png";
NSString *const kImageFinalButtonSelected = @"finalButtonSelected.png";

// don't forget to load the images
+ (void)loadTextures
{    
    [[CCTextureCache sharedTextureCache] addImage:kImageDynamicButtonDefault];
    [[CCTextureCache sharedTextureCache] addImage:kImageDynamicButtonSelected];
    [[CCTextureCache sharedTextureCache] addImage:kImageDynamicButtonComplete];
    [[CCTextureCache sharedTextureCache] addImage:kImageFinalButtonDefault];
    [[CCTextureCache sharedTextureCache] addImage:kImageFinalButtonSelected];
}

@end
