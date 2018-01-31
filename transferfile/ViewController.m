//
//  ViewController.m
//  transferfile
//
//  Created by 辛星(EX-XINXING001) on 2018/1/31.
//  Copyright © 2018年 辛星(EX-XINXING001). All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIDocumentInteractionControllerDelegate>
{
    
    
    NSString * fileName;
    NSString * suffix;
}

@property (nonatomic, strong) UIDocumentInteractionController *documentController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    fileName = @"1515467707";
    suffix = @"spx";
    
    
}


- (IBAction)copyFile:(id)sender {
    
    
   
    NSString* sourcePath = [[NSBundle mainBundle] pathForResource:fileName ofType:suffix];
    
    NSFileManager*fileManager =[NSFileManager defaultManager];
    NSError*error;
    NSArray*paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString*documentsDirectory =[paths objectAtIndex:0];
    NSString*destPath =[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",fileName,suffix]];
    [fileManager copyItemAtPath:sourcePath toPath:destPath error:&error];
    
    if (error) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:[error description] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else{
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"成功提示" message:@"拷贝成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    
    
    
}

- (IBAction)openByOtherApplication:(id)sender {
    
    NSString *cachePath = [[NSBundle mainBundle] pathForResource:fileName ofType:suffix];
    _documentController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:cachePath]];//_documentController必须为全局否则后面操作会引起崩溃。
    _documentController.delegate = self;
    [_documentController presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
