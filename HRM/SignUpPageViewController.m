//
//  SignUpPageViewController.m
//  HRM
//
//  Created by 李家舜 on 2016/10/17.
//  Copyright © 2016年 JimSu. All rights reserved.
//

#import "SignUpPageViewController.h"
#import "CurrentUser.h"

@import FirebaseAuth;

@interface SignUpPageViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *reconfirmPasswordField;

@end

@implementation SignUpPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:true];
}

- (IBAction)createUserAccountBtnPressed:(UIButton *)sender {
    NSArray<UITextField *> *creationElement = @[_emailField, _passwordField, _reconfirmPasswordField];
    for (int i = 0; i < creationElement.count; i++) {
        CurrentUser *localUser = [CurrentUser sharedInstance];
        if (![creationElement[i].text isEqualToString:@""]) {
            creationElement[i].backgroundColor = [UIColor lightGrayColor];
            switch (i) {
                case 0:
                    localUser.email = [NSString stringWithString:creationElement[0].text];
                    break;
                case 2:
                    if ([creationElement[2].text isEqualToString:creationElement[1].text]) {
                        localUser.password = [NSString stringWithString:creationElement[1].text];
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                            [localUser createUserAccount];
                        });
                        [self performSegueWithIdentifier:@"UserInfoPageSegue" sender:sender];
                    } else {
                        creationElement[2].backgroundColor = [UIColor whiteColor];
                        creationElement[2].placeholder = @"請再次確認密碼";
                        creationElement[2].text = @"";
                    }
                    break;
                default:
                    break;
            }
        } else {
            creationElement[i].placeholder = @"請輸入資料";
        }
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
