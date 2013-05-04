/*
 Copyright (c) 2010 Ole Begemann
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

/*
 OBGradientView.h
 
 Created by Ole Begemann
 April, 2010
 */


/*
 OBGradientView is a simple UIView wrapper for CAGradientLayer. It is a plain UIView whose layer
 is a CAGradientLayer. It is useful if using a view is more convenient than using a layer, e.g.
 because you want to use autoresizing masks.
 
 OBGradientView exposes all of the layer's gradient-related properties.
 The getters and setters just forward the calls to the layer so the syntax is just the same as
 for CAGradientLayer's properties itself. See the documentation for CAGradientLayer for details:
 http://developer.apple.com/iphone/library/documentation/GraphicsImaging/Reference/CAGradientLayer_class/Reference/Reference.html
 
 The one exception to this is the colors property: in addition to an array of CGColorRefs,
 it also accepts an array of UIColor objects. Likewise, the getter returns an array of UIColors.
 If you need CGColorRefs, access gradientLayer.colors instead.
 */


#import "SAViewManipulator.h"
#import <QuartzCore/QuartzCore.h>


@interface OBGradientView : UIView {
}

// Returns the view's layer. Useful if you want to access CAGradientLayer-specific properties
// because you can omit the typecast.
@property (weak, nonatomic, readonly) CAGradientLayer *gradientLayer;

// Gradient-related properties are forwarded to layer.
// colors also accepts array of UIColor objects (in addition to array of CGColorRefs).
@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) NSArray *locations;
@property (nonatomic) CGPoint startPoint;
@property (nonatomic) CGPoint endPoint;
@property (nonatomic, copy) NSString *type;

@end

#pragma mark -
#pragma mark Implementation

@implementation OBGradientView

@dynamic gradientLayer;
@dynamic colors, locations, startPoint, endPoint, type;


// Make the view's layer a CAGradientLayer instance
+ (Class)layerClass
{
    return [CAGradientLayer class];
}



// Convenience property access to the layer help omit typecasts
- (CAGradientLayer *)gradientLayer
{
    return (CAGradientLayer *)self.layer;
}



#pragma mark -
#pragma mark Gradient-related properties

- (NSArray *)colors
{
    NSArray *cgColors = self.gradientLayer.colors;
    if (cgColors == nil) {
        return nil;
    }
    
    // Convert CGColorRefs to UIColor objects
    NSMutableArray *uiColors = [NSMutableArray arrayWithCapacity:[cgColors count]];
    for (id cgColor in cgColors) {
        [uiColors addObject:[UIColor colorWithCGColor:(CGColorRef)cgColor]];
    }
    return [NSArray arrayWithArray:uiColors];
}


// The colors property accepts an array of CGColorRefs or UIColor objects (or mixes between the two).
// UIColors are converted to CGColor before forwarding the values to the layer.
- (void)setColors:(NSArray *)newColors
{
    NSMutableArray *newCGColors = nil;
    
    if (newColors != nil) {
        newCGColors = [NSMutableArray arrayWithCapacity:[newColors count]];
        for (id color in newColors) {
            // If the array contains a UIColor, convert it to CGColor.
            // Leave all other types untouched.
            if ([color isKindOfClass:[UIColor class]]) {
                [newCGColors addObject:(id)[color CGColor]];
            } else {
                [newCGColors addObject:color];
            }
        }
    }
    
    self.gradientLayer.colors = newCGColors;
}


- (NSArray *)locations
{
    return self.gradientLayer.locations;
}

- (void)setLocations:(NSArray *)newLocations
{
    self.gradientLayer.locations = newLocations;
}

- (CGPoint)startPoint
{
    return self.gradientLayer.startPoint;
}

- (void)setStartPoint:(CGPoint)newStartPoint
{
    self.gradientLayer.startPoint = newStartPoint;
}

- (CGPoint)endPoint
{
    return self.gradientLayer.endPoint;
}

- (void)setEndPoint:(CGPoint)newEndPoint
{
    self.gradientLayer.endPoint = newEndPoint;
}

- (NSString *)type
{
    return self.gradientLayer.type;
}

- (void) setType:(NSString *)newType
{
    self.gradientLayer.type = newType;
}

@end

//
//  SAViewManipulator.m
//
//  Created by Scott Andrus on 8/9/12.
//  Copyright (c) 2012 Tapatory, LLC. All rights reserved.
//

@implementation SAViewManipulator

+ (UIView *)getPrimaryBackgroundGradientViewForView:(UIView *)view withTopColor:(UIColor *)gradientTop andBottomColor:(UIColor *)gradientBot {
    
    if (!gradientBot) {
        gradientBot = [UIColor colorWithRed:0.071 green:0.071 blue:0.071 alpha:1] /*#121212*/;
    }
    
    if (!gradientTop) {
        gradientTop = [UIColor colorWithRed:0.231 green:0.231 blue:0.231 alpha:1] /*#3b3b3b*/;
    }
    
	NSArray *gradientColors = [NSArray arrayWithObjects:gradientTop, gradientBot, nil];
	
	OBGradientView *gradientView = [[OBGradientView alloc] init];
	[gradientView setFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
	[gradientView setAutoresizingMask:view.autoresizingMask];
	[gradientView setColors:gradientColors];
	
	return gradientView;
}

+ (UIImage *)screenShotOfView:(UIView *)view {
    // Screenshot of the frame
    view.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    UIGraphicsBeginImageContextWithOptions(view.layer.frame.size, view.opaque, 0.0);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    return viewImage;
}

+ (UIImage *)gradientBackgroundImageForView:(UIView *)view withTopColor:(UIColor *)gradientTop andBottomColor:(UIColor *)gradientBot {
    return [SAViewManipulator screenShotOfView:[SAViewManipulator getPrimaryBackgroundGradientViewForView:view withTopColor:gradientTop andBottomColor:gradientBot]];
}

+ (CALayer *)getPrimaryBackgroundGradientViewForLayer:(CALayer *)layer withTopColor:(UIColor *)gradientTop andBottomColor:(UIColor *)gradientBot {
    
    if (!gradientBot) {
        gradientBot = [UIColor colorWithRed:0.071 green:0.071 blue:0.071 alpha:1] /*#121212*/;
    }
    
    if (!gradientTop) {
        gradientTop = [UIColor colorWithRed:0.231 green:0.231 blue:0.231 alpha:1] /*#3b3b3b*/;
    }
    
	NSArray *gradientColors = [NSArray arrayWithObjects:gradientTop, gradientBot, nil];
	
	OBGradientView *gradientView = [[OBGradientView alloc] init];
	[gradientView setFrame:CGRectMake(0, 0, layer.frame.size.width, layer.frame.size.height)];
    UIView *view = [[UIView alloc] initWithFrame:layer.frame];
    [view.layer addSublayer:layer];
	[gradientView setAutoresizingMask:view.autoresizingMask];
	[gradientView setColors:gradientColors];
	
	return gradientView.layer;
}

+ (UIImage *)screenShotOfLayer:(CALayer *)layer {
    // Screenshot of the frame
    UIGraphicsBeginImageContext(layer.frame.size);
    
    [layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    return viewImage;
}

+ (UIImage *)gradientBackgroundImageForLayer:(CALayer *)layer withTopColor:(UIColor *)gradientTop andBottomColor:(UIColor *)gradientBot {
    return [SAViewManipulator screenShotOfLayer:[SAViewManipulator getPrimaryBackgroundGradientViewForLayer:layer withTopColor:gradientTop andBottomColor:gradientBot]];
}

+ (void)setGradientBackgroundImageForView:(id)view withTopColor:(UIColor *)gradientTop andBottomColor:(UIColor *)gradientBot {
    if ([view respondsToSelector:@selector(setBackgroundImage:)]) {
        [view setBackgroundImage:[SAViewManipulator screenShotOfView:[SAViewManipulator getPrimaryBackgroundGradientViewForView:view withTopColor:gradientTop andBottomColor:gradientBot]]];
    } else if ([view respondsToSelector:@selector(setBackgroundImage:forToolbarPosition:barMetrics:)]) {
        [view setBackgroundImage:[SAViewManipulator screenShotOfView:[SAViewManipulator getPrimaryBackgroundGradientViewForView:view withTopColor:gradientTop andBottomColor:gradientBot]] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    } else if ([view respondsToSelector:@selector(setBackgroundImage:forState:barMetrics:)]) {
        [view setBackgroundImage:[SAViewManipulator screenShotOfView:[SAViewManipulator getPrimaryBackgroundGradientViewForView:view withTopColor:gradientTop andBottomColor:gradientBot]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    } else if ([view respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        [view setBackgroundImage:[SAViewManipulator screenShotOfView:[SAViewManipulator getPrimaryBackgroundGradientViewForView:view withTopColor:gradientTop andBottomColor:gradientBot]] forBarMetrics:UIBarMetricsDefault];
    } else if ([view respondsToSelector:@selector(setBackgroundImage:forState:)]) {
        [view setBackgroundImage:[SAViewManipulator screenShotOfView:[SAViewManipulator getPrimaryBackgroundGradientViewForView:view withTopColor:gradientTop andBottomColor:gradientBot]] forState:UIControlStateNormal];
    } else if ([view respondsToSelector:@selector(setImage:forState:)]) {
        [view setImage:[SAViewManipulator screenShotOfView:[SAViewManipulator getPrimaryBackgroundGradientViewForView:view withTopColor:gradientTop andBottomColor:gradientBot]] forState:UIControlStateNormal];
    } else {
        [view insertSubview:[[UIImageView alloc] initWithImage:[SAViewManipulator gradientBackgroundImageForView:view withTopColor:gradientTop andBottomColor:gradientBot]] atIndex:0];
    }
}

+ (void)addShadowToView:(UIView *)view withOpacity:(CGFloat)opacity radius:(CGFloat)radius andOffset:(CGSize)offset {
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    if (opacity) {
        if (opacity > 1) opacity = 1;
        else if (opacity < 0) opacity = 0;
        view.layer.shadowOpacity = opacity;
    }
    if (radius) view.layer.shadowRadius = 2.0;
    if (offset.height && offset.width) view.layer.shadowOffset = CGSizeMake(-1, 1);
}

+ (void)addBorderToView:(UIView *)view withWidth:(CGFloat)borderWidth color:(UIColor *)borderColor andRadius:(CGFloat)cornerRadius {
    if (borderWidth) view.layer.borderWidth = borderWidth;
    if (borderColor) view.layer.borderColor = [borderColor CGColor];
    if (cornerRadius) view.layer.cornerRadius = cornerRadius;
}

+ (void)roundNavigationBar:(UINavigationBar *)navigationBar {
    UIView *roundView = [navigationBar.subviews objectAtIndex:0];
    
    CALayer *capa = roundView.layer;

    //Round
    CGRect bounds = capa.bounds;
    bounds.size.height += 10.0f;    //I'm reserving enough room for the shadow
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds
                                                   byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                                         cornerRadii:CGSizeMake(5.0, 5.0)];

    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = bounds;
    maskLayer.path = maskPath.CGPath;

    [capa addSublayer:maskLayer];
    capa.mask = maskLayer;
}

@end
