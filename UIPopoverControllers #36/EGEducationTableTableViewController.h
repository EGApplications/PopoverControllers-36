//
//  EGEducationTableTableViewController.h
//  UIPopoverControllers #36
//
//  Created by Евгений Глухов on 18.08.15.
//  Copyright (c) 2015 EGApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGTableViewController.h"

@protocol EGEducationSkillDelegate <NSObject>

- (void) sendedEducationSkill:(NSString*) educationSkill;

@end

@interface EGEducationTableTableViewController : UITableViewController <UITableViewDelegate>

@property (weak, nonatomic) id <EGEducationSkillDelegate> delegate;
@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *educationCells;


@end
