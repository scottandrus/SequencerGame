//
//  DataUtils.m
//  SequencerGame
//
//  Created by John Saba on 1/19/13.
//
//

#import "DataUtils.h"

static NSString *const kSequencePlist = @"Sequence";
static NSString *const kSequenceGridSizeX = @"size.x";
static NSString *const kSequenceGridSizeY = @"size.y";
static NSString *const kSequencePattern = @"pattern";

@implementation DataUtils
{
    
}

#pragma mark - plist utils

+ (NSData *)plistXML:(NSString *)plist
{
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:[plist stringByAppendingString:@".plist"]];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        plistPath = [[NSBundle mainBundle] pathForResource:plist ofType:@"plist"];
    }
    return [[NSFileManager defaultManager] contentsAtPath:plistPath];
}

+ (NSDictionary *)plistDictionary:(NSString *)plist
{
    NSData *plistXML = [DataUtils plistXML:plist];
    
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSDictionary *plistDict = (NSDictionary *)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&errorDesc];
    
    if (plistDict == nil) {
        NSLog(@"warning: plist == nil, error: %@, format: %d", errorDesc, format);
    }    
    return plistDict;
}

+ (NSArray *)plistArray:(NSString *)plist
{
    NSData *plistXML = [DataUtils plistXML:plist];
    
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSArray *plistArray = (NSArray *)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&errorDesc];
    
    if (plistArray == nil) {
        NSLog(@"warning: plist == nil, error: %@, format: %d", errorDesc, format);
    }
    return plistArray;
}

#pragma mark - access sequence plist

// return sequence from plist, 0-based index
+ (NSDictionary *)sequenceData:(NSUInteger)sequence
{
    NSArray *plist = [DataUtils plistArray:kSequencePlist];
    NSDictionary * seq = [plist objectAtIndex:sequence];
    return seq;
}

// sequence grid size
+ (GridCoord)sequenceGridSize:(NSUInteger)sequence
{
    NSDictionary *seq = [DataUtils sequenceData:sequence];
    NSNumber *x = [seq valueForKeyPath:kSequenceGridSizeX];
    NSNumber *y = [seq valueForKeyPath:kSequenceGridSizeY];
    return GridCoordMake([x intValue], [y intValue]);
}

// the pattern you make to win
+ (NSArray *)sequencePattern:(NSUInteger)sequence
{
    NSDictionary *seq = [DataUtils sequenceData:sequence];
    return [seq valueForKeyPath:kSequencePattern];
}

+ (NSUInteger)numberOfSequences
{
    NSArray *plist = [DataUtils plistArray:kSequencePlist];
    return [plist count];
}

@end
