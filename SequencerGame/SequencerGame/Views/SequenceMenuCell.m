//
//  SequenceMenuCell.m
//  PipeGame
//
//  Created by John Saba on 4/27/13.
//
//

#import "SequenceMenuCell.h"

@implementation SequenceMenuCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)configureWithIndexPath:(NSIndexPath *)indexPath
{
    self.backgroundColor = [UIColor darkGrayColor];
    self.sequenceLabel.textColor = [UIColor lightGrayColor];
    self.sequenceLabel.text = [NSString stringWithFormat:@"%i", indexPath.row + 1];
    
    NSLog(@"self.display label: %@", self.sequenceLabel);
    NSLog(@"display label.text: %@", self.sequenceLabel.text);
}

@end
