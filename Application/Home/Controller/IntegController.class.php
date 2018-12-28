<?php
/*
	积分控制器
*/
namespace Home\Controller;
use Think\Controller;
class IntegController extends CommonController
{	
	public function index(){
		
	}
	//积分列表
	public function integ_list(){

		$search_array = array(
			'user_id'	 =>trim(I('user_id')),
			'business_id'=>trim(I('business_id')),
			'name'		 =>trim(I('name')),
			'type'		 =>trim(I('type')),
			'change_type'=>trim(I('change_type')),

		);
		
		foreach($search_array as $k=>$v){
			if( $v != ''){
				switch($k){
					case 'user_id' : $where['a.'.$k] = array('like',"%$v%"); break; 
					case 'business_id' : $where['a.'.$k] = array('like',"%$v%"); break; 
					case 'name' : $where[$k] = array('like',"%$v%"); break; 
					case 'type' : $where[$k] = $v; break; 
					case 'change_type' : $where[$k] = $v; break;
				}
			}
			
		}
		
		$starttime = I('starttime');
		$endtime = I('endtime');
		if( $starttime != '' && $endtime != '' ){
			$date_1 = strtotime($starttime);
			$date_2 = strtotime($endtime)+86400;
			$where['time'] = array('between',array($date_1,$date_2));
			
		}elseif( $starttime != '' && $endtime == '' ){
			$date_1 = strtotime($starttime);
			$where['time'] = array('egt',$date_1);
			
		}elseif( $starttime == '' && $endtime != '' ){
			$date_2 = strtotime($endtime)+86400;
			$where['time'] = array('elt',$date_2);
			
		}
		$I = M('integ_log as a');//积分日志表
		$count = $I->join('LEFT JOIN `cs_business` as b ON a.busi_id=b.busi_id')->where($where)->count(); //积分日志总数
		$page = new \Org\Util\Page($count,50);//实例化自定义分页类
		$integInfo = $I->field('a.*,b.name')->join('LEFT JOIN `cs_business` as b ON a.busi_id=b.busi_id')->where($where)->order('time desc')->limit($page->limit[0],$page->limit[1])->select(); //扫码记录详情

		$integPage = $page->show();//调用显示方法 赋值给$codePage等待给模板传值
		$this->assign('integPage',$integPage);
		$this->assign('integInfo',$integInfo);
		$this->assign('param',$search_array);
		$this->assign('starttime',$starttime);
		$this->assign('endtime',$endtime);
		$this->display();
	}
	
	
	//积分列表(导出)
	public function integ_list_export(){
		header("Content-type:text/html;charset=utf-8");
		$search_array = array(
			'user_id'	 =>trim(I('user_id')),
			'business_id'=>trim(I('business_id')),
			'name'		 =>trim(I('name')),
			'type'		 =>trim(I('type')),
			'change_type'=>trim(I('change_type')),

		);
		
		foreach($search_array as $k=>$v){
			if( $v != ''){
				switch($k){
					case 'user_id' : $where['a.'.$k] = array('like',"%$v%"); break; 
					case 'business_id' : $where['a.'.$k] = array('like',"%$v%"); break; 
					case 'name' : $where[$k] = array('like',"%$v%"); break; 
					case 'type' : $where[$k] = $v; break; 
					case 'change_type' : $where[$k] = $v; break;
				}
			}
			
		}
		
		$starttime = I('starttime');
		$endtime = I('endtime');
		if( $starttime != '' && $endtime != '' ){
			$date_1 = strtotime($starttime);
			$date_2 = strtotime($endtime)+86400;
			$where['time'] = array('between',array($date_1,$date_2));
			
		}elseif( $starttime != '' && $endtime == '' ){
			$date_1 = strtotime($starttime);
			$where['time'] = array('egt',$date_1);
			
		}elseif( $starttime == '' && $endtime != '' ){
			$date_2 = strtotime($endtime)+86400;
			$where['time'] = array('elt',$date_2);
			
		}


		$integInfo = M('integ_log as a')->field('a.user_id,a.change_point,a.change_type,a.type,a.point,a.business_id,b.name,FROM_UNIXTIME(a.time,"%Y-%m-%d %H:%i:%s") as time')->join('LEFT JOIN `cs_business` as b ON a.busi_id=b.busi_id')->where($where)->order('time desc')->select(); //扫码记录详情
		
		foreach($integInfo as $key=>$val){
			
			switch($val['type']){
				case 1:
					$integInfo[$key]['type'] = '增加';
					break;
				case 2:
					$integInfo[$key]['type'] = '扣减';
					break;
			}
			switch($val['change_type']){
				case 1:
					$integInfo[$key]['change_type'] = '他人转增';
					break;
				case 2:
					$integInfo[$key]['change_type'] = '兑换商品';
					break;
				case 3:
					$integInfo[$key]['change_type'] = '赠送他人';
					break;
				case 4:
					$integInfo[$key]['change_type'] = '扫码获取';
					break;
				case 5:
					$integInfo[$key]['change_type'] = '活动获取';
					break;

			}
			
			
		}

		$arr_1 = array('会员ID','可用积分','变更方式','收支类型','积分量','商家号','商家名','变更时间');
		
		$arr_2 = array();
		
		$titleArr = parent::bubbling_sort($integInfo,$arr_1,$arr_2);
		
		$name = '积分明细'.date('Y-m-d H:i:s',time());

		parent::exportexcel($integInfo,$titleArr,$name);

	}
	
    
	
}