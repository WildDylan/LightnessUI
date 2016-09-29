//
//  UIView+Lightness.m
//  Pods
//
//  Created by Dylan on 2016/9/29.
//
//

#import "UIView+Lightness.h"
#import <objc/runtime.h>

#import "UIColor+SLDSBorder.h"
#import "UIColor+SLDSBackground.h"

#import "UIColor+SLDSText.h"
#import "UIFont+SLDSFont.h"

#import "UIImage+SLDSIconAction.h"
#import "UIImage+SLDSIconCustom.h"
#import "UIImage+SLDSIconStandard.h"
#import "UIImage+SLDSIconUtility.h"

@implementation UIView (Lightness)

#pragma mark - UIView and subclass
/**
 Set borderColor with `SLDSColorBorderType`, all subclass of UIView can use it.
 Border width controlled by layer's borderWidth.
 */
static char l_borderColor_key;

- (void)setL_borderColor:(SLDSColorBorderType)l_borderColor {
  objc_setAssociatedObject(self, &l_borderColor_key, @(l_borderColor), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  self.layer.borderColor = [UIColor sldsBorderColor:l_borderColor].CGColor;
}

- (SLDSColorBorderType)l_borderColor {
  id borderColorNumberValue = objc_getAssociatedObject(self, &l_borderColor_key);
  if ( borderColorNumberValue ) {
    return [borderColorNumberValue integerValue];
  }
  return SLDSColorBorder;
}
/**
 Set backgroundColor with `SLDSColorBgType`, all subclass of UIView can use it.
 */
static char l_backgroundColor_key;

- (void)setL_backgroundColor:(SLDSColorBgType)l_backgroundColor {
  objc_setAssociatedObject(self, &l_backgroundColor_key, @(l_backgroundColor), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  self.backgroundColor = [UIColor sldsBackgroundColor:l_backgroundColor];
}

- (SLDSColorBgType)l_backgroundColor {
  id bgColorNumberValue = objc_getAssociatedObject(self, &l_backgroundColor_key);
  if ( bgColorNumberValue ) {
    return [bgColorNumberValue integerValue];
  }
  return SLDSColorBackground;
}
/**
 Set tintColor with `SLDSColorBgType`, all subclass of UIView can use it.
 */
static char l_tintColor_key;

- (void)setL_tintColor:(SLDSColorBgType)l_tintColor {
  objc_setAssociatedObject(self, &l_tintColor_key, @(l_tintColor), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  self.tintColor = [UIColor sldsBackgroundColor:l_tintColor];
}

-(SLDSColorBgType)l_tintColor {
  id tintColorNumberValue = objc_getAssociatedObject(self, &l_tintColor_key);
  if ( tintColorNumberValue ) {
    return [tintColorNumberValue integerValue];
  }
  return SLDSColorBackground;
}

#pragma mark - Subclass within text
/**
 Set textColor with `SLDSColorTextType`, which UI component within text.
 */
static char l_textColor_key;

- (void)setL_textColor:(SLDSColorTextType)l_textColor {
  objc_setAssociatedObject(self, &l_textColor_key, @(l_textColor), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  [self updateTextAttributes];
}

-(SLDSColorTextType)l_textColor {
  id textColorNumberValue = objc_getAssociatedObject(self, &l_textColor_key);
  if ( textColorNumberValue ) {
    return [textColorNumberValue integerValue];
  }
  return SLDSColorTextActionLabel;
}
/**
 FontWeight:
 0: lightFont
 1: regularFont
 2: strongFont
 Default is regularFont
 */
static char l_fontWeight_key;

- (void)setL_fontWeight:(NSInteger)l_fontWeight {
  objc_setAssociatedObject(self, &l_fontWeight_key, @(l_fontWeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  [self updateTextAttributes];
}

- (NSInteger)l_fontWeight {
  id fontWeightNumberValue = objc_getAssociatedObject(self, &l_fontWeight_key);
  if ( fontWeightNumberValue ) {
    return [fontWeightNumberValue integerValue];
  }
  return 1;
}
/**
 Set fontSize with `SLDSFontSizeType`, which UI component within text.
 Font is used `Lightness Font`, if u wan't to custom this Font, don't use this method.
 */
static char l_fontSize_key;

- (void)setL_fontSize:(SLDSFontSizeType)l_fontSize {
  objc_setAssociatedObject(self, &l_fontSize_key, @(l_fontSize), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  [self updateTextAttributes];
}

-(SLDSFontSizeType)l_fontSize {
  id fontSizeNumberValue = objc_getAssociatedObject(self, &l_fontSize_key);
  if ( fontSizeNumberValue ) {
    return [fontSizeNumberValue integerValue];
  }
  return SLDSFontSizeSmall;
}

#pragma mark - property that bar used only
/**
 Set tintColor with `SLDSColorBgType`, all subclass of UIView can use it.
 */
static char l_barTintColor;

- (void)setL_barTintColor:(SLDSColorBgType)l_barTintColor {
  objc_setAssociatedObject(self, &l_barTintColor, @(l_barTintColor), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  if ( equalClass([self class], [UINavigationBar class]) ) {
    UINavigationBar *barRef = self;
    barRef.barTintColor = [UIColor sldsBackgroundColor:l_barTintColor];
  }
  if ( equalClass([self class], [UITabBar class]) ) {
    UITabBar *barRef = self;
    barRef.barTintColor = [UIColor sldsBackgroundColor:l_barTintColor];
  }
  if ( equalClass([self class], [UIToolbar class]) ) {
    UIToolbar *barRef = self;
    barRef.barTintColor = [UIColor sldsBackgroundColor:l_barTintColor];
  }
  if ( equalClass([self class], [UISearchBar class]) ) {
    UISearchBar *barRef = self;
    barRef.barTintColor = [UIColor sldsBackgroundColor:l_barTintColor];
  }
}

- (SLDSColorBgType)l_barTintColor {
  id barTintColorNumberValue = objc_getAssociatedObject(self, &l_barTintColor);
  if ( barTintColorNumberValue ) {
    return [barTintColorNumberValue integerValue];
  }
  return SLDSColorBackground;
}

#pragma mark - property that used for attributeText, attributeTitle properties.
/**
 Only used for UILabel.attributeText, UITextField.attributedText, UITextView.attributedText, UIButton.attributeTitle UISegmentControl.attributes for normal state.
 \param range, Attribute want set ranges.
 */
- (void) updateAttributeWithColor: (SLDSColorTextType)textColorType
                       fontWeight: (NSInteger)weight
                         fontSize: (CGFloat)size
                          inRange: (NSRange)range {
  UIColor *textColor = textColorForType(textColorType);
  UIFont *textFont = fontForWeightAndSize(weight, size);
  
  if ( equalClass([self class], [UILabel class]) ) {
    UILabel *labelRef = self;
    if ( labelRef.attributedText ) {
      labelRef.attributedText = mStringFactory(labelRef.attributedText, textColor, textFont, range);
    }
  }
  if ( equalClass([self class], [UITextField class]) ) {
    UITextField *fieldRef = self;
    if ( fieldRef.attributedText ) {
      fieldRef.attributedText = mStringFactory(fieldRef.attributedText, textColor, textFont, range);
    }
  }
  if ( equalClass([self class], [UITextView class]) ) {
    UITextView *textViewRef = self;
    if ( textViewRef.attributedText ) {
      textViewRef.attributedText = mStringFactory(textViewRef.attributedText, textColor, textFont, range);
    }
  }
  if ( equalClass([self class], [UIButton class]) ) {
    UIButton *buttonRef = self;
    if ( buttonRef.currentAttributedTitle ) {
      [buttonRef setAttributedTitle:mStringFactory(buttonRef.currentAttributedTitle, textColor, textFont, range) forState:UIControlStateNormal];
    }
  }
  if ( equalClass([self class], [UISegmentedControl class]) ) {
    UISegmentedControl *controlRef = self;
    NSMutableDictionary *settedAttributes = [[controlRef titleTextAttributesForState:UIControlStateNormal] mutableCopy];
    if ( settedAttributes ) {
      [settedAttributes setObject:textColor forKey:NSForegroundColorAttributeName];
      [settedAttributes setObject:textFont forKey:NSFontAttributeName];
      [controlRef setTitleTextAttributes:settedAttributes forState:UIControlStateNormal];
    }
  }
}
/**
 Only used for UIButton.attributeTitle UISegmentControl.attributes for state.
 \param range, Attribute want set ranges.
 \param state, Attribute state
 */
- (void) updateAttributeWithColor: (SLDSColorTextType)textColorType
                       fontWeight: (NSInteger)weight
                         fontSize: (CGFloat)size
                          inRange: (NSRange)range
                         forState: (UIControlState)state {
  UIColor *textColor = textColorForType(textColorType);
  UIFont *textFont = fontForWeightAndSize(weight, size);
  
  if ( equalClass([self class], [UIButton class]) ) {
    UIButton *buttonRef = self;
    if ( buttonRef.currentAttributedTitle ) {
      [buttonRef setAttributedTitle:mStringFactory(buttonRef.currentAttributedTitle, textColor, textFont, range) forState:state];
    }
  }
  if ( equalClass([self class], [UISegmentedControl class]) ) {
    UISegmentedControl *controlRef = self;
    NSMutableDictionary *settedAttributes = [[controlRef titleTextAttributesForState:state] mutableCopy];
    if ( settedAttributes ) {
      [settedAttributes setObject:textColor forKey:NSForegroundColorAttributeName];
      [settedAttributes setObject:textFont forKey:NSFontAttributeName];
      [controlRef setTitleTextAttributes:settedAttributes forState:state];
    }
  }
}

/**
 Config text color and font
 */
- (void)updateTextAttributes {
  UIColor *textColor = textColorForType(self.l_textColor);
  UIFont *textFont = fontForWeightAndSize(self.l_fontWeight, self.l_fontSize);
  // UIView SubClass with text
  if ( equalClass([self class], [UILabel class]) ) {
    UILabel *labelRef = self;
    if ( labelRef.text ) {
      labelRef.textColor = textColor;
      labelRef.font = textFont;
    }
  }
  if ( equalClass([self class], [UITextField class]) ) {
    UITextField *fieldRef = self;
    fieldRef.textColor = textColor;
    fieldRef.font = textFont;
  }
  if ( equalClass([self class], [UITextView class]) ) {
    UITextView *textViewRef = self;
    textViewRef.textColor = textColor;
    textViewRef.font = textFont;
  }
  if ( equalClass([self class], [UINavigationBar class]) ) {
    UINavigationBar *barRef = self;
    NSMutableDictionary *settedAttribute = [barRef.titleTextAttributes mutableCopy];
    if ( settedAttribute ) {
      [settedAttribute setObject:textColor forKey:NSForegroundColorAttributeName];
      [settedAttribute setObject:textFont forKey:NSFontAttributeName];
      [barRef setTitleTextAttributes:settedAttribute];
    }
  }
  // UIControl with text prop
  if ( equalClass([self class], [UIButton class]) ) {
    UIButton *buttonRef = self;
    [buttonRef setTitleColor:textColor forState:UIControlStateNormal];
    buttonRef.titleLabel.font = textFont;
  }
}

#pragma mark - inline methods

static inline NSMutableAttributedString *mStringFactory(NSAttributedString *originAttributeString, UIColor *textColor, UIFont *textFont, NSRange inRange) {
  NSMutableAttributedString *mAttributeString = [originAttributeString mutableCopy];
  [mAttributeString setAttributes:@{
                                   NSFontAttributeName: textFont,
                                   NSForegroundColorAttributeName: textColor
                                   } range:inRange];
  return mAttributeString;
}

static inline UIFont *fontForWeightAndSize(NSInteger weight, SLDSFontSizeType size) {
  switch (weight) {
    case 0: {
      return [UIFont sldsFontLightWithSize:size];
      break;
    }
    case 1: {
      return [UIFont sldsFontRegularWithSize:size];
      break;
    }
    case 2: {
      return [UIFont sldsFontStrongWithSize:size];
      break;
    }
  }
  return [UIFont sldsFontRegularWithSize:size];
}

static inline UIColor *textColorForType(SLDSColorTextType type) {
  return [UIColor sldsColorText:type];
}

static inline BOOL equalClass(Class ols, Class cls) {
  return [ols isSubclassOfClass:cls];
}

#pragma mark - Get custom icons
/**
 Get custom icon with `SLDSIconActionType`, you can find Size prop in `SLDSSizing.h`.
 */
+ (UIImage *)getIconWithType: (SLDSIconActionType) iconType
                    withSize: (int) size {
  return [UIImage sldsIconCustom:iconType withSize:size];
}

#pragma mark - Get standard icons
/**
 Get standard icon with `SLDSIconActionType`, you can find Size prop in `SLDSSizing.h`.
 */
+ (UIImage *)getStandardIconWithType: (SLDSIconStandardType) iconType
                            withSize: (int) size {
  return [UIImage sldsIconStandard:iconType withSize:size];
}

#pragma mark - Get utility icons
/**
 Get utility icon with `SLDSIconActionType`, you can find Size prop in `SLDSSizing.h`.
 */
+ (UIImage *)getUtilityIconWithType: (SLDSIconUtilType) iconType
                           withSize: (int) size {
  return [UIImage sldsIconUtility:iconType withSize:size];
}

#pragma mark - draw rect method

@end
