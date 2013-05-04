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


+ (void)loadTextures;

@end
