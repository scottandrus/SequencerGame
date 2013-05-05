//
//  MainSynth.m
//  SequencerGame
//
//  Created by John Saba on 5/5/13.
//
//

#import "MainSynth.h"
#import "PdDispatcher.h"
#import "SequenceLayer.h"
#import "TickDispatcher.h"

static NSString *const kActivateTone = @"activateTone";
static NSString *const kActivateNoise = @"activateNoise";
static NSString *const kClear = @"clear";
static NSString *const kTrigger = @"trigger";
static NSString *const kMidiValue = @"midinote";

@implementation MainSynth


- (void)loadEvents:(NSArray *)events
{
    if ((events == nil) || (events.count < 1)) {
        NSLog(@"warning: no events sent to synth");
        return;
    }    
    [PdBase sendBangToReceiver:kClear];
    
    for (NSString *event in events) {
        if ([self isValidMidiValue:event]) {
            [PdBase sendBangToReceiver:kActivateTone];
            [PdBase sendFloat:[event intValue] toReceiver:kMidiValue];
        }
        if ([TickDispatcher isArrowEvent:event]) {
            [PdBase sendBangToReceiver:kActivateNoise];
        }
    }
    
    [PdBase sendBangToReceiver:kTrigger];
}

- (BOOL)isValidMidiValue:(NSString *)midiString
{
    if ([midiString isEqualToString:@"48"] || [midiString isEqualToString:@"49"] || [midiString isEqualToString:@"50"] || [midiString isEqualToString:@"51"] || [midiString isEqualToString:@"52"] || [midiString isEqualToString:@"53"] || [midiString isEqualToString:@"54"] ||  [midiString isEqualToString:@"55"] || [midiString isEqualToString:@"56"] || [midiString isEqualToString:@"57"] || [midiString isEqualToString:@"58"] || [midiString isEqualToString:@"59"])
    {
        return YES;
    }
    return NO;
}

@end