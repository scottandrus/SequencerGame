//
//  SequenceMenuViewController.m
//  SequencerGame
//
//  Created by John Saba on 4/27/13.
//
//

#import "SequenceViewController.h"
#import "TextureUtils.h"
#import "SequenceLayer.h"

@interface SequenceViewController ()

@end

@implementation SequenceViewController

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
    
    // load our textures
    [TextureUtils loadTextures];    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [[CCDirector sharedDirector] setDelegate:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // run cocos2d scene
    CCDirector *director = [CCDirector sharedDirector];
    if(director.runningScene) {
        [director replaceScene:[SequenceLayer sceneWithSequence:self.sequence]];
    }
    else {
        [director runWithScene:[SequenceLayer sceneWithSequence:self.sequence]];
    }
}

- (IBAction)pressedBack:(id)sender
{
    [self.delegate pressedBack];
//    [[self presentingViewController] dismissViewControllerWithFoldStyle:MPFoldStyleDefault completion:^(BOOL finished) {
        // completion
//    }];
}
@end
