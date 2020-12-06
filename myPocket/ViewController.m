//
//  ViewController.m
//  My Pocket
//
//  Created by Engin KUK on 30.11.2020.
//

#import "ViewController.h"
#import "ListTableViewCell.h"
#import "AddItemViewController.h"
#import "AddIncomeViewController.h"
 
@interface ViewController () <UITableViewDataSource,UITableViewDelegate, AddItemViewControllerDelegate, AddIncomeViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *type;
@property (strong, nonatomic) NSMutableArray *items;
@property (strong, nonatomic) NSMutableArray *values;
@property (nonatomic, assign) NSInteger balance;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"Net Balance in $ %li",  (long)self.balance];
    self.type = [[NSMutableArray alloc] init];
    self.items = [[NSMutableArray alloc] init];
    self.values = [[NSMutableArray alloc] init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:( NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"ListTableViewCell";
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell) {
        cell = [[ListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSString *expenseText =@"";
    
    if ([self.type[indexPath.row] boolValue]) {
        expenseText = [NSString stringWithFormat:@"income: %@   value: $%@",  self.items[indexPath.row], self.values[indexPath.row]];
            cell.backgroundColor = [UIColor greenColor];
    } else {
       expenseText = [NSString stringWithFormat:@"expense: %@   value: $%@",  self.items[indexPath.row], self.values[indexPath.row]];
           cell.backgroundColor = [UIColor orangeColor];
    }
        
    cell.titleLabel.text = expenseText;

    return cell;
 }

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
       
        NSInteger myInt = [self.values[indexPath.row] intValue];

        if ([self.type[indexPath.row] boolValue]) {
            self.balance -= myInt;
        } else {
            self.balance += myInt;
        }
        [self.type removeObjectAtIndex:indexPath.row];
        [self.items removeObjectAtIndex:indexPath.row];
        [self.values removeObjectAtIndex:indexPath.row];
        
        self.title = [NSString stringWithFormat:@"Net Balance in $ %li",  (long)self.balance];

        [tableView reloadData];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"cell was touched %@", indexPath);
    NSLog(@"bool %@",self.type);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UINavigationController *nav = segue.destinationViewController;
    AddItemViewController *addVC = nav.viewControllers[0];
    addVC.delegate = self;
    AddIncomeViewController *addIncomeVC = nav.viewControllers[0];
    addIncomeVC.delegate = self;
}

- (void)didSaveNewExpense:(NSString *)expense :(NSString *)expensePrice {
    [self.type addObject:[NSNumber numberWithBool:NO]];
    [self.items addObject:expense];
    [self.values addObject:expensePrice];
    NSInteger myInt = [expensePrice intValue];
    self.balance -= myInt;
    self.title = [NSString stringWithFormat:@"Net Balance in $ %li",  (long)self.balance];
    [self.tableView reloadData];
}

- (void)didSaveNewIncome:(NSString *)income :(NSString *)incomeValue {
    [self.type addObject:[NSNumber numberWithBool:YES]];
    [self.items addObject:income];
    [self.values addObject:incomeValue];
    NSInteger myInt = [incomeValue intValue];
    self.balance += myInt;
    self.title = [NSString stringWithFormat:@"Net Balance in $ %li",  (long)self.balance];
    [self.tableView reloadData];
}
 
@end
