require "SimpleMapController"

waxClass{"ViewController", UITableViewController}

local string = "a string"
local string_alert_title = "提示"
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
   
	--local viewController = SuccessController:alloc():init()
  	--self:navigationController():pushViewController_animated(viewController, true)
  	local mapController = SimpleMapController:alloc():init()
  	print(mapController)
  	self:navigationController():pushViewController_animated(mapController, true)
end
