//
//  EGTableViewController.m
//  UIPopoverControllers #36
//
//  Created by Евгений Глухов on 07.08.15.
//  Copyright (c) 2015 EGApps. All rights reserved.
//

#import "EGTableViewController.h"

static NSString* kRegName = @"Name";
static NSString* kRegSurname = @"Surname";
static NSString* kRegGender = @"Gender";
static NSString* kRegDateOfBirth = @"DateOfBirth";
static NSString* kRegEducation = @"Education";

@interface EGTableViewController () <UITableViewDelegate, EGDateOfBirthSendingDelegate, EGEducationSkillDelegate>

@property (strong, nonatomic) UIPopoverController* popover;
@property (strong, nonatomic) NSString* dateOfBirth; // свойства даты рождения и образование для использования их в PrepareForSegue методе
@property (strong, nonatomic) NSString* educationSkill;

@end

@implementation EGTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self.regTextFields objectAtIndex:0] becomeFirstResponder];
    // Клавиатура на первом текстфилде
    
    [self loadData]; // Грузим данные, если они были раньше введены
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Save & Load data

- (void) saveData { // Сохранение введенных данных
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:[[self.regTextFields objectAtIndex:0] text] forKey:kRegName];
    
    [userDefaults setObject:[[self.regTextFields objectAtIndex:1] text] forKey:kRegSurname];
    
    [userDefaults setBool:self.genderControl.selectedSegmentIndex forKey:kRegGender];
    
    [userDefaults setObject:[[self.regTextFields objectAtIndex:2] text] forKey:kRegDateOfBirth];
    
    [userDefaults setObject:[[self.regTextFields objectAtIndex:3] text] forKey:kRegEducation];
    
}

- (void) loadData { // загрузка введенных ранее данных
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    
    [[self.regTextFields objectAtIndex:0] setText:[NSString stringWithFormat:@"%@", [userDefaults objectForKey:kRegName]]];
    
    [[self.regTextFields objectAtIndex:1] setText:[NSString stringWithFormat:@"%@", [userDefaults objectForKey:kRegSurname]]];
    
    self.genderControl.selectedSegmentIndex = [userDefaults integerForKey:kRegGender];
    
    [[self.regTextFields objectAtIndex:2] setText:[NSString stringWithFormat:@"%@", [userDefaults objectForKey:kRegDateOfBirth]]];
    
    [[self.regTextFields objectAtIndex:3] setText:[NSString stringWithFormat:@"%@", [userDefaults objectForKey:kRegEducation]]];
    
    
}

#pragma mark - UITableViewDelegate

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    // Ячейка TableView не становится серой
    
    return NO;
    
}

#pragma mark - EGDateOfBirthSendingDelegate

// Метод созданнго нами делегата для передачи даты рождения из контроллера с UIDatePicker в основной
- (void) sendedDateOfBirth:(NSString*) dateOfBirth {
    
    UITextField* dateOfBirthField = [self.regTextFields objectAtIndex:2];
    
    // выставляем принимаемую дату
    dateOfBirthField.text = dateOfBirth;
    
    self.dateOfBirth = dateOfBirth;
    
    [self saveData];
    
}

#pragma mark - EGEducationSkillDelegate

// Аналогичный вышеупомянутому методу метод для передачи информации об уровне образования
- (void) sendedEducationSkill:(NSString*) educationSkill {
    
    UITextField* educationTextField = [self.regTextFields objectAtIndex:3];
    
    educationTextField.text = educationSkill;
    
    self.educationSkill = educationSkill;
    
    [self saveData];
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
 
    // В данном методе не даем курсору поставится на текстфилды даты рождения и уровня образования. При клике на них, выскакивают поповеры
    
    [self saveData];
    
    if ([textField isEqual:[self.regTextFields objectAtIndex:2]]) {
        
        // вызываем поповер с переходным ID - dateOfBirthAction
        [self performSegueWithIdentifier:@"dateOfBirthAction" sender:textField];
        
        return NO;
        
    } else if ([textField isEqual:[self.regTextFields objectAtIndex:3]]) {
        
        // вызываем поповер ID - educationAction
        [self performSegueWithIdentifier:@"educationAction" sender:textField];
        
        return NO;
        
    } else {
        
        return YES;
        
    }
    
    return YES;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // При нажатии на return клавиатура убирается
    
    [textField resignFirstResponder];
    
    [self saveData]; // сохраняем данные при нажатии на кнопку return
    
    return YES;
    
}


#pragma mark - Segue

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Данный метод реализуется при переходе от одного контроллера к другому
    
    NSLog(@"WAT - %@, %@", segue.identifier, NSStringFromClass([segue.destinationViewController class]));
    
    if ([segue.identifier isEqualToString:@"infoAction"]) { // Смотрим по ID перехода
        
        EGInfoViewController* popoverController = segue.destinationViewController;

        // Устанавливаем в новом контроллере свойство
        popoverController.welcomeText = @"Welcome to the Registration App";
        
    } else if ([segue.identifier isEqualToString:@"dateOfBirthAction"]) {
        
        EGInfoViewController* popoverController = segue.destinationViewController;
        
        // Устанавливаем делегата контроллеру, иначе не сможем передавать данные из одного контроллера в другой
        popoverController.delegate = self;
        
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        
        NSDate* currentDate = [NSDate date];
        
        [formatter setDateFormat:@"dd.MM.yyyy"];
        
        if (self.dateOfBirth) { // Если уже была установлена дата рождения, значит в новом поповере берем ее за стартовую
            
            NSDate* dateOfBirth = [formatter dateFromString:self.dateOfBirth];
            
            popoverController.dateOfBirth = dateOfBirth;
            
        } else { // иначе сегодняшнее число
        
            popoverController.dateOfBirth = currentDate;
            
        }
        
    } else { // segue.identifier - educationAction
        
        EGEducationTableTableViewController* popoverController = segue.destinationViewController;
        
        popoverController.delegate = self;
        
    }
    
}
@end
