//
//  CurrentUser.m
//  HRM
//
//  Created by 李家舜 on 2016/10/18.
//  Copyright © 2016年 JimSu. All rights reserved.
//

#import "CurrentUser.h"

@import FirebaseAuth;
@import FirebaseDatabase;

@implementation CurrentUser

static FIRDatabaseReference *_ref;

+ (instancetype)sharedInstance {
    static CurrentUser *_localUser;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _localUser = [CurrentUser new];
    });
    return _localUser;
}

- (void)createUserAccount {
    [[FIRAuth auth] createUserWithEmail:self.email password:self.password completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
        if (user != nil) {
            self.uid = [NSString stringWithString:user.uid];
        } else {
            NSLog(@"Error (Account Creation): %@", error);
        }
    }];
}

- (void)updateUserInfoWithDict:(NSMutableDictionary *)userInfo {
    if (_ref == nil) {
        _ref = [[FIRDatabase database] reference];
    }
    [userInfo removeObjectForKey:@"Name"];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"YYYY/mm/dd HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    NSDictionary *userInfoDetail = @{@"Authority": @0, @"Email": self.email, @"Info": userInfo, @"SignUpDate": dateString, @"UID": self.uid};
    [[_ref child:self.displayName] updateChildValues:userInfoDetail];
}

@end
