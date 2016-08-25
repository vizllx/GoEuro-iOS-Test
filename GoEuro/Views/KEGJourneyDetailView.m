//
//  KEGJourneyDetailView.m
//  GoEuro
//
//  Created by Kevin Elorza on 8/25/16.
//  Copyright © 2016 Kevin Elorza. All rights reserved.
//

#import "KEGJourneyDetailView.h"
#import "GoEuro-Swift.h"
#import "KEGLocalizable.h"

#define KEGDetailPadding 20

@interface KEGJourneyDetailView()

@property (strong, nonatomic) NSString *journeyIcon;

@end

@implementation KEGJourneyDetailView

- (instancetype)initWithJourneyIcon:(NSString *)journeyIcon {
    if (self = [super initWithFrame:CGRectZero]) {
        self.journeyIcon = journeyIcon;
        [self setupView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize maxSize = self.bounds.size;
    maxSize = CGSizeMake(maxSize.width - (KEGDetailPadding * 2), maxSize.height - (KEGDetailPadding * 2));
    
    
    self.contentLabel.frame = CGRectMake(KEGDetailPadding, self.boundsMiddle.y - self.contentLabel.boundsMiddle.y, maxSize.width, self.contentLabel.bounds.size.width);
    
}

- (void)setupView {
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.contentLabel];
    
    NSString *content = [NSString stringWithFormat:@"%@\n%@", self.journeyIcon, [KEGLocalizable localizedString:LocalizableIdentifierNotImplemented]];
    
    
    UIFont *font = [UIFont goEuroFont:GoEuroFontBold size:25];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = font.lineHeight * 1.5;
    style.alignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *contentString = [[NSMutableAttributedString alloc] initWithString:content attributes:@{ NSFontAttributeName : font, NSForegroundColorAttributeName : [UIColor grayColor], NSParagraphStyleAttributeName : style }];
    
    [contentString addAttribute:NSFontAttributeName value:[UIFont goEuroFont:GoEuroFontBold size:35] range:[content rangeOfString:self.journeyIcon]];
    
    self.contentLabel.attributedText = contentString;
    
    [self.contentLabel sizeToFit];
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

@end
