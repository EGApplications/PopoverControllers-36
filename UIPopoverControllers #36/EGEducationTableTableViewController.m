//
//  EGEducationTableTableViewController.m
//  UIPopoverControllers #36
//
//  Created by Евгений Глухов on 18.08.15.
//  Copyright (c) 2015 EGApps. All rights reserved.
//

#import "EGEducationTableTableViewController.h"

@interface EGEducationTableTableViewController ()

@end

@implementation EGEducationTableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // таблицу сразу в режим редактирования
    [self.tableView setEditing:YES animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Плавно снимаем выделение серым ячейки
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        
    });
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Здесь смотрим, по какой строке нажали.
    
    NSString* educationSkill;
    
    switch (indexPath.row) {
            
        case 0:
            
            educationSkill = @"Неполное среднее";
            
            break;
            
        case 1:
            
            educationSkill = @"Cреднее";
            
            break;
            
        case 2:
            
            educationSkill = @"Неполное высшее";
            
            break;
            
        case 3:
            
            educationSkill = @"Высшее";
            
            break;
            
        default:
            
            educationSkill = @"Не выбрано";
            
            break;
    }
    
    [self.delegate sendedEducationSkill:educationSkill];
    // Передаем данные о выбранном образовании делегату и закрываем контроллер
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    });
    
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 3; // Неведомая хрень!!! Максимум в enum это номер 2
    
}

@end
