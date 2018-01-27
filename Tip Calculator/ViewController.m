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
@property (weak, nonatomic) IBOutlet UITextField *tipPercentageTextField;
@property (weak, nonatomic) IBOutlet UILabel *totalTipLabel;

@property (nonatomic, strong) NSDecimalNumber *totalTip;
@property (nonatomic, strong) NSDecimalNumber *percentage;
@property (nonatomic, strong) NSDecimalNumber *oneHundred;

- (IBAction)calculateTipButton:(UIButton *)sender;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //don't really need the code below since we already set it in storyboard
    [self textFieldDidBeginEditing:self.billAmountTextField];
    
}

#pragma mark - Text Delegate



//don't really need the code below since we already set it in storyboard

- (void) textFieldDidBeginEditing:(UITextField *)textField {
    
    [textField setClearsOnBeginEditing:YES]; // use setter on clearsOnBeginEditing to set bool to YES
}

- (void) textFieldDidEndEditing:(UITextField *)textField {
    
    [self displayBillTotalAmountText: self.billAmountTextField.text];
}

#pragma mark - Methods


- (void) displayBillTotalAmountText:(NSString *)text {
    
    self.billAmountTextField.text = text;
}


- (IBAction)calculateTipButton:(UIButton *)sender {
    
    // get calculations from calculateTip method and send value to totalTip label
    [self calculateTip];
    [self updateView];
}


- (void) calculateTip {
    
    if ([self.tipPercentageTextField.text isEqualToString:@""]) {
        
        [self.tipPercentageTextField setText:@"0"];
    }
    
    self.percentage = [[NSDecimalNumber alloc] initWithString:self.tipPercentageTextField.text]; 
    
    self.oneHundred = [[NSDecimalNumber alloc] initWithInt:100];
    NSDecimalNumber *percentage = [self.percentage decimalNumberByDividingBy:self.oneHundred];
    
    NSLog(@"Percentage: %@", percentage);
    
    NSDecimalNumber *totalBillAmount = [[NSDecimalNumber alloc] initWithString:self.billAmountTextField.text];
    NSLog(@"Total Bill: %@", totalBillAmount);
    
    // behaviour to be used for the method 'decimalNumberBy...'
    NSDecimalNumberHandler *handler = [[NSDecimalNumberHandler alloc] initWithRoundingMode:NSRoundBankers
                                                                                     scale:2
                                                                          raiseOnExactness:NO
                                                                           raiseOnOverflow:NO
                                                                          raiseOnUnderflow:NO
                                                                       raiseOnDivideByZero:NO];
    
    self.totalTip = [totalBillAmount decimalNumberByMultiplyingBy:percentage withBehavior:handler];
    NSLog(@"Total Tip: %@", self.totalTip);
    
}

- (void) updateView {
    
    self.totalTipLabel.text = [NSMutableString stringWithFormat:@"Total Tip: $%@", self.totalTip];
}
@end
