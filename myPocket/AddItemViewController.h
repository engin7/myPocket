//
//  AddItemViewController.h
//  My Pocket
//
//  Created by Engin KUK on 30.11.2020.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol AddItemViewControllerDelegate <NSObject>

- (void)didSaveNewExpense: (NSString *)expense :(NSString *)expensePrice;

@end

@interface AddItemViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextField *expensePrice;

@property (nonatomic, strong) id <AddItemViewControllerDelegate> delegate;

- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;

@end

NS_ASSUME_NONNULL_END
