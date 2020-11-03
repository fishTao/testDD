//
//  ViewController.m
//  demo
//
//  Created by wutt on 2020/11/2.
//

#import "ViewController.h"
#include <sys/param.h>
#include <sys/mount.h>

@interface ViewController ()
@property (nonatomic ,retain)UIButton *leftBtn;
@property (nonatomic ,retain)UIButton *rightBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
    self.leftBtn.backgroundColor = [UIColor brownColor];
    [self.leftBtn setTitle:@"开启屏幕常亮" forState:UIControlStateNormal];
    [self.leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.leftBtn];
    
    self.rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 200, 50)];
    self.rightBtn.backgroundColor = [UIColor brownColor];
    [self.rightBtn setTitle:@"关闭屏幕常亮" forState:UIControlStateNormal];
    [self.leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.rightBtn];
//    [self aaa];
//    [self bbb];
//    [self ccc];
}


-(void)leftClick{
    [self keepScreenOn:YES];
}
-(void)rightClick{
    [self keepScreenOn:NO];
}

-(void) keepScreenOn:(BOOL)isKeepScreen{
    if (isKeepScreen){
        NSLog(@"===已开启屏幕常亮===");
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"已开启屏幕常亮" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        [UIApplication sharedApplication].idleTimerDisabled = YES;
    }else{
        NSLog(@"===已关闭屏幕常亮===");
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"已关闭屏幕常亮" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        [UIApplication sharedApplication].idleTimerDisabled = NO;
    }
}


-(void)aaa{
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0) {
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_bavail);
    }
    NSString *str = [NSString stringWithFormat:@"%lld",freeSpace];
    NSLog(@"===设备剩余空间为===3>%@",str);
}

-(void)bbb{
    float freesize = 0.0;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    if (dictionary)
    {
        NSNumber *_free = [dictionary objectForKey:NSFileSystemFreeSize];
        freesize = [_free unsignedLongLongValue]*1.0;
        NSString *freesizeStr = [NSString stringWithFormat:@"%.2f",freesize];
        NSLog(@"===设备剩余空间为===2>%@",freesizeStr);
    } else{
        
        NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %ld", [error domain], (long)[error code]);
    }
}

- (void)ccc{
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:NSTemporaryDirectory()];
    if (@available(iOS 11.0, *)) {
        NSDictionary *results = [fileURL resourceValuesForKeys:@[NSURLVolumeAvailableCapacityForImportantUsageKey] error:nil];
        NSString *str = [NSString stringWithFormat:@"%@",results[NSURLVolumeAvailableCapacityForImportantUsageKey]];
//        NSLog(@"===33333-剩余空间为===>%.2f M",[str floatValue]/1000/1000);
        NSLog(@"===33333-剩余空间为===>%f",[str floatValue]);
    } else {
        NSLog(@"===EERROORRRR===>");
    }
    // 这里拿到的值的单位是bytes，iOS11是这样算的1000MB = 1，1000进制算的
    // bytes->KB->MB->G

}
@end
