//
//  StaticListTableViewCell.m
//  QM_HMQRCodeScanner
//
//  Created by 漂读网 on 2018/12/21.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import "StaticListTableViewCell.h"
#import "StaticListItem.h"
#import "StaticSectionItem.h"

@interface StaticListTableViewCell ()

@end

@implementation StaticListTableViewCell

static NSString *const ID = @"StaticListTableViewCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView andCellStyle:(UITableViewCellStyle)style
{
  StaticListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
  if(cell == nil)
  {
    cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
  }
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
    [self setupBaseSettingCellUI];
  }
  
  return self;
}

- (void)awakeFromNib
{
  [super awakeFromNib];
  
  [self setupBaseSettingCellUI];
}


- (void)setupBaseSettingCellUI
{
  self.detailTextLabel.numberOfLines = 0;
}

- (void)setItem:(StaticListItem *)item
{
  _item = item;
  
  [self fillData];
  
  [self changeUI];
  
  if (item.fixedCellHeight) {
    self.height = item.fixedCellHeight;
  }
}

- (void)fillData
{
  self.textLabel.text = self.item.title;
  self.detailTextLabel.text = self.item.subTitle;

  /** 左边的图片 UIImage 或者 NSURL 或者 URLString 或者 ImageName */
  if ([self.item.image isKindOfClass:[UIImage class]]) {
    self.imageView.image = self.item.image;
  }else if ([self.item.image isKindOfClass:[NSURL class]]) {
    [self.imageView qm_setWithImageURL:self.item.image placeholderImage:[UIImage imageNamed:@"timg-1.jpg"]];
  }else if ([self.item.image isKindOfClass:[NSString class]]) {
    
    if ([self.item.image hasPrefix:@"http://"] || [self.item.image hasPrefix:@"https://"] || [self.item.image hasPrefix:@"file://"]) {
      
      NSString *imageUrl = [self.item.image stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
      [self.imageView qm_setWithImageURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"timg-1.jpg"]];
    }else {
      self.imageView.image = [UIImage imageNamed:self.item.image];
    }
  }
}

- (void)changeUI
{
  self.textLabel.font = self.item.titleFont;
  self.textLabel.textColor = self.item.titleColor;
  
  self.detailTextLabel.font = self.item.subTitleFont;
  self.detailTextLabel.textColor = self.item.subTitleColor;
  self.detailTextLabel.numberOfLines = self.item.subTitleNumberOfLines;
  
  self.accessoryType = self.item.accessoryType;
  
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  
}

@end
