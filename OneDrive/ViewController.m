//
//  ViewController.m
//  OneDrive
//
//  Created by Webwerks on 6/23/15.
//  Copyright (c) 2015 Webwerks. All rights reserved.
//

#import "ViewController.h"

static NSString * const CLIENT_ID = @"*********";

@interface ViewController ()

@end

@implementation ViewController

@synthesize appLogo;
@synthesize userInfoLabel;
@synthesize signInButton;
@synthesize viewPhotosButton;
@synthesize userImage;
@synthesize liveClient;
@synthesize currentModal;


- (void)viewDidLoad {

    [super viewDidLoad];
    
    dictHome = [[NSMutableDictionary alloc] init];
    _scopes = [NSArray arrayWithObjects:
               @"wl.signin",
               @"wl.basic",
               @"wl.skydrive",
               @"wl.offline_access", nil];
    liveClient = [[LiveConnectClient alloc] initWithClientId:CLIENT_ID
                                                      scopes:_scopes
                                                    delegate:self];
    if (self.liveClient.session == nil)
    {
        //NSLog(@"tast");
        [self.liveClient login:self
                        scopes:_scopes
                      delegate:self];
        
    }
    else
    {
                
        [self.liveClient logoutWithDelegate:self
                                  userState:@"logout"];
    }
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ([CLIENT_ID isEqualToString:@"%CLIENT_ID%"]) {
        [NSException raise:NSInvalidArgumentException format:@"The CLIENT_ID value must be specified."];
    }
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _scopes = [NSArray arrayWithObjects:
                   @"wl.signin",
                   @"wl.basic",
                   @"wl.skydrive",
                   @"wl.offline_access", nil];
        liveClient = [[LiveConnectClient alloc] initWithClientId:CLIENT_ID
                                                          scopes:_scopes
                                                        delegate:self];
    }
    return self;
}

- (void) authCompleted: (LiveConnectSessionStatus) status
               session: (LiveConnectSession *) session
             userState: (id) userState {
    [self updateUI];
}

- (void) authFailed: (NSError *) error
          userState: (id)userState {
    // Handle error here
}

#pragma mark LiveAuthDelegate

- (void) updateUI {
    LiveConnectSession *session = self.liveClient.session;
    
    //NSLog(@"completed");
    if (session == nil) {
//        [self.signInButton setTitle:@"Sign in" forState:UIControlStateNormal];
//        self.viewPhotosButton.hidden = YES;
//        self.userInfoLabel.text = @"Sign in with a Microsoft account before you can view your SkyDrive photos.";
//        self.userImage.image = nil;
    }
    else {
        [self.liveClient getWithPath:@"me/skydrive/files"
                            delegate:self userState:@"get"];
//        [self.signInButton setTitle:@"Sign out" forState:UIControlStateNormal];
//        self.viewPhotosButton.hidden = NO;
//        self.userInfoLabel.text = @"";
//        
//        [self.liveClient getWithPath:@"me" delegate:self userState:@"me"];
//        [self.liveClient getWithPath:@"me/picture" delegate:self userState:@"me-picture"];
        //[self getLinkToFile];
    }
    
    
}


- (void) liveOperationSucceeded:(LiveOperation *)operation
{
    
    NSArray *name = [[operation.result objectForKey:@"data"] valueForKey:@"name"];
    NSArray *ID = [[operation.result objectForKey:@"data"] valueForKey:@"id"];
    NSArray *count = [[operation.result objectForKey:@"data"] valueForKey:@"count"];
    
    [dictHome setObject:name forKey:@"Name"];
    [dictHome setObject:ID forKey:@"ID"];
    [dictHome setObject:count forKey:@"Count"];
    //[self.tblHome reloadData];
    NSLog(@"data %@",dictHome);
    
}

- (void) liveOperationFailed:(NSError *)error
                   operation:(LiveOperation *)operation
{
    NSLog(@"Error == %@",error);
    
    
}


@end
