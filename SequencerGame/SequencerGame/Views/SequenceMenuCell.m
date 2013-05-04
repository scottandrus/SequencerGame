//
//  SequenceMenuCell.m
//  PipeGame
//
//  Created by John Saba on 4/27/13.
//
//

#import "SequenceMenuCell.h"
#import "SAViewManipulator.h"

@implementation SequenceMenuCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (void)configureWithIndexPath:(NSIndexPath *)indexPath
{
    
    self.backgroundColor = [UIColor lightGrayColor];
    [SAViewManipulator addBorderToView:self
                             withWidth:2
                                 color:[UIColor darkGrayColor]
                             andRadius:6];
    
    if (!self.sequenceLabel) {
        // Loading the sequence label object from a nib file to preserve graphical
        // layout, and add it to the subview
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SequenceMenuCellLabel" owner:self options:nil];
        self.sequenceLabel = [nib objectAtIndex:0];
        [self addSubview:self.sequenceLabel];
    }

    // Set the text of the label based on its index in the collection view
    self.sequenceLabel.text = [NSString stringWithFormat:@"%i", indexPath.row + 1];
    
    NSLog(@"self.display label: %@", self.sequenceLabel);
    NSLog(@"display label.text: %@", self.sequenceLabel.text);
}

@end
