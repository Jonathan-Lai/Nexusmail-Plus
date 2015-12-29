//
//  NPMailTableViewCell.m
//  Nexusmail Plus
//
//  Created by Jonathan Lai on 2015-12-26.
//  Copyright © 2015 Hoi Fung Lai. All rights reserved.
//

#import "NPMailTableViewCell.h"
#import "NPDateFormatHelper.h"
#import "NPStyling.h"

#import <MailCore/MailCore.h>

static const NSInteger kSideMargin = 5;
static const NSInteger kLabelMargin = 2;

@interface NPMailTableViewCell()

@property (nonatomic, strong) UILabel *subjectLabel;
@property (nonatomic, strong) UILabel *emailOrNameLabel;
@property (nonatomic, strong) UILabel *dateLabel;

@end

@implementation NPMailTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _subjectLabel = [[UILabel alloc] init];
        _subjectLabel.font = [NPStyling smallBoldFont];
        _subjectLabel.textColor = [UIColor blackColor];
        _subjectLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_subjectLabel];
        
        _emailOrNameLabel = [[UILabel alloc] init];
        _emailOrNameLabel.font = [NPStyling mediumBoldFont];
        _emailOrNameLabel.textColor = [UIColor blackColor];
        _emailOrNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_emailOrNameLabel];
        
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = [NPStyling smallBoldFont];
        _dateLabel.textColor = [UIColor blueColor];
        _dateLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_dateLabel];
        
        [self _setContraints];
    }
    return self;
}

- (void)_setContraints {
    NSDictionary *views = NSDictionaryOfVariableBindings(_subjectLabel, _emailOrNameLabel, _dateLabel);
    NSDictionary *metrics = @{ @"kSideMargin" : @(kSideMargin),
                               @"kLabelMargin" : @(kLabelMargin) };
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(kSideMargin)-[_emailOrNameLabel]-(>=0)-[_dateLabel]-(kSideMargin)-|" options:0 metrics:metrics views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(kSideMargin)-[_subjectLabel]" options:0 metrics:metrics views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(kSideMargin)-[_emailOrNameLabel]-(kLabelMargin)-[_subjectLabel]" options:0 metrics:metrics views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(kSideMargin)-[_dateLabel]" options:0 metrics:metrics views:views]];
}

- (void)setMessage:(MCOAbstractMessage *)message {
    _subjectLabel.text = message.header.subject;
    _emailOrNameLabel.text = message.header.from.displayName;
    _dateLabel.text = [NPDateFormatHelper stringFromDate:message.header.date];
}

@end
