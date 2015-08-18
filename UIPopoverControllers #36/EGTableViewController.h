//
//  EGTableViewController.h
//  UIPopoverControllers #36
//
//  Created by Евгений Глухов on 07.08.15.
//  Copyright (c) 2015 EGApps. All rights reserved.
//

// ВСЕ СДЕЛАНО ПОЛНОСТЬЮ ЧЕРЕЗ STORYBOARD

#import <UIKit/UIKit.h>
#import "EGInfoViewController.h"
#import "EGEducationTableTableViewController.h"

@interface EGTableViewController : UITableViewController <UITextFieldDelegate>


@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *regLabels;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *regTextFields;
@property (weak, nonatomic) IBOutlet UISegmentedControl *genderControl;


@end
