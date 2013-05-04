//
//  SequenceMenuCell.h
//  SequencerGame
//
//  Created by John Saba on 4/27/13.
//
//

#import <UIKit/UIKit.h>

@interface SequenceMenuCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *sequenceLabel;

- (void)configureWithIndexPath:(NSIndexPath *)indexPath;

@end
