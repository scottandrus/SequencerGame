//
//  SequenceMenuViewController.h
//  SequencerGame
//
//  Created by John Saba on 4/27/13.
//
//

#import "CCViewController.h"

@protocol SequenceViewControllerDelegate <NSObject>

- (void)pressedBack;

@end


@interface SequenceViewController : CCViewController <CCStandardTouchDelegate>

@property (assign) NSInteger sequence;
@property (weak, nonatomic) id <SequenceViewControllerDelegate> delegate;

- (IBAction)pressedBack:(id)sender;

@end
