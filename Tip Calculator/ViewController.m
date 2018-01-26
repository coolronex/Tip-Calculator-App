//
//  ViewController.m
//  Tip Calculator
//
//  Created by Aaron Chong on 1/26/18.
//  Copyright © 2018 Aaron Chong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;
@property (weak, nonatomic) IBOutlet UILabel *totalTipLabel;

@property (nonatomic, strong) NSDecimalNumber *totalTip;
@property (nonatomic, strong) NSDecimalNumber *percentage;

- (IBAction)calculateTipButton:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self textFieldDidBeginEditing:self.billAmountTextField];
    
    
}

#pragma mark - Text Delegate

- (void) displayBillTotalAmountText:(NSString *)text {

    self.billAmountTextField.text = text;
}

- (void) textFieldDidBeginEditing:(UITextField *)textField {
    
    [textField setClearsOnBeginEditing:YES]; // use setter on clearsOnBeginEditing to set bool to YES
}

- (void) textFieldDidEndEditing:(UITextField *)textField {
    
    [self displayBillTotalAmountText: self.billAmountTextField.text];
}



#pragma mark - Methods

- (IBAction)calculateTipButton:(UIButton *)sender {
    
    // get calculations from calculateTip method and send value to totalTip label
    
    [self calculateTip];
    [NSMutableString stringWithFormat:@"%@", self.totalTip];
    [self updateView];
}

- (void) updateView {
    
    self.totalTipLabel.text = [NSMutableString stringWithFormat:@"$%@", self.totalTip];
}


- (NSDecimalNumber *) calculateTip {
    
    self.percentage = [[NSDecimalNumber alloc] initWithDouble: 0.15];
    
     NSLog(@"%@", self.percentage);
    
    NSDecimalNumber *totalBillAmount = [[NSDecimalNumber alloc] initWithString:self.billAmountTextField.text];
    
    NSLog(@"%@", totalBillAmount);
    
    NSDecimalNumberHandler *handler = [[NSDecimalNumberHandler alloc] initWithRoundingMode:NSRoundBankers
                                                                                     scale:2
                                                                          raiseOnExactness:NO
                                                                           raiseOnOverflow:NO
                                                                          raiseOnUnderflow:NO
                                                                       raiseOnDivideByZero:NO];
    
    self.totalTip = [totalBillAmount decimalNumberByMultiplyingBy:self.percentage withBehavior:handler];

    NSLog(@"%@", self.totalTip);
    
    return self.totalTip;
}

@end
