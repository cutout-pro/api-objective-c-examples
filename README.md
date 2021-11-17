# CUTOUT Smart matting API interface project sample code

#### [中文](./README_CN.md)

#### Example of use
- Use the command: git clone https://github.com/cutout-pro/api-objective-c-examples.git Clone this project
- Change APIKEY under PKZNNetwork.m, call the API interface method that needs to be executed in the page method. Note: (*Sample code is for reference only, if you need to use it, please make changes according to the actual situation of the project*)
```
//Splicing request URL
NSString *urlStr = [NSString stringWithFormat:@"%@/matting?mattingType=6", self.baseUrl];
//Get image data
NSURL *fileUrl = [NSBundle.mainBundle URLForResource:@"test" withExtension:@"jpeg"];
NSData *data = [NSData dataWithContentsOfURL:fileUrl];

//Whether to crop to the smallest non-transparent area (not required)
BOOL crop = 1;
//Fill background color (not required)
NSString *bgColor = @"000000";
NSDictionary *params = @{@"crop" : @(crop), @"bgcolor" : bgColor};
[[PKZNNetwork shared] uploadFileWithUrlString:urlStr parameters:params data:data success:^(id  _Nonnull responseObject) {
    if (responseObject) {
        //Get the processed picture
        self.handleImage.image = responseObject;
    }
} failure:^(NSError * _Nonnull error) {

}];
```

##### Note: For more detailed information about the API interface, please refer to the API documentation on the official website (the code of the sample project will be updated synchronously according to the API documentation on the official website)
[CUTOUT Smart Cutout](https://www.cutout.pro/api-document/)

---
#### About us
Founded in 2018, with a group of technomaniacs, cutout.pro leverages the power of artificial intelligence and computer vision to deliver a wide range of products that make your life much easier and your work more productive.

#### If you have other requirements, please contact us through the following ways
- email
  tech@cutout.pro
