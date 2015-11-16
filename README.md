wax最新github托管地址 :https://github.com/alibaba/wax
现在由alibaba进行代码的维护.
Wax是什么?

Wax for iPhone这种框架在开发时，旨在把Lua脚本语言和原生Objective-C应用编程接口(API)结合起来。这意味着，你可以从Lua里面，使用任何和全部的Objective-C类及框架。

从技术上来讲，Wax结合了Objective-C类和原生C代码。Lua语言嵌入了C语言，然后Objective-C类并入到其中。

为什么使用Wax?

Wax是免费的、开源的。与其他一些基于Lua的移动开发解决方案不同，Wax是个开源框架，只需要你花一点点时间就可以上手，不需要花钱。不喜欢Wax的工作方式，或者发现实施方面的缺陷?源代码可免费获取，你总是可以改动源代码，以满足自己的需要。

可以利用原生API。这意味着，为教Objective-C而编写的教程很容易由Lua for Wax来改动和编写。这还意味着，你的应用程序在外观感觉上总是如同原生应用程序，不过又得到了用Lua这种高效脚本语言编写代码可以节省时间的好处。

可以使用Xcode。这意味着，模拟器和设备部署都轻而易举，不会轻易与未来的iOS版本决裂。

可以利用所有现有的Objective-C库。如果你有一个Objective-C类是以前编写的，不需要改动，就可以将它用在Lua中——只要把它放入到Xcode。Three20之类的库也是一样。只要按照正常指令来添加库，就可以使用Lua代码访问它们。

可以利用Wax Lua模块。Wax有几个内置的Lua模块，使得异步HTTP请求和JavaScript对象标注(JSON)创建/解析极其容易而快速(因为模块是用C编写的)。

没必要管理内存。不再需要操心内存分配之类的事务。Wax为你处理这一切。

Lua类型自动转换成对应的Objective-C类型，反之亦然。 这意味着，如果你调用了需要NSString和NSInteger的某个方法，但传送了Lua字符串和Lua整数，Wax会为你搞定转换工作。这种转换功能强大，甚至可以处理复杂的Objective-C特性，比如选择器。

你可以利用所有上述特性。不需要精挑细选。你获得所有特性!
##功能1 代码覆盖
 原始OB代码
```sh
@implementation MainViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row + 1];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ViewController *vc = [[ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
```
画面效果图:

![IMG_1261.PNG](http://upload-images.jianshu.io/upload_images/1185668-9b1ad36252699a58.PNG?imageMogr2/auto-orient/strip%7CimageView2/2/w/320)
覆盖的lua代码
```sh
 waxClass{"MainViewController", UITableViewController}

function tableView_cellForRowAtIndexPath(self, tableView, indexPath)
	local cell = self:ORIGtableView_cellForRowAtIndexPath(tableView, indexPath)
	cell:textLabel():setText("" .. (10 - indexPath:row()))
	cell:detailTextLabel():setText("zhaozihui")
	cell:textLabel():setTextColor(UIColor:redColor())
	return cell
end
```
覆盖后画面效果图:

![IMG_1262.PNG](http://upload-images.jianshu.io/upload_images/1185668-b1a8cd321b204aa8.PNG?imageMogr2/auto-orient/strip%7CimageView2/2/w/320)
功能就是替换每个cell中的显示内容


##功能2 控制画面逻辑
在功能1 的基础上覆盖OC的画面逻辑
原始代码逻辑:

```sh
@implementation ViewController
{
    NSString *testStr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    testStr = @"显示内容";
    [self setTitle:@"我是标题OC"];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIWebView *wb = [[UIWebView alloc] init];
    NSURLRequest *url = [NSURLRequest requestWithURL:[NSURL URLWithString:@""]];
    [wb loadRequest:url];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    cell.textLabel.text = testStr;
    return cell;
}
```
原始的画面效果:

![IMG_1264.PNG](http://upload-images.jianshu.io/upload_images/1185668-1944eec44c45bf5a.PNG?imageMogr2/auto-orient/strip%7CimageView2/2/w/320)
新的lua代码可以改变原始代码的现实和逻辑控制
以下的代码控制原始的oc的controller 跳转到一个新的lua制作的页面
```sh
require "SimpleMapController"

waxClass{"ViewController", UITableViewController}

local string = "a string"
function viewDidLoad(self)
 testStr = "哈哈哈我是lua的cell内容"
 self:setTitle("我是标题LUA");
end

function tableView_cellForRowAtIndexPath(self, tableView, indexPath)
	local cell = self:ORIGtableView_cellForRowAtIndexPath(tableView, indexPath)
	cell:textLabel():setText("" .. indexPath:row())
	cell:detailTextLabel():setText(testStr)
	cell:textLabel():setTextColor(UIColor:redColor())
	cell:detailTextLabel():setTextColor(UIColor:greenColor())
	return cell
end

function tableView_didSelectRowAtIndexPath(self,tableView, indexPath)
  	local mapController = SimpleMapController:alloc():init()
  	self:navigationController():pushViewController_animated(mapController, true)
end

```
wax覆盖后的效果图:

![IMG_1263.PNG](http://upload-images.jianshu.io/upload_images/1185668-c33954d87a3fd79e.PNG?imageMogr2/auto-orient/strip%7CimageView2/2/w/320)

不仅替换了画面的显示,还将cell的点击事件重新定义,定义到了一个心的wax制作的 SimpleMapController页面

###完全使用wax书写一个页面
```sh

waxClass{"SimpleMapController", UIViewController}
function init(self)
  self.super:init()
  --设置title
  self:setTitle("States")
  self.trends = {}
  return self
end

function viewDidLoad(self)
--设置页面背景
  self:view():setBackgroundColor(UIColor:blueColor());
--自定义一个Label
  local label = UILabel:initWithFrame(CGRect(100, 100, 200, 100))
  label:setText("你好我是Lua界面")
  label:setTextColor(UIColor:redColor())
  self:view():addSubview(label)
--自定义一个Button
  local play = UIButton:buttonWithType(UIButtonTypeCustom)  
  play:setFrame(CGRect(100,200, 100, 40))  
  play:setTitle_forState("action",UIControlStateNormal);
  play:addTarget_action_forControlEvents(self,"onDeleteIconClick:",UIControlEventTouchUpInside) 
  self:view():addSubview(play)
  --自定义一个webview
  local wb = UIWebView:initWithFrame(CGRect(0, 250, 320, 200))
  local url = NSURLRequest:requestWithURL(NSURL:URLWithString("http://www.163.com"));
  wb:loadRequest(url);
  self:view():addSubview(wb);
  

end
//Button 点击事件
function onDeleteIconClick(self, sender)   
    alert("warning","YOU CAN");
end  
//弹出框显示
function alert(title,content)
  UIAlertView:alloc():initWithTitle_message_delegate_cancelButtonTitle_otherButtonTitles(title,content,nil,"OK",nil):show()
end

```
画面效果:

![IMG_1265.PNG](http://upload-images.jianshu.io/upload_images/1185668-42155fcc137a004d.PNG?imageMogr2/auto-orient/strip%7CimageView2/2/w/320)

