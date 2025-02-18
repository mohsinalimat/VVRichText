
#import "ArticleListTableViewCell.h"
#import "VVRichTextUtils.h"
#import "UIImageView+WebCache.h"
#import "VVRichTextDefine.h"

@interface ArticleListTableViewCell ()

@property (nonatomic,strong) UIImageView* coverImageView;

@end


@implementation ArticleListTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.coverImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.coverImageView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.coverImageView];
        self.textLabel.numberOfLines = 0;
        self.textLabel.font = [UIFont fontWithName:@"Heiti SC" size:15.0f];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.coverImageView.frame = CGRectMake(10, 10, 50, 50);
    self.textLabel.frame = CGRectMake(70.0f, 10.0f, VV_SCREEN_WIDTH - 80.0f, 50.0f);
}

- (void)setModel:(ArticleListModel *)model {
    if (_model != model) {
        _model = model;
    }
    NSString* urlString = [self.model.images firstObject];
    NSURL* URL = [NSURL URLWithString:urlString];
    [self.coverImageView sd_setImageWithURL:URL];
    self.textLabel.text = self.model.title;
}

@end
