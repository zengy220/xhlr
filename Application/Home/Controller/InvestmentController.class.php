<?php
/** 
*PHP文件 
* 
*系统菜单权限角色集中控制器
* @author      zhuda<675671998@qq.com> 
* @version     $Id$ 
* @since        1.0 
*/ 
namespace Home\Controller;
use Home\Controller;
class InvestmentController extends CommonController
{
	
//默认页展示
    public function index()
    {
		//菜单列表
		$count = M('attract_investment')->count();
		$p=new \Org\Util\Page($count,20,"/page_content/id/$this->id/ptpcode/$this->ptpcode");
		$show=$p->show();
		$investment = M('attract_investment')->limit($p->limit[0],$p->limit[1])->select();
    	$this->assign('show',$show);
    	$this->assign('investment',$investment);
		$this->display();
    }

}
