//
//  ViewController.m
//  rzImageDetection
//
//  Created by Robert Zimmelman on 10/24/15.
//  Copyright © 2015 Robert Zimmelman. All rights reserved.
//

#import "ViewController.h"
#import "CoreImage/CoreImage.h"
#import "ImageIO/ImageIO.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *myImageView;
@end

@implementation ViewController

@synthesize myImageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CIFilter *myAztecCodeGenerator = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    CIContext *myAztecCodeGeneratorContext = [CIContext contextWithOptions:nil];
    NSString *myString = @"https://geo.itunes.apple.com/us/app/bouncy-bouncy-photo-chaos/id954147140?mt=8";
    NSData *stringData = [myString dataUsingEncoding:NSUTF8StringEncoding];
    [myAztecCodeGenerator setValue:stringData forKey:@"inputMessage"];
    [myAztecCodeGenerator setValue:@"L" forKey:@"inputCorrectionLevel"];
    CIImage *myResult = [myAztecCodeGenerator valueForKey:kCIOutputImageKey];
    CGImageRef ref = [myAztecCodeGeneratorContext createCGImage:myResult fromRect:myResult.extent];
    UIImage *myRefImage = [[UIImage alloc] initWithCGImage:ref];
    CGAffineTransform transform = CGAffineTransformMakeScale(10.0f, 10.0f); // Scale by 5 times along both dimensions
    CIImage *output = [myResult imageByApplyingTransform: transform];
    [myImageView setFrame:CGRectMake(10, 10, self.view.frame.size.width - 30, self.view.frame.size.height - 30)];
    [myImageView setImage: [UIImage imageWithCIImage:output]];
//    [myImageView setImage: myRefImage];

//    opts = @{ CIDetectorImageOrientation :
//                  [[myTempImage properties] valueForKey:kCGImagePropertyOrientation] }; // 4
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)myDetectFaces:(id)sender {
}

- (IBAction)myQuit:(id)sender {
    exit(0);
}

@end
