//
//  AppDelegate.m
//  Otter
//
//  Created by Onsager Alex on 10/9/12.
//  Copyright (c) 2012 Onsager Alex. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  ACAccountStore *accountStore = [[ACAccountStore alloc]init];
  ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
  [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
    if(granted){
      NSArray *accounts = [accountStore accountsWithAccountType:accountType];
      
      if (accounts != nil && [accounts count] != 0) {
        ACAccount *twAccount = [accounts objectAtIndex:1];
        NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1/statuses/update.json"];
        NSDictionary *params = [NSDictionary dictionaryWithObject:@"Testing update" forKey:@"status"];
        SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodPOST URL:url parameters:params];
        request.account = twAccount;
        /*[request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
          NSString *output = [NSString stringWithFormat:@"HTTP response status: %ld",[urlResponse statusCode]];
          NSLog(@"%@", output);
        }];*/
      }
    }
  }];
}

@end
