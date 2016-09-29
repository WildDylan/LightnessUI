//
//  LTViewController.m
//  LightnessUI
//
//  Created by Dylan on 09/28/2016.
//  Copyright (c) 2016 Dylan. All rights reserved.
//

#import "LTViewController.h"

#import "LightnessUI.h"
#import "LTTableViewCell.h"

#import "NSString+SLDSBorder.h"
#import "NSString+SLDSBackground.h"
#import "NSString+SLDSText.h"

@interface LTViewController () <UITableViewDelegate, UITableViewDataSource> {
  NSInteger count;
}

@property (weak, nonatomic) IBOutlet UITableView *colorTableView;

@end

@implementation LTViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  _colorTableView.delegate = self;
  _colorTableView.dataSource = self;
  [_colorTableView registerClass:[LTTableViewCell class] forCellReuseIdentifier:@"lui_cell"];
  
  count = 4;
  
  if ( _index == 1 ) {
    count = 105;
  }
  
  if ( _index == 2 ) {
    count = 46;
  }
  
  if ( _index == 3 ) {
    count = 72;
  }
  
  if ( _index == 4 ) {
    count = 8;
  }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  LTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lui_cell" forIndexPath:indexPath];
  
  if ( _index == 0 ) {    
    cell.colorView.backgroundColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = @[@"背景色", @"边框色", @"字体色", @"字大小"][indexPath.row];
  }
  
  if ( _index == 1 ) {
    cell.textLabel.text = [NSString sldsBackgroundColorName:indexPath.row];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.l_backgroundColor = indexPath.row;
  }
  
  if ( _index == 2 ) {
    cell.textLabel.text = [NSString sldsBorderColorName:indexPath.row];
    cell.textLabel.layer.borderWidth = 1;
    cell.textLabel.l_borderColor = indexPath.row;
    cell.backgroundColor = [UIColor lightGrayColor];
  }
  
  if ( _index == 3 ) {
    cell.textLabel.text = [NSString sldsColorTextName:indexPath.row];
    cell.textLabel.l_textColor = indexPath.row;
    cell.backgroundColor = [UIColor lightGrayColor];
  }
  
  if ( _index == 4 ) {
    cell.textLabel.text = @"LightnessUI";
    cell.textLabel.l_fontWeight = 1;
    cell.textLabel.l_fontSize = indexPath.row;
  }
  
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if ( _index == 4 ) {
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    textLabel.text = @"LightnessUI";
    textLabel.l_fontWeight = 1;
    textLabel.l_fontSize = indexPath.row;
    [textLabel sizeToFit];
    
    return textLabel.frame.size.height;
  }
  return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  if ( _index == 0 ) {
    LTViewController *ltViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LTViewController"];
    ltViewController.index = indexPath.row + 1;
    [self.navigationController pushViewController:ltViewController animated:YES];
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

@end
