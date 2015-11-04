//
//  MaxDoraemon.m
//  Doraemon
//
//  Created by golven on 15/10/29.
//  Copyright © 2015年 Max. All rights reserved.
//

#import "MaxDoraemon.h"

#define LINE_WIDTH 3.0//线宽
//脑袋的颜色
#define HEAD_COLOR [UIColor colorWithRed:29.0f/255.f green:159.f/255.f blue:230.f/255.f alpha:1]

@interface MaxDoraemon()
@property (nonatomic, assign) CGFloat width;
@end

@implementation MaxDoraemon

- (void)drawRect:(CGRect)rect {
    [self drawDoraemonInRect:rect wihtContext:UIGraphicsGetCurrentContext()];
}

- (void)drawDoraemonInRect:(CGRect)rect wihtContext:(CGContextRef)context {
    CGContextSetLineWidth(context, LINE_WIDTH);//设置线宽为3
    CGContextSetFillColorWithColor(context, HEAD_COLOR.CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    //画一个圆弧
    /*
     http://blog.sina.com.cn/s/blog_9e8867eb0102v3zr.html
     博客中解释的很清楚
     */
    CGContextAddArc(context, self.width/2, self.width/2, self.width/2-50, 54*(M_PI/180), -215*(M_PI/180), 1);
    CGContextClosePath(context);//把终点和起点连接起来
    /*
     //暂时只使用过下面三个
     kCGPathFill            //填充模式，不显示边线
     kCGPathStroke,         //只显示边线
     kCGPathFillStroke,     //既显示边线也填充颜色
     */
    CGContextDrawPath(context, kCGPathFillStroke);//根据前面的设置开始画画
    
    //画脖子
    //画黑色部分
    CGContextSetLineWidth(context, 20);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    //起点坐标
    CGFloat offset = 5;//稍微长一点，显得好看一些
    CGFloat start_x = self.width/2 - cos(35*(M_PI/180))*(self.width/2-50)-offset;
    CGFloat start_y = self.width/2 + sin(35*(M_PI/180))*(self.width/2-50)+offset;
    //终点坐标
    CGFloat end_x = self.width/2 + cos(54*(M_PI/180))*(self.width/2-50)+offset;
    CGFloat end_y = self.width/2 + sin(54*(M_PI/180))*(self.width/2-50)+offset;
    //哪个是起点哪个是终点无所谓
    //只要确定两个点的位置就行了
    //35和54根据圆弧的角度计算出来的
    CGContextMoveToPoint(context, start_x, start_y);
    CGContextAddLineToPoint(context, end_x, end_y);
    CGContextStrokePath(context);
    //画红色部分
    CGContextSetLineWidth(context, 13);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextMoveToPoint(context, start_x+1, start_y+0.5);
    CGContextAddLineToPoint(context, end_x-1, end_y+0.5);
    CGContextStrokePath(context);
    
    
    //内部轮廓
    //两个控制点试出来的，尼玛，我也不晓得咋计算啊
    CGContextSetLineWidth(context, 2);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextMoveToPoint(context, start_x+offset, start_y-offset-3);
    CGContextAddCurveToPoint(context, 30.5-75, 44, 335.5+100, 68, end_x-15, end_y-offset-5);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGContextSaveGState(context);
    //左眼
    //尼玛，坐标都是凭感觉试出来的
    CGContextRotateCTM(context, 20*(M_PI/180));//倾斜
    CGContextTranslateCTM(context, 45, -75);//位移
    CGContextAddEllipseInRect(context, CGRectMake(107, 66.5, 55+10, 144-65.5+10));
    CGContextDrawPath(context, kCGPathFillStroke);
    
    //右眼
    //尼玛，坐标都是凭感觉试出来的
    CGContextRotateCTM(context, 10*(M_PI/180));//倾斜
    CGContextTranslateCTM(context, 42, -35);//位移
    CGContextAddEllipseInRect(context, CGRectMake(147, 66.5, 55+10-3, 144-65.5-3));
    CGContextDrawPath(context, kCGPathFillStroke);
    
    //左右眼珠子
    //再次声明，坐标都是试出来的，我不知道咋计算，还在学习中，后面的代码都是试出来的
    CGContextSetLineWidth(context, 5);
    CGContextAddArc(context, 110, 110, 25, 10*(M_PI/180), 60*(M_PI/180), 0);
    CGContextStrokePath(context);
    CGContextAddArc(context, 180, 90, 25, 75*(M_PI/180), 125*(M_PI/180), 0);
    CGContextStrokePath(context);
    
    //鼻子
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextAddArc(context, 145, 160, 25, 0, 180, 0);
    CGContextDrawPath(context, kCGPathFillStroke);
    //鼻子上那个白点
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextAddArc(context, 135, 153, 10, 0, 180, 0);
    CGContextDrawPath(context, kCGPathFill);

    CGContextRestoreGState(context);
    
    //嘴巴
    /*
     CGContextRotateCTM和CGContextTranslateCTM会最后面的有影响
     所以在用到这两个函数的时候需要下面的两函数把他们包起来
     这样在Restore之后就不会对后面的代码产生影响
     CGContextSaveGState(context);
     CGContextRestoreGState(context);
     */
    CGContextMoveToPoint(context, 165, 173);
    CGContextAddQuadCurveToPoint(context, 165, 186.5, 154.5, 208);
    CGContextAddCurveToPoint(context, 127.5, 174, 101, 221.5, 148, 230.5);
    CGContextAddCurveToPoint(context, 117, 230.5, 127, 256, 150.5, 246.5);
    CGContextStrokePath(context);
    //这嘴好难看，就这样吧！反正我也没搞懂贝塞尔曲线到底咋回事
    
    //左边的三根胡须
    CGContextMoveToPoint(context, 125, 170);
    CGContextAddQuadCurveToPoint(context, 100, 150, 80, 150);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, 120, 190);
    CGContextAddQuadCurveToPoint(context, 100, 180, 70, 180);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, 110, 210);
    CGContextAddQuadCurveToPoint(context, 100, 210, 70, 220);
    CGContextStrokePath(context);
    
    //右边的三根胡须
    CGContextMoveToPoint(context, 200, 180);
    CGContextAddQuadCurveToPoint(context, 225, 175, 275, 180);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, 200, 205);
    CGContextAddQuadCurveToPoint(context, 245, 210, 280, 230);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, 200, 230);
    CGContextAddQuadCurveToPoint(context, 245, 250, 265, 275);
    CGContextStrokePath(context);
}

- (CGFloat)width {
    return self.frame.size.width;
}

@end
