//
//  ViewController.m
//  UIPopoverControllers #36
//
//  Created by Евгений Глухов on 07.08.15.
//  Copyright (c) 2015 EGApps. All rights reserved.
//

#import "EGInfoViewController.h"

@interface EGInfoViewController ()

@end

@implementation EGInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // В данном классе мы объединили поповер вступительный и с UIDatePicker.
    
    if (self.welcomeText) {
        
        // Если вступительный текст был установлен в классе EGTableViewController, значит оформляем поповер для вступления (прячем UIDatePicker)
        
        self.infoLabel.hidden = NO;
        self.datePicker.hidden = YES;
        
        self.infoLabel.text = self.welcomeText;
        
    } else if (self.dateOfBirth) {
        
        // Если установлена дата рождения, прячем тогда infoLabel
        
        self.infoLabel.hidden = YES;
        self.datePicker.hidden = NO;
        
        self.datePicker.date = self.dateOfBirth;
        
        
        
    } else {
        
        NSLog(@"MISTAKE");
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// При выходе из поповера, он уничтожается, освобождая память
- (void) dealloc {
    
    NSLog(@"Popover has been deallocated");
    
}

- (IBAction)backButtonAction:(UIButton *)sender {
    
    NSLog(@"backButtonAction");
    
    // Инициализация текущего контроллера для обращения к нему!!!!
    
//    EGViewController* popoverController = (EGViewController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    // или так!
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)datePickerAction:(UIDatePicker *)sender {
    // Метод вызывается при изменении даты на барабане
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"dd.MM.yyyy"];
    
    self.userDate = [formatter stringFromDate:sender.date];
    
    // отправляем результат делегату для отображения в текстфилде
    [self.delegate sendedDateOfBirth:self.userDate];
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSLog(@"prepareForSegue - %@", segue.identifier);
    
}

@end
