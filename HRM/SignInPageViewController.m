//
//  SignInPageViewController.m
//  HRM
//
//  Created by 李家舜 on 2016/10/17.
//  Copyright © 2016年 JimSu. All rights reserved.
//

#import "SignInPageViewController.h"

@import FirebaseAuth;

@interface SignInPageViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UILabel *passwordField;

@end

@implementation SignInPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:true];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:false];
}

- (IBAction)signInBtnPressed:(UIButton *)sender {
    if (![_emailField.text isEqualToString:@""] && ![_passwordField.text isEqualToString:@""]) {
        [[FIRAuth auth] signInWithEmail:_emailField.text password:_passwordField.text completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
            if (user != nil) {
                //..
            } else {
                NSLog(@"Error (Sign in): %@", error);
            }
        }];
    }
}

- (IBAction)createNewAccountBtnPressed:(id)sender {
    [self performSegueWithIdentifier:@"SignUpPageSegue" sender:sender];
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
