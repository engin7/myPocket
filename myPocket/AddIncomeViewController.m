//
//  AddIncomeViewController.m
//  My Pocket
//
//  Created by Engin KUK on 1.12.2020.
//

#import "AddIncomeViewController.h"

@interface AddIncomeViewController ()

@end

@implementation AddIncomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Add an income";
    self.incomePrice.keyboardType = 4;

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)save:(id)sender {
    [self.delegate didSaveNewIncome:self.textField.text:self.incomePrice.text];
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
