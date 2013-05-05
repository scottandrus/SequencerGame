//
//  TextureUtils.h
//  SequencerGame
//
//  Created by John Saba on 2/2/13.
//
//

#import <Foundation/Foundation.h>

@interface TextureUtils : NSObject

// define image names
FOUNDATION_EXPORT NSString *const kImageDynamicButtonDefault;
FOUNDATION_EXPORT NSString *const kImageDynamicButtonSelected;
FOUNDATION_EXPORT NSString *const kImageDynamicButtonComplete;
FOUNDATION_EXPORT NSString *const kImageFinalButtonDefault;
FOUNDATION_EXPORT NSString *const kImageFinalButtonSelected;

FOUNDATION_EXPORT NSString *const kImageA_on;
FOUNDATION_EXPORT NSString *const kImageA;
FOUNDATION_EXPORT NSString *const kImageA_flat_on;
FOUNDATION_EXPORT NSString *const kImageA_flat;
FOUNDATION_EXPORT NSString *const kImageArrowDown;
FOUNDATION_EXPORT NSString *const kImageArrowLeft;
FOUNDATION_EXPORT NSString *const kImageArrowRight;
FOUNDATION_EXPORT NSString *const kIMageArrowUp;
FOUNDATION_EXPORT NSString *const kImageB_on;
FOUNDATION_EXPORT NSString *const kImageB;
FOUNDATION_EXPORT NSString *const kImageB_flat_on;
FOUNDATION_EXPORT NSString *const kImageB_flat;
FOUNDATION_EXPORT NSString *const kImageBlank_on;
FOUNDATION_EXPORT NSString *const kImageBlank;
FOUNDATION_EXPORT NSString *const kImageC_on;
FOUNDATION_EXPORT NSString *const kImageC;
FOUNDATION_EXPORT NSString *const kImageC_sharp_on;
FOUNDATION_EXPORT NSString *const kImageC_sharp;
FOUNDATION_EXPORT NSString *const kImageD_on;
FOUNDATION_EXPORT NSString *const kImageD;
FOUNDATION_EXPORT NSString *const kImageE_on;
FOUNDATION_EXPORT NSString *const kImageE;
FOUNDATION_EXPORT NSString *const kImageE_flat_on;
FOUNDATION_EXPORT NSString *const kImageE_flat;
FOUNDATION_EXPORT NSString *const kImageF_on;
FOUNDATION_EXPORT NSString *const kImageF;
FOUNDATION_EXPORT NSString *const kImageF_sharp_on;
FOUNDATION_EXPORT NSString *const kImageF_sharp;
FOUNDATION_EXPORT NSString *const kImageG_on;
FOUNDATION_EXPORT NSString *const kImageG;

+ (void)loadTextures;

@end
