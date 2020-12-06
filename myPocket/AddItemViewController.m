//
//  AddItemViewController.m
//  My Pocket
//
//  Created by Engin KUK on 30.11.2020.
//

#import "AddItemViewController.h"

@interface AddItemViewController ()

@end

@implementation AddItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Add an expense";
    self.expensePrice.keyboardType = 4;

    // Do any additional setup after loading the view.
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
    [self.delegate didSaveNewExpense:self.textField.text:self.expensePrice.text];
    [self dismissViewControllerAnimated:true completion:nil];
}
@end
