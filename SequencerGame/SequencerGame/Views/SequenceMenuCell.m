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

//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    // Initialization code
//
//    if (self) {
//        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        self.goToButton.imageView.contentMode = UIViewContentModeCenter;
//    }
//    return self;
//}

- (void)configureWithIndexPath:(NSIndexPath *)indexPath
{
    self.backgroundColor = [UIColor lightGrayColor];
//    [SAViewManipulator setGradientBackgroundImageForView:self.backgroundView
//                                            withTopColor:[UIColor darkGrayColor]
//                                          andBottomColor:[UIColor lightGrayColor]];
//    self.backgroundColor = [UIColor clearColor];
    
//    self.sequenceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//    self.sequenceLabel.textColor = [UIColor blackColor];
//    self.sequenceLabel.backgroundColor = [UIColor clearColor];
//    self.sequenceLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SequenceMenuCellLabel" owner:self options:nil];
    self.sequenceLabel = [nib objectAtIndex:0];

    self.sequenceLabel.text = [NSString stringWithFormat:@"%i", indexPath.row + 1];
    [self addSubview:self.sequenceLabel];
    
    
    NSLog(@"self.display label: %@", self.sequenceLabel);
    NSLog(@"display label.text: %@", self.sequenceLabel.text);
}

@end
