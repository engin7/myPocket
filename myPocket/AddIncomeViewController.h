//
//  AddIncomeViewController.h
//  My Pocket
//
//  Created by Engin KUK on 1.12.2020.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AddIncomeViewControllerDelegate <NSObject>

- (void)didSaveNewIncome: (NSString *)income :(NSString *)incomeValue;

@end

@interface AddIncomeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextField *incomePrice;

@property (nonatomic, strong) id <AddIncomeViewControllerDelegate> delegate;

- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;

@end

NS_ASSUME_NONNULL_END
