//
//  ViewController.h
//  OneDrive
//
//  Created by Webwerks on 6/23/15.
//  Copyright (c) 2015 Webwerks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LiveSDK/LiveConnectClient.h>
//#import "PSSkyDriveObject.h"

@interface ViewController : UIViewController<LiveAuthDelegate, LiveOperationDelegate>
{
@private NSArray *_scopes;
NSMutableDictionary *dictHome;
}
@property (strong, nonatomic) IBOutlet UIImageView *appLogo;
@property (strong, nonatomic) IBOutlet UILabel *userInfoLabel;
@property (strong, nonatomic) IBOutlet UIImageView *userImage;

@property (strong, nonatomic) IBOutlet UIButton *signInButton;
@property (strong, nonatomic) IBOutlet UIButton *viewPhotosButton;
@property (strong, nonatomic) LiveConnectClient *liveClient;
@property (strong, nonatomic) UIViewController *currentModal;
//@property (strong, nonatomic) PSSkyDriveObject *rootFolder;
//@property (strong, nonatomic) PSSkyDriveObject *currentFolder;


//- (IBAction)signinButtonClicked:(id)sender;
//- (IBAction)viewPhotoButtonClicked:(id)sender;
//
- (void) updateUI;
//- (void) modalCompleted:(id)sender;


@end

