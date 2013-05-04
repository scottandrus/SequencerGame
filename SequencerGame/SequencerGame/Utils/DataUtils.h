//
//  DataUtils.h
//  SequencerGame
//
//  Created by John Saba on 1/19/13.
//
//

#import <Foundation/Foundation.h>

#import "GridUtils.h"

@interface DataUtils : NSObject

+ (GridCoord)sequenceGridSize:(NSUInteger)sequence;
+ (NSArray *)sequencePattern:(NSUInteger)sequence;
+ (NSUInteger)numberOfSequences;

@end
