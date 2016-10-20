//
//  UserInfoPageViewController.m
//  HRM
//
//  Created by 李家舜 on 2016/10/17.
//  Copyright © 2016年 JimSu. All rights reserved.
//

#import "UserInfoPageViewController.h"
#import "CurrentUser.h"

@import FirebaseAuth;
@import FirebaseDatabase;

@interface UserInfoPageViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *genderField;
@property (weak, nonatomic) IBOutlet UITextField *positionField;
@property (weak, nonatomic) IBOutlet UITextField *birthdayField;
@property (weak, nonatomic) IBOutlet UITextField *IDCardNumberField;
@property (weak, nonatomic) IBOutlet UITextField *heightField;
@property (weak, nonatomic) IBOutlet UITextField *weightField;
@property (weak, nonatomic) IBOutlet UITextField *bloodTypeField;
@property (weak, nonatomic) IBOutlet UITextField *cellphoneNumberField;
@property (weak, nonatomic) IBOutlet UITextField *marriageField;
@property (weak, nonatomic) IBOutlet UITextField *mailingAddressField;

@property (strong, nonatomic) FIRDatabaseReference *ref;

@end

@implementation UserInfoPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)completeAccountCreationBtnPressed:(UIButton *)sender {
    NSArray<UITextField *> *userInfoForm = @[_nameField, _genderField, _positionField, _birthdayField, _IDCardNumberField, _heightField, _weightField, _bloodTypeField, _cellphoneNumberField, _marriageField, _mailingAddressField];
    NSArray *userInfoKey = @[@"Name", @"Gender", @"Position", @"Birthday", @"IDCardNumber", @"Height", @"Weight", @"BloodType", @"CellphoneNumber", @"Marriage", @"MailingAddress"];
    NSMutableDictionary *userInfo = [NSMutableDictionary new];
    CurrentUser *localUser = [CurrentUser sharedInstance];
    for (int i = 0; i < userInfoForm.count; i++) {
        if (![userInfoForm[i].text isEqualToString:@""]) {
            userInfoForm[i].backgroundColor = [UIColor lightGrayColor];
            switch (i) {
                case 0:
                    [userInfo setValue:userInfoForm[i].text forKey:userInfoKey[i]];
                    localUser.displayName = [NSString stringWithString:userInfoForm[0].text];
                    break;
                default:
                    [userInfo setValue:userInfoForm[i].text forKey:userInfoKey[i]];
                    break;
            }
        } else {
            userInfoForm[i].placeholder = @"請輸入資料";
        }
    }
    if (userInfo.count == userInfoForm.count) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [localUser updateUserInfoWithDict:userInfo];
        });
        [self.navigationController popToRootViewControllerAnimated:true];
    }
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
