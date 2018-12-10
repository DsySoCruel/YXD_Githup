//
//  YXDSearchViewBar.m
//  YXDApp
//
//  Created by daishaoyang on 2018/5/7.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import "YXDSearchViewBar.h"


@interface YXDSearchViewBar()<UITextFieldDelegate> {
    NSString *_placeholder;
}
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UIImageView *searchView;
@property (strong, nonatomic) UITextField *textView;

@property (nonatomic, copy) void (^searchBlock)(UITextField *, NSRange, NSString *);
@end


@implementation YXDSearchViewBar

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self setupLayout];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupUI];
        [self setupLayout];
    }
    return self;
}

- (id)init {
    return [self initWithFrame:CGRectZero];
}

- (void)setupUI {
    // Setup defaults
    [self setBackgroundColor:[UIColor clearColor]];
    _placeholder = @"";
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.cornerRadius = 2;
    self.contentView.layer.masksToBounds = YES;
    [self addSubview:self.contentView];
    
    
    
    self.searchView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.searchView];
    
    
    self.textView = [[UITextField alloc] init];
    //[self.textView becomeFirstResponder];
    self.textView.returnKeyType = UIReturnKeySearch;
    self.textView.textColor = RGB(0x1A192B);
    self.textView.font = LPFFONT(14);
    self.textView.delegate = self;
    [self.contentView addSubview:self.textView];
    
}
- (void)setupLayout {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.top.offset = 5;
        make.right.offset = -10;
        make.bottom.offset = -5;
    }];
    
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.centerY.equalTo(self.contentView);
    }];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.searchView.mas_right).offset = 5;
        make.top.bottom.right.equalTo(self.contentView);
    }];
}

- (void)cleanText {
    self.textView.text = @"";
}

- (void)setPlaceholder:(NSString *)placeholder {
    self.textView.placeholder = placeholder;
    [self.textView setValue:RGB(0x8E8CA7) forKeyPath:@"_placeholderLabel.textColor"];
    
}
- (void)setText:(NSString *)text {
    _text = text;
}

- (void)setSearchImage:(UIImage *)searchImage {
    self.searchView.image = searchImage;
}
- (void)resignFirstResponder{
    [self.textView resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"\n"]) {
        if (self.searchBlock) {
            self.searchBlock(textField, range, string);
        }
        self.text = string;
        [self.textView resignFirstResponder];
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    if (self.textView == textField) {
        if (self.searchBlock) {
            self.searchBlock(textField, range, toBeString);
        }
        self.text = toBeString;
    }
    return YES;
}
- (void)searchShouldChangeText:(void (^)(UITextField *, NSRange, NSString *))block {
    self.searchBlock = block;
}

@end
