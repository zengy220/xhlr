<?php
namespace Home\Controller;
class SignController extends CommonController{
	const PAGESIZE=10;
	
	//签到记录
	public function index(){
		$model=M('saleman_log');
		$where=array();
		
		$gh=I('gh');	//工号
		$bid=I('bid');	//商家号
		$name=I('name');	//店名
		$isToday=I('isToday');	//是否当日任务
		$beginTime=I('begintime');	//起时间
		$endTime=I('endtime');	//止时间
		
		$field=array('gh','bid','name','isToday','beginTime','endTime');
		foreach($field as $v){
			if(empty($$v)){
				continue;
			}
			switch($v){
				case 'gh':
					$where['b.user_id']=$$v;
					break;
				case 'bid':
					$where['c.business_id']=array('like','%'.$$v.'%');
					break;
				case 'name':
					$where['c.name']=array('like','%'.$$v.'%');
					break;
				case 'beginTime':
					$where['a.intime']=array('egt',strtotime($$v));
					break;
				case 'endTime':
					$where['a.intime']=array('elt',strtotime($$v));
					break;
				case 'isToday':
					$where['a.is_today']=$$v;
					break;
			}
		}
		
		$count      = $model->alias('a')->join('left join cs_user b on a.saleman_id=b.user_id left join cs_business c on a.bus_id=c.busi_id')->where($where)->count();
		$Page       = new \Think\Page($count,self::PAGESIZE);
		$show       = $Page->show();
		$list = $model->alias('a')->field('a.intime,b.user_id,b.real_name,a.is_today,c.business_id,c.name')->join('left join cs_user b on a.saleman_id=b.user_id')->join('left join cs_business c on a.bus_id=c.busi_id')->where($where)->order('a.intime desc')->limit($Page->firstRow.','.$Page->listRows)->select();
		
		$this->assign($_REQUEST);
		$this->assign('list',$list);
		$this->assign('page',$show);
		$this->display();
	}
	
	//签到汇总
	public function signList(){
		$model=M('user');
		
		$gh=I('gh');
		$theTime=I('theTime');

		if(empty($theTime)){
			$todayStart=strtotime(date('Y-m-d').' 0:0:1');
			$todayEnd=strtotime(date('Y-m-d').' 23:59:59');
			$_GET['theTime']=date('Y/n/j');
		}else{
			$todayStart=strtotime($theTime.' 0:0:1');
			$todayEnd=strtotime($theTime.' 23:59:59');
		}
		
		$sql='';
		if(!empty($gh)){
			$sql.=' and a.user_id='.$gh;
		}
		
		$this->assign($_REQUEST);
		
		$users=$model->alias('a')->field('a.user_id,a.real_name')->join('left join cs_userrole b on a.user_Id=b.user_Id')->where('b.role_Id=10'.$sql)->select();
		$busiModel=M('business');
		$logModel=M('saleman_log');
		foreach($users as $k=>$v){
			$users[$k]['total']=$logModel->where(array('saleman_id'=>$v['user_id'],'intime'=>array('between'=>array($todayStart,$todayEnd))))->count();
			
			$need=M()->query('select count(6) as ct,busi_level from cs_business where saleman_id='.$v['user_id'].' and status=1 group by busi_level');	//应签到
			$users[$k]['need']=empty($need)?array(array('ct'=>0),array('ct'=>0),array('ct'=>0)):$need;
			
			$noin=M()->query('select busi_level,count(6) as total from cs_business where busi_id not in (select bus_id from cs_saleman_log where intime BETWEEN '.$todayStart.' and '.$todayEnd.') and saleman_id='.$v['user_id'].' group by busi_level');
			$users[$k]['noIn']=empty($noin)?array(array('total'=>0),array('total'=>0),array('total'=>0)):$noin;
		}
		
		$count      = $model->alias('a')->join('left join cs_userrole b on a.user_Id=b.user_Id')->where('b.role_Id=10')->count();
		$Page       = new \Think\Page($count,self::PAGESIZE);
		$show       = $Page->show();
		$list = $users;
		$this->assign($_REQUEST);
		$this->assign('list',$list);
		$this->assign('page',$show);
		
		$this->display();
	}
	
	//是否当日任务，已弃用
	private function isToday($time){
		$todayStart=strtotime(date('Y-m-d').' 0:0:1');
		$todayEnd=strtotime(date('Y-m-d').' 23:59:59');
		if($time<=$todayEnd && $time>=$todayStart){
			return true;
		}else{
			return false;
		}
	}
}