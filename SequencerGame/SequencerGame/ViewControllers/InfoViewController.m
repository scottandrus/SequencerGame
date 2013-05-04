//
//  InfoViewController.m
//  SequencerGame
//
//  Created by Scott Andrus on 5/4/13.
//
//

#import "InfoViewController.h"
#import "UIViewController+Overview.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)backPressed {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
