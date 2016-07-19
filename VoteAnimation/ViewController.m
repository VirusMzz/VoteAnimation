//
//  ViewController.m
//  VoteAnimation
//
//  Created by 孙砚戈 on 7/19/16.
//  Copyright © 2016 孙砚戈. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong)UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn.frame = CGRectMake(0, 0, 50, 50);
    [self.btn setImage:[UIImage imageNamed:@"praiseBgNew"] forState:UIControlStateNormal];
    [self.btn setImage:[UIImage imageNamed:@"praiseBgNew"] forState:UIControlStateHighlighted];
    self.btn.center = self.view.center;
    [self.btn addTarget:self action:@selector(voteForLiveShow) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

/**
 *  点击事件
 */
- (void)voteForLiveShow{

    //执行动画
    [self voteAnimation];
}

/**
 *  voteAnimation
 */
- (void)voteAnimation{
    
    UIImage *heartImg = [UIImage imageNamed:[self randomImageNum]];
    UIImageView *heartView = [[UIImageView alloc]initWithImage:heartImg];
    
    heartView.center = CGPointMake(-5000, -5000);
    [self.view addSubview:heartView];
    CAAnimationGroup *group = [self groupAnimation];
    
    //添加动画
    [heartView.layer addAnimation:group forKey:@"wendingding"];
    
}

/**
 *  随机图片
 */
- (NSString *)randomImageNum{

    int randomNum = arc4random() %4;
    
    switch (randomNum) {
        case 0:
            return @"bHeart";
            break;
        case 1:
            return @"gHeart";
            break;
        case 2:
            return @"rHeart";
            break;
        case 3:
            return @"yHeart";
            break;
            
        default:
            return nil;
            break;
    }
}

/**
 *  组合动画
 */
- (CAAnimationGroup *)groupAnimation{

    CAAnimationGroup *group = [[CAAnimationGroup alloc]init];
    group.duration = 2.0;
    group.repeatCount = 1;
    CABasicAnimation *scaleAnimation = [self scaleAnimation];
    CABasicAnimation *alphaAnimation = [self alphaAnimation];
    CAKeyframeAnimation *keyPath = [self positionAnimation];

    group.animations = @[scaleAnimation, keyPath, alphaAnimation];
    group.delegate = self;
    return group;
}

/**
 *  拉伸动画
 */
- (CABasicAnimation *)scaleAnimation{

    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    scale.duration = 0.5;
    scale.removedOnCompletion = false;
    
    scale.fromValue = @(0.1);
    scale.toValue = @(1);
    
    return scale;
}

/**
 *  透明动画
 */
- (CABasicAnimation *)alphaAnimation{

    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    
    alphaAnimation.duration = 1.5;
    alphaAnimation.removedOnCompletion = false;

    alphaAnimation.fromValue = @1.0;
    alphaAnimation.toValue = @0.1;
    CAMediaTimingFunction *timing = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    alphaAnimation.timingFunction = timing;
    alphaAnimation.beginTime = 0.5;

    return alphaAnimation;
}

/**
 *  位置动画
 */
- (CAKeyframeAnimation *)positionAnimation{

    CAKeyframeAnimation *keyAnima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    CGMutablePathRef path = CGPathCreateMutable();
    //设置一个圆的路径
    //    CGPathAddEllipseInRect(path, NULL, CGRectMake(150, 100, 100, 100));
    
    CGPathMoveToPoint(path, nil, self.view.frame.size.width / 2 , self.view.frame.size.height / 2 - 25);
    int controlX = ((arc4random() % (100 + 1))) - 50;
    int controlY = ((arc4random() % (130 + 1))) + 50;
    int entX = ((arc4random() % (100 + 1))) - 50;
    
    CGPathAddQuadCurveToPoint(path, nil, (CGFloat)(200 - controlX), (CGFloat)(200 - controlY), (CGFloat)(200 + entX), 200 - 260);
    
    keyAnima.path=path;
    //有create就一定要有release, ARC自动管理
    //        CGPathRelease(path);
    //1.2设置动画执行完毕后，不删除动画
    keyAnima.removedOnCompletion = false;
    //1.3设置保存动画的最新状态
    keyAnima.fillMode=kCAFillModeForwards;
    //1.4设置动画执行的时间
    keyAnima.duration=2.0;
    //1.5设置动画的节奏
    CAMediaTimingFunction *timing = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    keyAnima.timingFunction = timing;
    
    return keyAnima;
}


@end
