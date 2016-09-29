//
//  UIView+Lightness.h
//  Pods
//
//  Created by Dylan on 2016/9/29.
//
//

#import <UIKit/UIKit.h>

#import "SLDSColorBrdr.h"
#import "SLDSColorBg.h"

#import "SLDSColorTxt.h"
#import "SLDSFontSz.h"

#import "SLDSSizing.h"

#import "SLDSIconAction.h"
#import "SLDSIconStandard.h"
#import "SLDSIconUtility.h"

@interface UIView (Lightness)

#pragma mark - UIView and subclass
/**
 Set borderColor with `SLDSColorBorderType`, all subclass of UIView can use it.
 Border width controlled by layer's borderWidth.
 */
@property ( nonatomic, assign ) SLDSColorBorderType l_borderColor;
/**
 Set backgroundColor with `SLDSColorBgType`, all subclass of UIView can use it.
 */
@property ( nonatomic, assign ) SLDSColorBgType l_backgroundColor;
/**
 Set tintColor with `SLDSColorBgType`, all subclass of UIView can use it.
 */
@property ( nonatomic, assign ) SLDSColorBgType l_tintColor;

#pragma mark - Subclass within text
/**
 Set textColor with `SLDSColorTextType`, which UI component within text.
 */
@property ( nonatomic, assign ) SLDSColorTextType l_textColor;
/**
 FontWeight: 
 0: lightFont
 1: regularFont
 2: strongFont
 Default is regularFont
 */
@property ( nonatomic, assign ) NSInteger l_fontWeight;
/**
 Set fontSize with `SLDSFontSizeType`, which UI component within text.
 Font is used `Lightness Font`, if u wan't to custom this Font, don't use this method.
 */
@property ( nonatomic, assign ) SLDSFontSizeType l_fontSize;

#pragma mark - property that bar used only
/**
 Set tintColor with `SLDSColorBgType`, all subclass of UIView can use it.
 */
@property ( nonatomic, assign ) SLDSColorBgType l_barTintColor;

#pragma mark - property that used for attributeText, attributeTitle properties.
/**
 Only used for UILabel.attributeText, UITextField.attributedText, UITextView.attributedText, UIButton.attributeTitle UISegmentControl.attributes for normal state.
 \param range, Attribute want set ranges.
 */
- (void) updateAttributeWithColor: (SLDSColorTextType)textColorType
                       fontWeight: (NSInteger)weight
                         fontSize: (CGFloat)size
                          inRange: (NSRange)range;
/**
 Only used for UIButton.attributeTitle UISegmentControl.attributes for state.
 \param range, Attribute want set ranges.
 \param state, Attribute state
 */
- (void) updateAttributeWithColor: (SLDSColorTextType)textColorType
                       fontWeight: (NSInteger)weight
                         fontSize: (CGFloat)size
                          inRange: (NSRange)range
                         forState: (UIControlState)state;

#pragma mark - Get custom icons
/**
 Get custom icon with `SLDSIconActionType`, you can find Size prop in `SLDSSizing.h`.
 */
+ (UIImage *)getIconWithType: (SLDSIconActionType) iconType
                    withSize: (int) size;

#pragma mark - Get standard icons
/**
 Get standard icon with `SLDSIconActionType`, you can find Size prop in `SLDSSizing.h`.
 */
+ (UIImage *)getStandardIconWithType: (SLDSIconStandardType) iconType
                            withSize: (int) size;

#pragma mark - Get utility icons
/**
 Get utility icon with `SLDSIconActionType`, you can find Size prop in `SLDSSizing.h`.
 */
+ (UIImage *)getUtilityIconWithType: (SLDSIconUtilType) iconType
                           withSize: (int) size;

@end
