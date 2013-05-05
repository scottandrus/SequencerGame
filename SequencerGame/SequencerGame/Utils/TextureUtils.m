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

NSString *const kImageA_on = @"A-on.png";
NSString *const kImageA = @"A.png";
NSString *const kImageA_flat_on = @"Aflat-on.png";
NSString *const kImageA_flat = @"Aflat.png";
NSString *const kImageArrowDown = @"arrow-down.png";
NSString *const kImageArrowLeft = @"arrow-left.png";
NSString *const kImageArrowRight = @"arrow-right.png";
NSString *const kIMageArrowUp = @"arrow-up.png";
NSString *const kImageB_on = @"B-on.png";
NSString *const kImageB = @"B.png";
NSString *const kImageB_flat_on = @"Bflat-on.png";
NSString *const kImageB_flat = @"Bflat.png";
NSString *const kImageBlank_on = @"blank-on.png";
NSString *const kImageBlank = @"blank.png";
NSString *const kImageC_on = @"C-on.png";
NSString *const kImageC = @"C.png";
NSString *const kImageC_sharp_on = @"Csharp-on.png";
NSString *const kImageC_sharp = @"Csharp.png";
NSString *const kImageD_on = @"D-on.png";
NSString *const kImageD = @"D.png";
NSString *const kImageE_on = @"E-on.png";
NSString *const kImageE = @"E.png";
NSString *const kImageE_flat_on = @"Eflat-on.png";
NSString *const kImageE_flat = @"Eflat.png";
NSString *const kImageF_on = @"F-on.png";
NSString *const kImageF = @"F.png";
NSString *const kImageF_sharp_on = @"Fsharp-on.png";
NSString *const kImageF_sharp = @"Fsharp.png";
NSString *const kImageG_on = @"G-on.png";
NSString *const kImageG = @"G.png";


// don't forget to load the images
+ (void)loadTextures
{    
    [[CCTextureCache sharedTextureCache] addImage:kImageDynamicButtonDefault];
    [[CCTextureCache sharedTextureCache] addImage:kImageDynamicButtonSelected];
    [[CCTextureCache sharedTextureCache] addImage:kImageDynamicButtonComplete];
    [[CCTextureCache sharedTextureCache] addImage:kImageFinalButtonDefault];
    [[CCTextureCache sharedTextureCache] addImage:kImageFinalButtonSelected];
    
    [[CCTextureCache sharedTextureCache] addImage:kImageA_on];
    [[CCTextureCache sharedTextureCache] addImage:kImageA];
    [[CCTextureCache sharedTextureCache] addImage:kImageA_flat_on];
    [[CCTextureCache sharedTextureCache] addImage:kImageA_flat];
    [[CCTextureCache sharedTextureCache] addImage:kImageArrowDown];
    [[CCTextureCache sharedTextureCache] addImage:kImageArrowLeft];
    [[CCTextureCache sharedTextureCache] addImage:kImageArrowRight];
    [[CCTextureCache sharedTextureCache] addImage:kIMageArrowUp];
    [[CCTextureCache sharedTextureCache] addImage:kImageB_on];
    [[CCTextureCache sharedTextureCache] addImage:kImageB];
    [[CCTextureCache sharedTextureCache] addImage:kImageB_flat_on];
    [[CCTextureCache sharedTextureCache] addImage:kImageB_flat];
    [[CCTextureCache sharedTextureCache] addImage:kImageBlank_on];
    [[CCTextureCache sharedTextureCache] addImage:kImageBlank];
    [[CCTextureCache sharedTextureCache] addImage:kImageC_on];
    [[CCTextureCache sharedTextureCache] addImage:kImageC];
    [[CCTextureCache sharedTextureCache] addImage:kImageC_sharp_on];
    [[CCTextureCache sharedTextureCache] addImage:kImageC_sharp];
    [[CCTextureCache sharedTextureCache] addImage:kImageD_on];
    [[CCTextureCache sharedTextureCache] addImage:kImageD];
    [[CCTextureCache sharedTextureCache] addImage:kImageE_on];
    [[CCTextureCache sharedTextureCache] addImage:kImageE];
    [[CCTextureCache sharedTextureCache] addImage:kImageE_flat_on];
    [[CCTextureCache sharedTextureCache] addImage:kImageE_flat];
    [[CCTextureCache sharedTextureCache] addImage:kImageF_on];
    [[CCTextureCache sharedTextureCache] addImage:kImageF];
    [[CCTextureCache sharedTextureCache] addImage:kImageF_sharp_on];
    [[CCTextureCache sharedTextureCache] addImage:kImageF_sharp];
    [[CCTextureCache sharedTextureCache] addImage:kImageG_on];
    [[CCTextureCache sharedTextureCache] addImage:kImageG];
}




@end
