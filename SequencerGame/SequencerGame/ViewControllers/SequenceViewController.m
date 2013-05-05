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

@property (weak, nonatomic) CCScene *scene;

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
    self.scene = [SequenceLayer sceneWithSequence:self.sequence];
    if(director.runningScene) {
        [director replaceScene:self.scene];
    }
    else {
        [director runWithScene:self.scene];
    }
}

- (IBAction)pressedBack:(id)sender
{
    [self.delegate pressedBack];
}

- (IBAction)playSolution:(id)sender
{
    SequenceLayer *sequenceLayer = [self sequenceLayer];
    [sequenceLayer playSolutionSequence];
}

- (IBAction)runPlayerSequence:(id)sender
{
    SequenceLayer *sequenceLayer = [self sequenceLayer];
    [sequenceLayer playUserSequence];
}

- (SequenceLayer *)sequenceLayer
{
    for (CCNode *child in self.scene.children) {
        if ([child isKindOfClass:[SequenceLayer class]]) {
            return (SequenceLayer *)child;
        }
    }
    return nil;
}
@end
