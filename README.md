# XQSheet
A convenient sheet presented from bottom.

开发这个控件,主要是因为系统的UIActionSheet在iOS8已经被废弃了,而UIAlertController在自定义颜色,字体方面不是很方便,而且UIAlertController需要iOS8及以上系统,考虑到还需要适配iOS7.所以就做了这么一个控件.通过工厂方法传入不同的参数可以实例化多种样式的菜单.

按钮的顺序与你添加的顺序一致.

#### 功能

自定义"菜单"上的文字颜色,文字字体大小等更加方便.采用block回调的方式配置按钮及执行按钮事件,让代码更加紧凑.

#### 使用
```
//通过工厂方法实例化对象, XQSheetTypeSelect/XQSheetTypeAction两种
XQSheet *sheet = [XQSheet sheetWithType:XQSheetTypeSelect title:nil subTitle:nil cancelButtonTitle:nil];
sheet.selectedBtnMarkImage = [UIImage imageNamed:@"fb_btn_selected"];
[sheet addBtnWithTitle:@"先不冲" configHandler:nil actionHandler:^(UIButton *button, NSString *buttonTitle, NSInteger buttonIndex) {
		UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"你选择了:%@", buttonTitle] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [av show];
}];
[sheet addBtnWithTitle:@"冲满" configHandler:nil actionHandler:^(UIButton *button, NSString *buttonTitle, NSInteger buttonIndex) {
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"你选择了:%@", buttonTitle] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [av show];
}];
[sheet addBtnWithTitle:@"别烦我" configHandler:nil actionHandler:^(UIButton *button, NSString *buttonTitle, NSInteger buttonIndex) {
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"你选择了:%@", buttonTitle] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [av show];
}];
sheet.selectedIndex = 1;
[sheet showSheetWithController:self completion:nil];
```
#### 效果

样式1

<img src="http://upload-images.jianshu.io/upload_images/1503319-a1e8a921d1cdd26d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" alt="Drawing" width="200px" />

样式2

<img src="http://upload-images.jianshu.io/upload_images/1503319-ab6c1db026f2767c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" alt="Drawing" width="200px" />

样式3

<img src="http://upload-images.jianshu.io/upload_images/1503319-3f71d33df22fd6fc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" alt="Drawing" width="200px" />

样式4

<img src="http://upload-images.jianshu.io/upload_images/1503319-287a7b1c227f0702.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" alt="Drawing" width="200px" />

样式5

<img src="http://upload-images.jianshu.io/upload_images/1503319-90311cd06ef83b27.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" alt="Drawing" width="200px" />

#### 注意事项
该控件暂不支持横屏.使用过程中有任何bug,可以告诉我.
