<?php
/*	签到控制器  */
namespace Home\Controller;
use Home\Controller;
class RegisterController extends CommonController
{
	
	//签到记录
	public function register_record(){
		
		//1.判断当前登录账号是属于总部角色还是分部角色,如果是总部角色就查出所有商家的签到记录,是分部就根据当前用户的组织,查询出该组织下的所有记录
		
		$startTime = strtotime(trim(I('startTime')));
		$endTime   = strtotime(trim(I('endTime')));
		$date = strtotime( trim(I('endTime')).'23:59:59');
		
		if( $startTime != null && $endTime != null ){
			$where['a.intime'] = array('between',array($startTime,$date));
		}elseif( $startTime != null && $endTime == null ){
			$where['a.intime'] = array('egt',$startTime);
		}elseif($startTime == null && $endTime != null ){
			$where['a.intime'] = array('elt',$endTime);
		}
		
		$temp =array(
			'c.username'=>I('username'),
			'b.business_id'=>I('business_id'),
			'b.name'    =>I('name'),
			'a.is_today'=>I('is_today'),
		);
		
		foreach($temp as $key => $val){
			
			if( $val != '' ){
				$where[$key] = array('like',"%$val%");//模糊查询
			}

		}

		if( session('role_identity') == 1 ){ $where['b.company_id'] = session('company'); }//查看权限控制
		
		$signModel = M('sign_log as a');
		
		$count = $signModel->join("LEFT JOIN `cs_business` as b ON a.bus_id=b.busi_id")->join("LEFT JOIN `cs_user` as c ON a.saleman_id=c.user_Id")->where($where)->count();//统计所有商家的条数。
		$page = new \Org\Util\Page($count,20);//实例化分页模型
		$show = $page->show();//分页
		
		
		$res = $signModel->field('a.*,b.name,b.business_id,c.username,c.real_name,busi_level')->join("LEFT JOIN `cs_business` as b ON a.bus_id=b.busi_id")->join("LEFT JOIN `cs_user` as c ON a.saleman_id=c.user_Id")->where($where)->limit($page->limit[0],$page->limit[1])->order('Id desc')->select();

		
		foreach($res as $k=>$v){
			switch($v['is_today']){
				case 0:
				$res[$k]['is_today'] = '否';
				break;
				case 1:
				$res[$k]['is_today'] = '是';
				break;
				
			}
		}
		$param = I();
		$this->assign('param',$param);
		$this->assign('Page',$show);
		$this->assign('data',$res);
		$this->display();
	}
	
	
	
	
	public function register_record_export(){
		header("Content-type:text/html;charset=utf-8");
		//1.判断当前登录账号是属于总部角色还是分部角色,如果是总部角色就查出所有商家的签到记录,是分部就根据当前用户的组织,查询出该组织下的所有记录
		
		$startTime = strtotime(trim(I('startTime')));
		$endTime   = strtotime(trim(I('endTime')));
		$date = strtotime( trim(I('endTime')).'23:59:59');
		
		if( $startTime != null && $endTime != null ){
			$where['a.intime'] = array('between',array($startTime,$date));
		}elseif( $startTime != null && $endTime == null ){
			$where['a.intime'] = array('egt',$startTime);
		}elseif($startTime == null && $endTime != null ){
			$where['a.intime'] = array('elt',$endTime);
		}
		
		$temp =array(
			'c.username'=>I('username'),
			'b.business_id'=>I('business_id'),
			'b.name'    =>I('name'),
			'a.is_today'=>I('is_today'),
		);
		
		foreach($temp as $key => $val){
			
			if( $val != '' ){
				$where[$key] = array('like',"%$val%");//模糊查询
			}

		}

		if( session('role_identity') == 1 ){ $where['b.company_id'] = session('company'); }//查看权限控制
		
		$signModel = M('sign_log as a');
		
		$res = $signModel->field('c.username,c.real_name,b.business_id,busi_level,b.name,a.is_today,FROM_UNIXTIME(a.intime,"%Y-%m-%d %H:%i:%s") as intime')->join("LEFT JOIN `cs_business` as b ON a.bus_id=b.busi_id")->join("LEFT JOIN `cs_user` as c ON a.saleman_id=c.user_Id")->where($where)->order('Id desc')->select();

		
		foreach($res as $k=>$v){
			switch($v['is_today']){
				case 0:
				$res[$k]['is_today'] = '否';
				break;
				case 1:
				$res[$k]['is_today'] = '是';
				break;
				
			}
		}
		
		$arr_1 = array('业务员工号','姓名','商家号','商家等级','店名','是否当日任务','签到时间');
		
		$arr_2 = array();
		
		$titleArr = parent::bubbling_sort($res,$arr_1,$arr_2);
		
		$name = '签到记录'.date('Y-m-d H:i:s',time());

		parent::exportexcel($res,$titleArr,$name);

	}
	
	
	
	
	//签到汇总
	public function register_record_total(){

		$condition="1=1 ";

		$date	   = I('date');//接收的时间
		$where='';
		$where1=" ";
		$where2='';
		if($date!=''){
            $startTime=strtotime(date("Y-m-d",strtotime($date))."0:0:0");
			$endTime=strtotime(date("Y-m-d",strtotime($date))."23:59:59");
			$where.=" and t1.intime between '$startTime' and '$endTime'";
			$where1.=" and intime between '$startTime' and '$endTime'";
			$where2.=" and a2.intime between '$startTime' and '$endTime'";


		}else{
			$startTime=strtotime(date("Y-m-d",time())."0:0:0");
			$endTime=strtotime(date("Y-m-d",time())."23:59:59");
			$where.=" and t1.intime between '$startTime' and '$endTime'";
			$where1.=" and intime between '$startTime' and '$endTime'";
			$where2.=" and a2.intime between '$startTime' and '$endTime'";

		}

		$username = I('username');
		if($username!=''){

			$condition.=" and t8.username='$username'";

		}
		$real_name = I('real_name');
		if($real_name!=''){

			$condition.=" and t8.real_name='$real_name'";

		}

		foreach($temp as $key => $val){
			if( $val != '' ){
				$where[$key] = $val;
			}

		}
		
		$signModel = M('sign_log as t1');
		
		$role_identity = session('role_identity');
		
		$count = $signModel->join("LEFT JOIN `cs_business` as b ON a.bus_id=b.busi_id")->join("LEFT JOIN `cs_user` as c ON a.saleman_id=c.user_Id")->where($where)->count();//统计所有商家的条数。
		$page = new \Org\Util\Page($count,20);//实例化分页模型
		$show = $page->show();//分页
			//时间默认为当日
		//1.首先查询判断当前用户的身份（总部的还是分部的）.
		//2.然后根据用户身份查询出对应的商家
		// $role_identity = session('role_identity');
		
		if( $role_identity == 0 ){

			//为总部角色统计所有的共维护 同一个业务员
	 		$sql = "Select t1.saleman_id,count(t1.saleman_id) as saleman_id_count,t2.sale_count,IFNULL(t3.sale_count_0,0) as sale_count_01,t4.business_count,t5.business_count_B,t6.business_count_A ,t7.real_name ,t8.username from cs_sign_log as t1 left join (Select saleman_id, intime, count(saleman_id) as sale_count from cs_sign_log where is_today=1 $where1 Group By saleman_id) as t2 on t1.saleman_id=t2.saleman_id left join (Select saleman_id, count(saleman_id) as sale_count_0 from cs_sign_log where is_today=0 $where1 Group By saleman_id) as t3 on t1.saleman_id=t3.saleman_id left join(Select a1.saleman_id, count(a1.saleman_id) as business_count from cs_business as a1 left join cs_sign_log as a2 on a1.busi_id=a2.bus_id where a1.busi_level='C' $where2  Group By a1.saleman_id) as t4 on t4.saleman_id=t1.saleman_id left join(Select a1.saleman_id, count(a1.saleman_id) as business_count_B from cs_business as a1 left join cs_sign_log as a2 on a1.busi_id=a2.bus_id where a1.busi_level='B' $where2  Group By a1.saleman_id) as t5 on t5.saleman_id=t1.saleman_id left join(Select a1.saleman_id, count(a1.saleman_id) as business_count_A from cs_business as a1 left join cs_sign_log as a2 on a1.busi_id=a2.bus_id where a1.busi_level='A' $where2  Group By a1.saleman_id) as t6 on t6.saleman_id=t1.saleman_id left join(Select user_Id,real_name from cs_user) as t7 on t7.user_Id=t1.saleman_id left join(Select username,real_name,user_Id from cs_user) as t8 on t8.user_Id=t1.saleman_id where $condition $where  Group By t1.saleman_id";

			}else{
				$company_id = session('company');
				if ($company_id!='') {
					$condition.=" and t8.company_id='$company_id'";
				}

			 $sql = "Select t1.saleman_id,count(t1.saleman_id) as saleman_id_count,t2.sale_count,IFNULL(t3.sale_count_0,0) as sale_count_01,t4.business_count,t5.business_count_B,t6.business_count_A ,t7.real_name ,t8.username from cs_sign_log as t1 left join (Select saleman_id, intime, count(saleman_id) as sale_count from cs_sign_log where is_today=1 $where1 Group By saleman_id) as t2 on t1.saleman_id=t2.saleman_id left join (Select saleman_id, count(saleman_id) as sale_count_0 from cs_sign_log where is_today=0 $where1 Group By saleman_id) as t3 on t1.saleman_id=t3.saleman_id left join(Select a1.saleman_id, count(a1.saleman_id) as business_count from cs_business as a1 left join cs_sign_log as a2 on a1.busi_id=a2.bus_id where a1.busi_level='C' $where2  Group By a1.saleman_id) as t4 on t4.saleman_id=t1.saleman_id left join(Select a1.saleman_id, count(a1.saleman_id) as business_count_B from cs_business as a1 left join cs_sign_log as a2 on a1.busi_id=a2.bus_id where a1.busi_level='B' $where2  Group By a1.saleman_id) as t5 on t5.saleman_id=t1.saleman_id left join(Select a1.saleman_id, count(a1.saleman_id) as business_count_A from cs_business as a1 left join cs_sign_log as a2 on a1.busi_id=a2.bus_id where a1.busi_level='A' $where2  Group By a1.saleman_id) as t6 on t6.saleman_id=t1.saleman_id left join(Select user_Id,real_name from cs_user) as t7 on t7.user_Id=t1.saleman_id left join(Select username,real_name,user_Id,company_id from cs_user) as t8 on t8.user_Id=t1.saleman_id where $condition  $where  Group By t1.saleman_id";
			
			}
			$res = M()->query($sql);

		$param = I();
		$this->assign('param',$param);
		$this->assign('res',$res);
		$this->assign('res_in',$res_in);
		$this->display();
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}




