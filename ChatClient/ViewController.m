//
//  ViewController.m
//  ChatClient
//
//  Created by Pankaj Bedse on 9/16/15.
//  Copyright (c) 2015 Pankaj Bedse. All rights reserved.
//

#import "ViewController.h"
#import <PFUser.h>
#import "ChatViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *userPassword;

@end

@implementation ViewController
- (IBAction)signIn:(id)sender {
    NSString *user = self.userName.text;
    NSString *password = self.userPassword.text;
    [PFUser logInWithUsernameInBackground:user password:password
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            // Do stuff after successful login.
                                            NSLog(@"Logged in successfully");
                                            [self performSegueWithIdentifier:@"chatViewSeque" sender:self];
                                        } else {
                                            // The login failed. Check error to see why.
                                            NSLog(@"Logged in failed");
                                            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Login failed!" message:[NSString stringWithFormat:@"Error %@",error] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                                            [alert show];
                                        }
                                    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)signUp:(id)sender {
    PFUser *user = [PFUser user];
    user.username = self.userName.text;
    user.password = self.userPassword.text;
    //user.email = @"email@example.com";
    
    // other fields can be set just like with PFObject
    //user[@"phone"] = @"415-392-0202";
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {   // Hooray! Let them use the app now.
            [self performSegueWithIdentifier:@"chatViewSeque" sender:self];
        } else {
            NSString *errorString = [error userInfo][@"error"];
            NSLog(@"Error %@",errorString);// Show the errorString somewhere and let the user try again.
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sign up failed" message:[NSString stringWithFormat:@"Error %@",errorString] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}

@end
