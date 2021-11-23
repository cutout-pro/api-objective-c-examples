//
//  ViewController.m
//  api-oc-examples
//
//  Created by Eleven_Liu on 2021/8/23.
//

#import "ViewController.h"
#import "PKZNNetwork.h"

#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height

@interface ViewController ()
@property (nonatomic, strong) UIImageView *originalImage;
@property (nonatomic, strong) UIImageView *handleImage;
@property (nonatomic, strong) NSString *baseUrl;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.baseUrl = @"https://www.cutout.pro/api/v1";
    
    // Test object, general, avatar, portrait image
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test.jpeg" ofType:nil];
    UIImage *testImg = [UIImage imageWithContentsOfFile:path];
    
    self.originalImage = [[UIImageView alloc] init];
    self.originalImage.image = testImg;
    self.originalImage.frame = CGRectMake(0, 50, screenW, screenH/2-50-50);
    self.originalImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.originalImage];
    
    
    // Switch method names for different method calls
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, CGRectGetMaxY(self.originalImage.frame) + 10, 50, 30);
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:@"Cutout" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(universalReturnsBinary) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(70, CGRectGetMaxY(self.originalImage.frame) + 10, 100, 30);
    btn1.backgroundColor = [UIColor orangeColor];
    [btn1 setTitle:@"One-click beautification" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(beautifyReturnsBinary) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(180, CGRectGetMaxY(self.originalImage.frame) + 10, 70, 30);
    btn2.backgroundColor = [UIColor orangeColor];
    [btn2 setTitle:@"Animation" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(animeReturnsBinary) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(260, CGRectGetMaxY(self.originalImage.frame) + 10, 100, 30);
    btn3.backgroundColor = [UIColor orangeColor];
    [btn3 setTitle:@"Cartoon avatar" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(avatarCartoonReturnsBinary) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(10, CGRectGetMaxY(btn3.frame) + 10, 110, 30);
    btn4.backgroundColor = [UIColor orangeColor];
    [btn4 setTitle:@"Face becomes clear" forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(faceClearReturnsBinary) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    
    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn5.frame = CGRectMake(130, CGRectGetMaxY(btn3.frame) + 10, 90, 30);
    btn5.backgroundColor = [UIColor orangeColor];
    [btn5 setTitle:@"Photo coloring" forState:UIControlStateNormal];
    [btn5 addTarget:self action:@selector(photoColoringReturnsBase64) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn5];

    UIButton *btn6 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn6.frame = CGRectMake(230, CGRectGetMaxY(btn3.frame) + 10, 70, 30);
    btn6.backgroundColor = [UIColor orangeColor];
    [btn6 setTitle:@"ID photo" forState:UIControlStateNormal];
    [btn6 addTarget:self action:@selector(idPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self .view addSubview:btn6];

    UIButton *btn7 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn7.frame = CGRectMake(310, CGRectGetMaxY(btn3.frame) + 10, 90, 30);
    btn7.backgroundColor = [UIColor orangeColor];
    [btn7 setTitle:@"Picture repair" forState:UIControlStateNormal];
    [btn7 addTarget:self action:@selector(imageFix) forControlEvents:UIControlEventTouchUpInside];
    [self .view addSubview:btn7];
    
    UIButton *btn8 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn8.frame = CGRectMake(10, CGRectGetMaxY(btn7.frame) + 10, 70, 30);
    btn8.backgroundColor = [UIColor orangeColor];
    [btn8 setTitle:@"Stylization" forState:UIControlStateNormal];
    [btn8 addTarget:self action:@selector(styleTransfer) forControlEvents:UIControlEventTouchUpInside];
    [self .view addSubview:btn8];
    
    
    self.handleImage = [[UIImageView alloc] init];
    self.handleImage.frame = CGRectMake(0, CGRectGetMaxY(btn8.frame) + 20, screenW, screenH/2-50-150);
    self.handleImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.handleImage];
}

#pragma mark - Cutout
/**
 * Generic matting (return to binary file stream)
 */
- (void)universalReturnsBinary {
    //Set sample picture
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test.jpeg" ofType:nil];
    self.originalImage.image = [UIImage imageWithContentsOfFile:path];
    
    //Splicing request URL
    NSString *urlStr = [NSString stringWithFormat:@"%@/matting?mattingType=6", self.baseUrl];
    //Get image data
    NSURL *fileUrl = [NSBundle.mainBundle URLForResource:@"test" withExtension:@"jpeg"];
    NSData *data = [NSData dataWithContentsOfURL:fileUrl];
    
    //Whether to crop to the smallest non-transparent area (not required)
    BOOL crop = 0;
    //Fill background color (not required)
    NSString *bgColor = @"";
    NSDictionary *params = @{@"crop" : @(crop), @"bgcolor" : bgColor};
    [[PKZNNetwork shared] uploadFileWithUrlString:urlStr parameters:params data:data success:^(id  _Nonnull responseObject) {
        if (responseObject) {
            //Get the processed picture
            self.handleImage.image = responseObject;
        }
    } failure:^(NSError * _Nonnull error) {

    }];
}

/**
 * General matting (returns Base64 string)
 */
- (void)universalReturnsBase64 {
    //Set sample picture
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test.jpeg" ofType:nil];
    self.originalImage.image = [UIImage imageWithContentsOfFile:path];
    
    //Splicing request address
    NSString *urlStr = [NSString stringWithFormat:@"%@/matting2?mattingType=6", self.baseUrl];
    //Get image data
    NSURL *fileUrl = [NSBundle.mainBundle URLForResource:@"test" withExtension:@"jpeg"];
    NSData *data = [NSData dataWithContentsOfURL:fileUrl];
    
    //Whether to crop to the smallest non-transparent area (not required)
    //BOOL crop = 1;
    //Fill background color (not required)
    //NSString *bgColor = @"000000";
    //BOOL faceAnalysis = 0;
    NSDictionary *params = @{}; // @{@"crop" : @(crop), @"bgcolor" : bgColor};
    
    [[PKZNNetwork shared] uploadFileWithUrlString:urlStr parameters:params data:data success:^(id  _Nonnull responseObject) {
        if (responseObject && [[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqualToString:@"0"]) {
            NSData *imageData = [[NSData alloc] initWithBase64EncodedString:responseObject[@"data"][@"imageBase64"] options:0];
            self.handleImage.image = [UIImage imageWithData:imageData];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

/**
 * Universal matting (return Base64 string through image URL)
 */
- (void)universalByImageUrl {
    //Set sample picture
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test.jpeg" ofType:nil];
    self.originalImage.image = [UIImage imageWithContentsOfFile:path];
    
    //Splicing request address
    NSString *urlStr = [NSString stringWithFormat:@"%@/mattingByUrl", self.baseUrl];
    
    // Cutout type, 1: portrait, 2: object, 3: avatar, 4: one-click beautification, 6: general cutout, 11: cartoonization, 17: cartoon avatar, 18: face becomes clear, 19: photo coloring
    NSInteger mattingType = 6;
    
    NSString *imgUrl = @"https://c-ssl.duitang.com/uploads/item/201908/08/20190808151534_tdivh.thumb.1000_0.jpg";
    
    //Whether to crop to the smallest non-transparent area (not required)
    //BOOL crop = 1;
    //Fill background color (not required)
    //NSString *bgColor = @"000000";
    // Face detection point information (not required)
    //BOOL faceAnalysis = 0;
    
    NSDictionary *params = @{@"mattingType" : @(mattingType), @"url" : imgUrl};
        
    [[PKZNNetwork shared] getWithUrlString:urlStr parameters:params success:^(id  _Nonnull responseObject) {
        if (responseObject) {
            NSData *imageData = [[NSData alloc] initWithBase64EncodedString:responseObject[@"data"][@"imageBase64"] options:0];
            self.handleImage.image = [UIImage imageWithData:imageData];
        }
    } failure:^(NSError * _Nonnull error) {
    
    }];
}

#pragma mark -

/**
 * Portrait cutout (return to binary file stream)
 */
- (void)portraitReturnsBinary {
    //Set sample picture
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test.jpeg" ofType:nil];
    self.originalImage.image = [UIImage imageWithContentsOfFile:path];
    
    //Splicing request address
    NSString *urlStr = [NSString stringWithFormat:@"%@/matting", self.baseUrl];
    //Get image data
    NSURL *fileUrl = [NSBundle.mainBundle URLForResource:@"test" withExtension:@"jpeg"];
    NSData *data = [NSData dataWithContentsOfURL:fileUrl];
    
    //Whether to crop to the smallest non-transparent area (not required)
    //BOOL crop = 1;
    //Fill background color (not required)
    //NSString *bgColor = @"000000";
    NSDictionary *params = @{}; // @{@"crop" : @(crop), @"bgcolor" : bgColor};

    [[PKZNNetwork shared] uploadFileWithUrlString:urlStr parameters:params data:data success:^(id  _Nonnull responseObject) {
        if (responseObject) {
            self.handleImage.image = responseObject;
        }
    } failure:^(NSError * _Nonnull error) {

    }];
}

/**
 * Portrait cutout (returns Base64 string)
 */
- (void)portraitReturnsBase64 {
    //Set sample picture
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test.jpeg" ofType:nil];
    self.originalImage.image = [UIImage imageWithContentsOfFile:path];
    
    //Splicing request address
    NSString *urlStr = [NSString stringWithFormat:@"%@/matting2", self.baseUrl];
    //Get image data
    NSURL *fileUrl = [NSBundle.mainBundle URLForResource:@"test" withExtension:@"jpeg"];
    NSData *data = [NSData dataWithContentsOfURL:fileUrl];
    
    //Whether to crop to the smallest non-transparent area (not required)
    //BOOL crop = 1;
    //Fill background color (not required)
    //NSString *bgColor = @"000000";
    NSDictionary *params = @{}; // @{@"crop" : @(crop), @"bgcolor" : bgColor};

    [[PKZNNetwork shared] uploadFileWithUrlString:urlStr parameters:params data:data success:^(id  _Nonnull responseObject) {
        if (responseObject && [[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqualToString:@"0"]) {
            NSData *imageData = [[NSData alloc] initWithBase64EncodedString:responseObject[@"data"][@"imageBase64"] options:0];
            self.handleImage.image = [UIImage imageWithData:imageData];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark -

/**
 * Object matting (return to binary file stream)
 */
- (void)objectReturnsBinary {
    //Set sample picture
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test.jpeg" ofType:nil];
    self.originalImage.image = [UIImage imageWithContentsOfFile:path];
    
    //Splicing request address
    NSString *urlStr = [NSString stringWithFormat:@"%@/matting?mattingType=2", self.baseUrl];
    //Get image data
    NSURL *fileUrl = [NSBundle.mainBundle URLForResource:@"test" withExtension:@"jpeg"];
    NSData *data = [NSData dataWithContentsOfURL:fileUrl];
    
    //Whether to crop to the smallest non-transparent area (not required)
    //BOOL crop = 1;
    //Fill background color (not required)
    //NSString *bgColor = @"000000";
    NSDictionary *params = @{}; // @{@"crop" : @(crop), @"bgcolor" : bgColor};

    [[PKZNNetwork shared] uploadFileWithUrlString:urlStr parameters:params data:data success:^(id  _Nonnull responseObject) {
        if (responseObject) {
            self.handleImage.image = responseObject;
        }
    } failure:^(NSError * _Nonnull error) {

    }];
}

/**
 * Object matting (returns Base64 string)
 */
- (void)objectReturnsBase64 {
    //Set sample picture
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test.jpeg" ofType:nil];
    self.originalImage.image = [UIImage imageWithContentsOfFile:path];
    
    //Splicing request address
    NSString *urlStr = [NSString stringWithFormat:@"%@/matting2?mattingType=2", self.baseUrl];
    //Get image data
    NSURL *fileUrl = [NSBundle.mainBundle URLForResource:@"test" withExtension:@"jpeg"];
    NSData *data = [NSData dataWithContentsOfURL:fileUrl];
    
    //Whether to crop to the smallest non-transparent area (not required)
    //BOOL crop = 1;
    //Fill background color (not required)
    //NSString *bgColor = @"000000";
    NSDictionary *params = @{}; // @{@"crop" : @(crop), @"bgcolor" : bgColor};

    [[PKZNNetwork shared] uploadFileWithUrlString:urlStr parameters:params data:data success:^(id  _Nonnull responseObject) {
        if (responseObject && [[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqualToString:@"0"]) {
            NSData *imageData = [[NSData alloc] initWithBase64EncodedString:responseObject[@"data"][@"imageBase64"] options:0];
            self.handleImage.image = [UIImage imageWithData:imageData];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark -

/**
 * Avatar Cutout (Return to Binary File Stream)
 */
- (void)avatarReturnsBinary {
    //Set sample picture
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test.jpeg" ofType:nil];
    self.originalImage.image = [UIImage imageWithContentsOfFile:path];
    
    //Splicing request address
    NSString *urlStr = [NSString stringWithFormat:@"%@/matting?mattingType=3", self.baseUrl];
    //Get image data
    NSURL *fileUrl = [NSBundle.mainBundle URLForResource:@"test" withExtension:@"jpeg"];
    NSData *data = [NSData dataWithContentsOfURL:fileUrl];
    
    //Whether to crop to the smallest non-transparent area (not required)
    //BOOL crop = 1;
    //Fill background color (not required)
    //NSString *bgColor = @"000000";
    NSDictionary *params = @{}; // @{@"crop" : @(crop), @"bgcolor" : bgColor};

    [[PKZNNetwork shared] uploadFileWithUrlString:urlStr parameters:params data:data success:^(id  _Nonnull responseObject) {
        if (responseObject) {
            self.handleImage.image = responseObject;
        }
    } failure:^(NSError * _Nonnull error) {

    }];
}

/**
 * Avatar cutout (returns Base64 string)
 */
- (void)avatarReturnsBase64 {
    //Set sample picture
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test.jpeg" ofType:nil];
    self.originalImage.image = [UIImage imageWithContentsOfFile:path];
    
    //Splicing request address
    NSString *urlStr = [NSString stringWithFormat:@"%@/matting2?mattingType=3", self.baseUrl];
    //Get image data
    NSURL *fileUrl = [NSBundle.mainBundle URLForResource:@"test" withExtension:@"jpeg"];
    NSData *data = [NSData dataWithContentsOfURL:fileUrl];
    
    //Whether to crop to the smallest non-transparent area (not required)
    //BOOL crop = 1;
    //Fill background color (not required)
    //NSString *bgColor = @"000000";
    NSDictionary *params = @{}; // @{@"crop" : @(crop), @"bgcolor" : bgColor};

    [[PKZNNetwork shared] uploadFileWithUrlString:urlStr parameters:params data:data success:^(id  _Nonnull responseObject) {
        if (responseObject && [[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqualToString:@"0"]) {
            NSData *imageData = [[NSData alloc] initWithBase64EncodedString:responseObject[@"data"][@"imageBase64"] options:0];
            self.handleImage.image = [UIImage imageWithData:imageData];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}


#pragma mark - One-click beautification

/**
 * One-click beautification（Return binary file stream）
 */
- (void)beautifyReturnsBinary {
    //Set sample picture
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test.jpeg" ofType:nil];
    self.originalImage.image = [UIImage imageWithContentsOfFile:path];
    
    //Splicing request address
    NSString *urlStr = [NSString stringWithFormat:@"%@/matting?mattingType=4", self.baseUrl];
    //Get image data
    NSURL *fileUrl = [NSBundle.mainBundle URLForResource:@"test" withExtension:@"jpeg"];
    NSData *data = [NSData dataWithContentsOfURL:fileUrl];
    
    [[PKZNNetwork shared] uploadFileWithUrlString:urlStr parameters:@{} data:data success:^(id  _Nonnull responseObject) {
        if (responseObject) {
            self.handleImage.image = responseObject;
        }
    } failure:^(NSError * _Nonnull error) {

    }];
}

/**
 * One-click beautification (returns Base64 string)
 */
- (void)beautifyReturnsBase64 {
    //Set sample picture
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test.jpeg" ofType:nil];
    self.originalImage.image = [UIImage imageWithContentsOfFile:path];
    
    //Splicing request address
    NSString *urlStr = [NSString stringWithFormat:@"%@/matting2?mattingType=4", self.baseUrl];
    //Get image data
    NSURL *fileUrl = [NSBundle.mainBundle URLForResource:@"test" withExtension:@"jpeg"];
    NSData *data = [NSData dataWithContentsOfURL:fileUrl];
    
    [[PKZNNetwork shared] uploadFileWithUrlString:urlStr parameters:@{} data:data success:^(id  _Nonnull responseObject) {
        if (responseObject) {
            NSData *imageData = [[NSData alloc] initWithBase64EncodedString:responseObject[@"data"][@"imageBase64"] options:0];
            self.handleImage.image = [UIImage imageWithData:imageData];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark - Animation

/**
 * Animation (return to binary file stream)
 */
- (void)animeReturnsBinary {
    //Set sample picture
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test.jpeg" ofType:nil];
    self.originalImage.image = [UIImage imageWithContentsOfFile:path];
    
    //Splicing request address
    NSString *urlStr = [NSString stringWithFormat:@"%@/matting?mattingType=11", self.baseUrl];
    //Get image data
    NSURL *fileUrl = [NSBundle.mainBundle URLForResource:@"test" withExtension:@"jpeg"];
    NSData *data = [NSData dataWithContentsOfURL:fileUrl];
    
    [[PKZNNetwork shared] uploadFileWithUrlString:urlStr parameters:@{} data:data success:^(id  _Nonnull responseObject) {
        if (responseObject) {
            self.handleImage.image = responseObject;
        }
    } failure:^(NSError * _Nonnull error) {

    }];
}

/**
 * Animation (returns Base64 string)
 */
- (void)animeReturnsBase64 {
    //Set sample picture
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test.jpeg" ofType:nil];
    self.originalImage.image = [UIImage imageWithContentsOfFile:path];
    
    //Splicing request address
    NSString *urlStr = [NSString stringWithFormat:@"%@/matting2?mattingType=11", self.baseUrl];
    //Get image data
    NSURL *fileUrl = [NSBundle.mainBundle URLForResource:@"test" withExtension:@"jpeg"];
    NSData *data = [NSData dataWithContentsOfURL:fileUrl];
    
    [[PKZNNetwork shared] uploadFileWithUrlString:urlStr parameters:@{} data:data success:^(id  _Nonnull responseObject) {
        if (responseObject) {
            NSData *imageData = [[NSData alloc] initWithBase64EncodedString:responseObject[@"data"][@"imageBase64"] options:0];
            self.handleImage.image = [UIImage imageWithData:imageData];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}


#pragma mark - Cartoon avatar

/**
 * Cartoon avatar (return to binary file stream)
 */
- (void)avatarCartoonReturnsBinary {
    //Set sample picture
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test.jpeg" ofType:nil];
    self.originalImage.image = [UIImage imageWithContentsOfFile:path];
    
    //Splicing request address
    NSString *urlStr = [NSString stringWithFormat:@"%@/matting?mattingType=17", self.baseUrl];
    //Get image data
    NSURL *fileUrl = [NSBundle.mainBundle URLForResource:@"test" withExtension:@"jpeg"];
    NSData *data = [NSData dataWithContentsOfURL:fileUrl];
    
    [[PKZNNetwork shared] uploadFileWithUrlString:urlStr parameters:@{} data:data success:^(id  _Nonnull responseObject) {
        if (responseObject) {
            self.handleImage.image = responseObject;
        }
    } failure:^(NSError * _Nonnull error) {

    }];
}

/**
 * Cartoon avatar (returns Base64 string)
 */
- (void)avatarCartoonReturnsBase64 {
    //Set sample picture
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test.jpeg" ofType:nil];
    self.originalImage.image = [UIImage imageWithContentsOfFile:path];
    
    //Splicing request address
    NSString *urlStr = [NSString stringWithFormat:@"%@/matting2?mattingType=17", self.baseUrl];
    //Get image data
    NSURL *fileUrl = [NSBundle.mainBundle URLForResource:@"test" withExtension:@"jpeg"];
    NSData *data = [NSData dataWithContentsOfURL:fileUrl];
    
    [[PKZNNetwork shared] uploadFileWithUrlString:urlStr parameters:@{} data:data success:^(id  _Nonnull responseObject) {
        if (responseObject && [[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqualToString:@"0"]) {
            NSData *imageData = [[NSData alloc] initWithBase64EncodedString:responseObject[@"data"][@"imageBase64"] options:0];
            self.handleImage.image = [UIImage imageWithData:imageData];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark - Face becomes clear

/**
 * The face becomes clear and returns to the binary file stream)
 */
- (void)faceClearReturnsBinary {
    //Set sample picture
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test.jpeg" ofType:nil];
    self.originalImage.image = [UIImage imageWithContentsOfFile:path];
    
    //Splicing request address
    NSString *urlStr = [NSString stringWithFormat:@"%@/matting?mattingType=18", self.baseUrl];
    //Picture data
    NSURL *fileUrl = [NSBundle.mainBundle URLForResource:@"test" withExtension:@"jpeg"];
    NSData *data = [NSData dataWithContentsOfURL:fileUrl];
    
    [[PKZNNetwork shared] uploadFileWithUrlString:urlStr parameters:@{} data:data success:^(id  _Nonnull responseObject) {
        if (responseObject) {
            self.handleImage.image = responseObject;
        }
    } failure:^(NSError * _Nonnull error) {

    }];
}

/**
 * The face becomes clear (returns a Base64 string)
 */
- (void)faceClearReturnsBase64 {
    //Set sample picture
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test.jpeg" ofType:nil];
    self.originalImage.image = [UIImage imageWithContentsOfFile:path];
    
    //Splicing request address
    NSString *urlStr = [NSString stringWithFormat:@"%@/matting2?mattingType=18", self.baseUrl];
    //Picture data
    NSURL *fileUrl = [NSBundle.mainBundle URLForResource:@"test" withExtension:@"jpeg"];
    NSData *data = [NSData dataWithContentsOfURL:fileUrl];
    
    [[PKZNNetwork shared] uploadFileWithUrlString:urlStr parameters:@{} data:data success:^(id  _Nonnull responseObject) {
        if (responseObject && [[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqualToString:@"0"]) {
            NSData *imageData = [[NSData alloc] initWithBase64EncodedString:responseObject[@"data"][@"imageBase64"] options:0];
            self.handleImage.image = [UIImage imageWithData:imageData];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark - Photo coloring

/**
 * Photo coloring (return to binary file stream)
 */
- (void)photoColoringReturnsBinary {
    //Set sample picture
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test.jpeg" ofType:nil];
    self.originalImage.image = [UIImage imageWithContentsOfFile:path];
    
    //Splicing request address
    NSString *urlStr = [NSString stringWithFormat:@"%@/matting?mattingType=19", self.baseUrl];
    //Picture data
    NSURL *fileUrl = [NSBundle.mainBundle URLForResource:@"test" withExtension:@"jpeg"];
    NSData *data = [NSData dataWithContentsOfURL:fileUrl];
    
    [[PKZNNetwork shared] uploadFileWithUrlString:urlStr parameters:@{} data:data success:^(id  _Nonnull responseObject) {
        if (responseObject) {
            self.handleImage.image = responseObject;
        }
    } failure:^(NSError * _Nonnull error) {

    }];
}

/**
 * Color the photo (returns a Base64 string)
 */
- (void)photoColoringReturnsBase64 {
    //Set sample picture
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test.jpeg" ofType:nil];
    self.originalImage.image = [UIImage imageWithContentsOfFile:path];
    
    //Splicing request address
    NSString *urlStr = [NSString stringWithFormat:@"%@/matting2?mattingType=19", self.baseUrl];
    //Picture data
    NSURL *fileUrl = [NSBundle.mainBundle URLForResource:@"test" withExtension:@"jpeg"];
    NSData *data = [NSData dataWithContentsOfURL:fileUrl];
    
    [[PKZNNetwork shared] uploadFileWithUrlString:urlStr parameters:@{} data:data success:^(id  _Nonnull responseObject) {
        if (responseObject && [[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqualToString:@"0"]) {
            NSData *imageData = [[NSData alloc] initWithBase64EncodedString:responseObject[@"data"][@"imageBase64"] options:0];
            self.handleImage.image = [UIImage imageWithData:imageData];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark - ID photo

- (void)idPhoto {
    //Set sample picture
    NSString *path = [[NSBundle mainBundle] pathForResource:@"image_fix.jpeg" ofType:nil];
    self.originalImage.image = [UIImage imageWithContentsOfFile:path];
    
    //Splicing request address
    NSString *urlString = [NSString stringWithFormat:@"%@/idphoto/printLayout", self.baseUrl];
    //parameter
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //Base64 of the avatar file
    NSURL *fileUrl = [NSBundle.mainBundle URLForResource:@"image_fix" withExtension:@"jpeg"];
    NSData *data = [NSData dataWithContentsOfURL:fileUrl];
    NSData *base64Data = [data base64EncodedDataWithOptions:0];
    NSString *encodedImageStr = [[NSString alloc]initWithData:base64Data encoding:NSUTF8StringEncoding];
    [params setValue:encodedImageStr forKey:@"base64"];
    //ID photo background color
    [params setValue:@"0000FF" forKey:@"bgColor"];
    //Gradient background color of ID photo (not required)
    [params setValue:@"0000FF" forKey:@"bgColor2"];
    //ID photo printing dpi, generally 300
    [params setValue:@300 forKey:@"dpi"];
    //The physical height of the ID photo, in millimeters
    [params setValue:@35 forKey:@"mmHeight"];
    //The physical width of the ID photo, in millimeters
    [params setValue:@25 forKey:@"mmWidth"];
    //Typographic background color
    [params setValue:@"FFFFFF" forKey:@"printBgColor"];
    //Printed layout size (height), in millimeters
    [params setValue:@210 forKey:@"printMmHeight"];
    //Print layout size (width), in millimeters
    [params setValue:@150 forKey:@"printMmWidth"];
    //Change the parameters, fill in an extra point to be deducted
    //[params setValue:@"" forKey:@"dress"];
    [[PKZNNetwork shared] postWithUrlString:urlString parameters:params success:^(id  _Nonnull responseObject) {
        if (responseObject && [[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqualToString:@"0"]) {
            //The processed image address, the image address of a single ID photo, and the URL is valid for access within ten minutes
            NSString *idPhotoImage = responseObject[@"data"][@"idPhotoImage"];
            //Get network data through url
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:idPhotoImage]];
            //Convert data to pictures
            self.handleImage.image = [UIImage imageWithData:data];
            
            NSLog(@"idPhotoImage %@", idPhotoImage);
        }
    } failure:^(NSError * _Nonnull error) {
            
    }];
}


#pragma mark - Photo restoration

- (void)imageFix {
    //Set sample picture
    NSString *path = [[NSBundle mainBundle] pathForResource:@"image_fix.jpeg" ofType:nil];
    self.originalImage.image = [UIImage imageWithContentsOfFile:path];
    
    //Splicing request address
    NSString *urlString = [NSString stringWithFormat:@"%@/imageFix", self.baseUrl];
    //parameter
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //Base64 of the avatar file
    NSURL *fileUrl = [NSBundle.mainBundle URLForResource:@"image_fix" withExtension:@"jpeg"];
    NSData *data = [NSData dataWithContentsOfURL:fileUrl];
    NSData *base64Data = [data base64EncodedDataWithOptions:0];
    NSString *encodedImageStr = [[NSString alloc]initWithData:base64Data encoding:NSUTF8StringEncoding];
    [params setValue:encodedImageStr forKey:@"base64"];
    //The mask image file is converted to a base64 string, and supports single-channel, three-channel, and four-channel black and white images at the same time. The repaired area is pure white, and the other areas are black. If this field has a value, the rectangular area parameter is invalid
    NSURL *fileUrlMask = [NSBundle.mainBundle URLForResource:@"mask" withExtension:@"jpeg"];
    NSData *dataMask = [NSData dataWithContentsOfURL:fileUrlMask];
    NSData *base64DataMask = [dataMask base64EncodedDataWithOptions:0];
    NSString *encodedImageStrMask = [[NSString alloc]initWithData:base64DataMask encoding:NSUTF8StringEncoding];
    [params setValue:encodedImageStrMask forKey:@"maskBase64"];
    //Rectangular area, support multiple arrays
    //NSMutableArray *rectangles = [NSMutableArray array];
    //NSDictionary *rectangle1 = @{@"height" : @100, @"width" : @100, @"x" : @160, @"y" : @280};
    //NSDictionary *rectangle2 = @{@"height" : @100, @"width" : @100, @"x" : @560, @"y" : @680};
    //[rectangles addObject:rectangle1];
    //[rectangles addObject:rectangle2];
    //[params setValue:rectangles forKey:@"rectangles"];
    [[PKZNNetwork shared] postWithUrlString:urlString parameters:params success:^(id  _Nonnull responseObject) {
        if (responseObject && [[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqualToString:@"0"]) {
            //The processed image address
            NSString *imageUrl = responseObject[@"data"][@"imageUrl"];
            //Get network data through url
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
            //Convert data to pictures
            self.handleImage.image = [UIImage imageWithData:data];
            
            NSLog(@"imageUrl %@", imageUrl);
        }
    } failure:^(NSError * _Nonnull error) {
            
    }];
}


#pragma mark - Stylization

- (void)styleTransfer {
    //Set sample picture
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cat.jpeg" ofType:nil];
    self.originalImage.image = [UIImage imageWithContentsOfFile:path];
    
    //Splicing request address
    NSString *urlString = [NSString stringWithFormat:@"%@/styleTransferBase64", self.baseUrl];
    //parameter
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //Enter the base64 of the image file to be converted
    NSURL *fileUrl = [NSBundle.mainBundle URLForResource:@"cat" withExtension:@"jpeg"];
    NSData *data = [NSData dataWithContentsOfURL:fileUrl];
    NSData *base64Data = [data base64EncodedDataWithOptions:0];
    NSString *encodedImageStr = [[NSString alloc]initWithData:base64Data encoding:NSUTF8StringEncoding];
    [params setValue:encodedImageStr forKey:@"contentBase64"];
    //Input the base64 of the style picture file
    NSURL *fileUrlMask = [NSBundle.mainBundle URLForResource:@"style" withExtension:@"jpeg"];
    NSData *dataMask = [NSData dataWithContentsOfURL:fileUrlMask];
    NSData *base64DataMask = [dataMask base64EncodedDataWithOptions:0];
    NSString *encodedImageStrMask = [[NSString alloc]initWithData:base64DataMask encoding:NSUTF8StringEncoding];
    [params setValue:encodedImageStrMask forKey:@"styleBase64"];
    
    [[PKZNNetwork shared] postWithUrlString:urlString parameters:params success:^(id  _Nonnull responseObject) {
        if (responseObject && [[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqualToString:@"0"]) {
            //After the processing is completed, the temporary url of the result picture, please download it in time, it will be invalid within five minutes
            NSString *imageUrl = responseObject[@"data"];
            //Get network data through url
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
            //Convert data to pictures
            self.handleImage.image = [UIImage imageWithData:data];
            
            NSLog(@"imageUrl %@", imageUrl);
        }
    } failure:^(NSError * _Nonnull error) {
            
    }];
}

@end
