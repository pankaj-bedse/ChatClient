//
//  ChatViewController.m
//  ChatClient
//
//  Created by Pankaj Bedse on 9/16/15.
//  Copyright (c) 2015 Pankaj Bedse. All rights reserved.
//

#import "ChatViewController.h"
#import <PFUser.h>
#import <PFQuery.h>
#import "MessageTableViewCell.h"

@interface ChatViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usrMessage;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *messages;

@end

@implementation ChatViewController
- (IBAction)saveMessage:(id)sender {
    PFObject *userMessage = [PFObject objectWithClassName:@"Message"];
    userMessage[@"text"] = self.usrMessage.text;
    userMessage[@"user"] = [PFUser currentUser];
    NSLog(@"user %@", [PFUser currentUser]);
    [userMessage saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
            NSLog(@"Saved message successfully");
        } else {
            // There was a problem, check error.description
            NSLog(@"Error : %@", error.description);
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self retrieveMessages];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector: @selector(retrieveMessages) userInfo:nil repeats:YES];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)retrieveMessages
{
    PFQuery *query = [PFQuery queryWithClassName:@"Message"];
    [query includeKey:@"user"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            self.messages = objects;
            [self.tableView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messageCell"];
    cell.usrMessage.text = self.messages[indexPath.row][@"text"];
    NSLog(@"user : %@",self.messages[indexPath.row][@"user"] );
    if (self.messages[indexPath.row][@"user"]) {
        cell.usrName.text = [self.messages[indexPath.row][@"user"] username];
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.messages count];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
