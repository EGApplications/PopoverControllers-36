//
//  ViewController.h
//  UIPopoverControllers #36
//
//  Created by Евгений Глухов on 07.08.15.
//  Copyright (c) 2015 EGApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGTableViewController.h"

@protocol EGDateOfBirthSendingDelegate <NSObject>

- (void) sendedDateOfBirth:(NSString*) dateOfBirth;

@end

@interface EGInfoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (weak, nonatomic) id <EGDateOfBirthSendingDelegate> delegate;
@property (strong, nonatomic) NSString* userDate;
@property (strong, nonatomic) NSString* welcomeText;
@property (strong, nonatomic) NSDate* dateOfBirth;


- (IBAction)backButtonAction:(UIButton *)sender;
- (IBAction)datePickerAction:(UIDatePicker *)sender;


@end



// Нужно сделать UIDatePicker при нажатии на дату рождения!!!!!
