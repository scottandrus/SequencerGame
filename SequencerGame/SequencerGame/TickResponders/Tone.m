//
//  Tone.m
//  SequencerGame
//
//  Created by John Saba on 5/4/13.
//
//

#import "Tone.h"
#import "CCTMXTiledMap+Utils.h"
#import "SGTiledUtils.h"
#import "TextureUtils.h"
#import "SpriteUtils.h"

@implementation Tone

- (id)initWithTone:(NSMutableDictionary *)tone tiledMap:(CCTMXTiledMap *)tiledMap puzzleOrigin:(CGPoint)origin
{
    self = [super init];
    if (self) {
        self.cell = [tiledMap gridCoordForObject:tone];
        self.midiValue = [[CCTMXTiledMap objectPropertyNamed:kTLDPropertyMidiValue object:tone] intValue];
        NSString *imageName = [self imageNameForMidiValue:self.midiValue on:NO];
        self.sprite = [self createAndCenterSpriteNamed:imageName];
        [self addChild:self.sprite];
        self.position = [GridUtils absolutePositionForGridCoord:self.cell unitSize:kSizeGridUnit origin:origin];
    }
    return self;
}

#pragma mark - Tick Responder

- (NSString *)tick:(NSInteger)bpm
{
    [SpriteUtils switchImageForSprite:self.sprite textureKey:[self imageNameForMidiValue:self.midiValue on:YES]];
    return [NSString stringWithFormat:@"%i", self.midiValue];
}

- (void)afterTick:(NSInteger)bpm
{
    [SpriteUtils switchImageForSprite:self.sprite textureKey:[self imageNameForMidiValue:self.midiValue on:NO]];
}

- (GridCoord)responderCell
{
    return self.cell;
}

- (NSString *)imageNameForMidiValue:(int)midi on:(BOOL)on
{
    switch (midi) {
        case 48:
            if (on) {
                return kImageC_on;
            }
            return kImageC;
        case 49:
            if (on) {
                return kImageC_sharp_on;
            }
            return kImageC_sharp;
        case 50:
            if (on) {
                return kImageD_on;
            }
            return kImageD;
        case 51:
            if (on) {
                return kImageE_flat_on;
            }
            return kImageE_flat;
        case 52:
            if (on) {
                return kImageE_on;
            }
            return kImageE;
        case 53:
            if (on) {
                return kImageF_on;
            }
            return kImageF;
        case 54:
            if (on) {
                return kImageF_sharp_on;
            }
            return kImageF_sharp;
        case 55:
            if (on) {
                return kImageG_on;
            }
            return kImageG;
        case 56:
            if (on) {
                return kImageA_flat_on;
            }
            return kImageA_flat;
        case 57:
            if (on) {
                return kImageA_on;
            }
            return kImageA;
        case 58:
            if (on) {
                return kImageB_flat_on;
            }
            return kImageB_flat;
        case 59:
            if (on) {
                return kImageB_on;
            }
            return kImageB;;
            
        default:
            NSLog(@"tone image not found for value: %i, returning empty string", midi);
            return @"";
    }
}

@end
