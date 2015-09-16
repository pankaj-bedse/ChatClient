//
//  MessageTableViewCell.h
//  ChatClient
//
//  Created by Pankaj Bedse on 9/16/15.
//  Copyright (c) 2015 Pankaj Bedse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *usrMessage;
@property (weak, nonatomic) IBOutlet UITextField *usrName;

@end
