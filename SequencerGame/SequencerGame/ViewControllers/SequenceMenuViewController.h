//
//  SequenceMenuViewController.h
//  PipeGame
//
//  Created by John Saba on 4/27/13.
//
//

#import <UIKit/UIKit.h>
#import "SequenceViewController.h"

@interface SequenceMenuViewController : UIViewController <SequenceViewControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UIImageView *dropShadowImageView;
@property (strong, nonatomic) IBOutlet UIView *topView;

@end
