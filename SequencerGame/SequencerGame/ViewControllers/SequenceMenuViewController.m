//
//  SequenceMenuViewController.m
//  SequencerGame
//
//  Created by John Saba on 4/27/13.
//
//

#import "SequenceMenuViewController.h"
#import "PathUtils.h"
#import "SequenceMenuCell.h"
#import "SAViewManipulator.h"
#import "UIColor+i7HexColor.h"

@interface SequenceMenuViewController ()

@end

@implementation SequenceMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView registerClass:[SequenceMenuCell class] forCellWithReuseIdentifier:@"SequenceMenuCell"];
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
    [self customizeInterface];
}

- (void)customizeInterface {
    self.view.frame = CGRectMake(self.view.frame.origin.x,
                                 self.view.frame.origin.y,
                                 self.view.frame.size.height,
                                 self.view.frame.size.width);
    [SAViewManipulator setGradientBackgroundImageForView:self.view
                                            withTopColor:[UIColor colorWithHexString:@"F2F2F2"]
                                          andBottomColor:[UIColor colorWithHexString:@"F2F2F2"]];
    NSLog(@"%@", self.view);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
    return 3;
    // once we get tiled maps in, we'll use this instead:
//    return [PathUtils tileMapNames].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SequenceMenuCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"SequenceMenuCell" forIndexPath:indexPath];
    
    [cell configureWithIndexPath:indexPath];

    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SequenceViewController *sequenceViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Sequence"];
    sequenceViewController.sequence = indexPath.row;
    sequenceViewController.delegate = self;
    [self presentViewController:sequenceViewController animated:YES completion:^{
        // completion
    }];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(0, 0);
}

#pragma mark - sequenceViewControllerDelegate

- (void)pressedBack
{
    [self dismissViewControllerAnimated:YES completion:^{
        // completion
    }];
}

@end
