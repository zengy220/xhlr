<?php
	//会员|消费者 控制器   --------------------
namespace Home\Controller;
use Home\Controller;
class ClientController extends CommonController
{
	//会员列表
	public function index(){

	}
	public function client_list(){
		$custom = M('custom');
		$search_array = array(
			'user_id' => trim(I('user_id')),//会员ID
			'nickname'=> trim(I('nickname')),//微信昵称
			'regcome' => trim(I('regcome')),//渠道来源
			'status'  => trim(I('status')),//状态
			//'addtime'=> I('addtime'),//注册时间

		);

		foreach($search_array as $k=>$v){
			if($v != ''){
				$where[$k] = array('like',"%$v%");
			}
		}
		
		$addtime = I('addtime');
		if($addtime != ''){
			$date_1 = strtotime($addtime);
			$date_2 = strtotime($addtime)+86400;
			$where['addtime'] = array('between',array($date_1,$date_2));
		}

		$count = $custom->where($where)->count();//总记录数
		$page = new \Org\Util\Page($count,20);
		$customInfo = $custom->where($where)->limit($page->limit[0],$page->limit[1])->select();	//查询用户
		$this->assign('customInfo',$customInfo);
		
		$customPage = $page->show();
		$this->assign('customPage',$customPage);
		$this->assign('param',$search_array);
		$this->assign('addtime',$addtime);

		$this->display();
	}
	
	public function client_list_export(){
		header("Content-type:text/html;charset=utf-8");
		$search_array = array(
			'user_id' => trim(I('user_id')),//会员ID
			'nickname'=> trim(I('nickname')),//微信昵称
			'regcome' => trim(I('regcome')),//渠道来源
			'status'  => trim(I('status')),//状态
			//'addtime'=> I('addtime'),//注册时间

		);

		foreach($search_array as $k=>$v){
			if($v != ''){
				$where[$k] = array('like',"%$v%");
			}
		}
		
		$addtime = I('addtime');
		if($addtime != ''){
			$date_1 = strtotime($addtime);
			$date_2 = strtotime($addtime)+86400;
			$where['addtime'] = array('between',array($date_1,$date_2));
		}

		$rel = M('custom')->field('user_id,nickname,openid,addtime,city,province,regcome')->where($where)->select();	//查询用户
		
		foreach($rel as $key=>$val){
			$rel[$key]['regcome'] = ($val['regcome'] == 1) ? '商品扫码':'关注公众号';
		}
		
		$arr_1 = array('业务员ID','姓名','openid','注册时间','城市','省份','来源');
		
		$arr_2 = array();
		
		$titleArr = parent::bubbling_sort($rel,$arr_1,$arr_2);
		
		$name = '签到记录'.date('Y-m-d H:i:s',time());

		parent::exportexcel($rel,$titleArr,$name);

	}
	
	//冻结会员
	public function freeze_client(){
		$user_id = I('user_id');
		$data = array(
			'status' => 0
		);
		$rs = M('custom')->where("user_id=$user_id")->save($data);
		//$rs = "update set user_id=$user_id where"
		//echo M()->getLastSql();exit;
		if(!$rs){
			$this->error('禁用会员失败','/Home/Client/client_list');
		}else{
			$this->success('禁用会员成功','/Home/Client/client_list');
		}
	}
	
	//删除会员
	public function drop_client(){
		$user_id = I('user_id');
		
	}
	
	//恢复会员
	public function unfreeze_client(){
		$user_id = I('user_id');
		$data = array(
			'status' => 1
		);
		$rs = M('custom')->where("user_id=$user_id")->save($data);
		if(!$rs){
			$this->error('解禁会员失败','/Home/Client/client_list');
		}else{
			$this->success('解禁会员成功','/Home/Client/client_list');
		}
	}
	
	
	
}








