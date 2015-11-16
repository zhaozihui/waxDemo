
waxClass{"SimpleMapController", UIViewController}
function init(self)
  self.super:init()
  self:setTitle("States")
  self.trends = {}
  return self
end

function viewDidLoad(self)
  print("1")
  self:view():setBackgroundColor(UIColor:blueColor());
  local label = UILabel:initWithFrame(CGRect(100, 100, 200, 100))
  label:setText("你好我是Lua界面")
  label:setTextColor(UIColor:redColor())
  self:view():addSubview(label)

  local play = UIButton:buttonWithType(UIButtonTypeCustom)  
  play:setFrame(CGRect(100,200, 100, 40))  
  play:setTitle_forState("action",UIControlStateNormal);
  play:addTarget_action_forControlEvents(self,"onDeleteIconClick:",UIControlEventTouchUpInside) 
  self:view():addSubview(play)
  
  local wb = UIWebView:initWithFrame(CGRect(0, 250, 320, 200))
  local url = NSURLRequest:requestWithURL(NSURL:URLWithString("http://www.163.com"));
  wb:loadRequest(url);
  self:view():addSubview(wb);
  


end

function onDeleteIconClick(self, sender)   
    alert("warning","YOU CAN");
end  

function alert(title,content)
  UIAlertView:alloc():initWithTitle_message_delegate_cancelButtonTitle_otherButtonTitles(title,content,nil,"OK",nil):show()
end
