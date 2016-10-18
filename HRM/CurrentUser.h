//
//  CurrentUser.h
//  HRM
//
//  Created by 李家舜 on 2016/10/18.
//  Copyright © 2016年 JimSu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentUser : NSObject

@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) NSNumber *authority;
@property (strong, nonatomic) NSString *displayName;

+ (instancetype) sharedInstance;

- (void)createUserAccount;

- (void)updateUserInfoWithDict:(NSMutableDictionary *)userInfo;

@end
