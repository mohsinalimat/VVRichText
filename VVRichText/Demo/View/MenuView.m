
#import "MenuView.h"
#import "VVRichText.h"

@interface MenuView ()

@property (nonatomic,assign) BOOL show;

@end

@implementation MenuView


#pragma mark - LifeCycle
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.show = NO;
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.likeButton];
        [self addSubview:self.commentButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setNeedsDisplay];
    self.likeButton.frame = CGRectMake(0, 0, 80, self.bounds.size.height);
    self.commentButton.frame = CGRectMake(80, 0, 80, self.bounds.size.height);
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    UIBezierPath* beizerPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:5.0f];
    [VV_COLOR(76, 81, 84, 0.95) setFill];
    [beizerPath fill];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, rect.size.width/2, 5.0f);
    CGContextAddLineToPoint(context, rect.size.width/2, rect.size.height - 5.0f);
    CGContextSetLineWidth(context, 1.0f);
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextStrokePath(context);
}


#pragma mark - Actions
- (void)clickedMenu {
    if (self.show) {
        [self menuHide];
    } else {
        [self menuShow];
    }
}


- (void)menuShow {
    [UIView animateWithDuration:0.2f
                          delay:0.0f
         usingSpringWithDamping:0.7
          initialSpringVelocity:0.0f
                        options:0
                     animations:^{
                         self.frame = CGRectMake(self.frame.origin.x - 160,
                                                 self.frame.origin.y,
                                                 160,
                                                 34.0f);
                     } completion:^(BOOL finished) {
                         self.show = YES;
                     }];
    
}

- (void)menuHide {
    if (!self.show) {
        return;
    }
    
    [UIView animateWithDuration:0.3f
                          delay:0.0f
         usingSpringWithDamping:0.7f
          initialSpringVelocity:0.0f
                        options:0
                     animations:^{
                         self.frame = CGRectMake(self.frame.origin.x + 160,
                                                 self.frame.origin.y,
                                                 0.0f,
                                                 34.0f);
                     } completion:^(BOOL finished) {
                         self.frame = CGRectMake(self.frame.origin.x,
                                                 self.frame.origin.y,
                                                 0.0f,
                                                 34.0f);
                         self.show = NO;
                     }];
}

#pragma mark - Getter & Setter

- (void)setStatusModel:(StatusModel *)statusModel {
    if (_statusModel != statusModel) {
        _statusModel = statusModel;
    }
    if (self.statusModel.isLike) {
        [_likeButton setTitle:@" 取消" forState:UIControlStateNormal];
    }
    else {
        [_likeButton setTitle:@"  赞" forState:UIControlStateNormal];
    }
}

- (LikeButton *)likeButton {
    if (_likeButton) {
        return _likeButton;
    }
    _likeButton = [LikeButton buttonWithType:UIButtonTypeCustom];
    [_likeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_likeButton setImage:[UIImage imageNamed:@"likewhite.png"] forState:UIControlStateNormal];
    [_likeButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    return _likeButton;
}

- (UIButton *)commentButton {
    if (_commentButton) {
        return _commentButton;
    }
    
    _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_commentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_commentButton setTitle:@" 评论" forState:UIControlStateNormal];
    [_commentButton setImage:[UIImage imageNamed:@"c.png"] forState:UIControlStateNormal];
    [_commentButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    return _commentButton;
}
@end
