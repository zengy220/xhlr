<?php
/*	订单控制器  */
namespace Home\Controller;
use Home\Controller;
class OrderController extends CommonController
{
	//订单列表
/*	public function erOrderList(){
		
		$E = M('gift_exchange_record');//兑换单记录表模型
		$erOrderInfo = $E->order('gettime desc')->limit($page->limit[0],$page->limit[1])->where('status=2')->select(); //兑换成功的订单信息
		
		//echo '<pre>';
		//var_dump($erOrderInfo);exit;
		$count = $E->where('status=2')->count();//获取成功兑换的订单的总数
		
		$page = new \Org\Util\Page($count,50);
		$erOrderPage = $page->show();
		
		$this->assign('erOrderPage',$erOrderPage);
		$this->assign('erOrderInfo',$erOrderInfo);
		$this->display();
		
	}*/
	
	//订单列表
	public function er_order_list(){
		
		$E = M('gift_exchange_record');//兑换单记录表模型
		$erOrderInfo = $E->order('gettime desc')->limit($page->limit[0],$page->limit[1])->where('status=2')->select(); //兑换成功的订单信息
		
		//echo '<pre>';
		//var_dump($erOrderInfo);exit;
		$count = $E->where('status=2')->count();//获取成功兑换的订单的总数
		
		$page = new \Org\Util\Page($count,50);
		$erOrderPage = $page->show();
		
		$this->assign('erOrderPage',$erOrderPage);
		$this->assign('erOrderInfo',$erOrderInfo);
		$this->display();
		
	}
	
	
	
}
