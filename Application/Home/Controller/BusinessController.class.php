<?php
//商户控制器
namespace Home\Controller;
use Home\Controller;
class BusinessController extends CommonController
{
	public function index(){
        
    }
	
	//商家列表
    public function business_list(){
		$business = M('business as a');//实例化商家模型
		
		$company_type = session('company_type');
		
		if($company_type == '2'){
			
			$where['a.company_id'] = session('company');
			
		}
		$search_array = array(
			'a.business_id'=>I('business_id'),//商家号
			'a.name'     => I('name'),//商家店名
			'a.businame' => I('businame'),//联系人
			'a.phone'    => I('phone'),//电话
			'a.nikename' => I('nikename'),//微信号
			'real_name'  => I('real_name'),//业务员名字
			'b.username' => I('username'),//业务员工号
			
		);
		
		foreach($search_array as $k=>$v){
			//var_dump($v);
			if($v != ''){
				$where[$k] = array('like',"%$v%");
			}
		}
		
		$genjin = I('genjin');
		if($genjin != null){
			$where['c.status']=$genjin;//跟进情况
			
		}
		
		$count = $business->join('LEFT JOIN `cs_user` as b ON a.saleman_id=b.user_Id')->join('LEFT JOIN `cs_business_follow` as c ON a.follpw_Id=c.follpw_Id')->where($where)->count();//统计所有商家的条数。
		$page = new \Org\Util\Page($count,20);//实例化分页模型
		$show = $page->show();//分页
		
		$businessInfo = $business->field('a.busi_id,a.name,a.businame,a.nikename,a.business_id,a.phone,a.addtime,a.address,a.busi_level,a.busi_type,a.coop_id,a.saleman_id,b.username,b.real_name,c.status as visit_status,c.remarks')->join('LEFT JOIN `cs_user` as b ON a.saleman_id=b.user_Id')->join('LEFT JOIN `cs_business_follow` as c ON a.follpw_Id=c.follpw_Id')->where($where)->order('a.addtime desc')->limit($page->limit[0],$page->limit[1])->select();//查询所有商家数据
		
		foreach($businessInfo as $key=>$val){
			switch($val['visit_status']){
				case 0:
					$businessInfo[$key]['visit_status'] = '<font color="red">未回访</font>';
					break;
				case 1:
					$businessInfo[$key]['visit_status'] = '跟进中';
					break;
				case 2:
					$businessInfo[$key]['visit_status'] = '<font color="green">已回访</font>';
					break;
				default:
					$businessInfo[$key]['visit_status'] = '<font color="red">未回访</font>';
			}
			
		}
		
		
		//var_dump($businessInfo);
		$param = I();
		$this->assign('param',$param);
		$this->assign('businessInfo',$businessInfo);//商家数据
		$this->assign('businessPage',$show);
		$this->display();
	}
	
	//商家列表(导出)
    public function business_list_export(){
		header("Content-type:text/html;charset=utf-8");
		$business = M('business as a');//实例化商家模型
		
		$company_type = session('company_type');
		
		if($company_type == '2'){
			
			$where['a.company_id'] = session('company');
			
		}
		$search_array = array(
			'a.business_id'=>I('business_id'),//商家号
			'a.name'     => I('name'),//商家店名
			'a.businame' => I('businame'),//联系人
			'a.phone'    => I('phone'),//电话
			'a.nikename' => I('nikename'),//微信号
			'real_name'  => I('real_name'),//业务员名字
			'b.username' => I('username'),//业务员工号
			
		);
		
		foreach($search_array as $k=>$v){
			//var_dump($v);
			if($v != ''){
				$where[$k] = array('like',"%$v%");
			}
		}
		
		$genjin = I('genjin');
		if($genjin != null){
			$where['c.status']=$genjin;//跟进情况
			
		}
		
		$businessInfo = $business->field('a.business_id,a.coop_id,a.name,a.businame,a.phone,a.address,a.busi_type,a.busi_level,b.username,b.real_name,a.is_bind,a.status,c.remarks,c.status as visit_status')->join('LEFT JOIN `cs_user` as b ON a.saleman_id=b.user_Id')->join('LEFT JOIN `cs_business_follow` as c ON a.follpw_Id=c.follpw_Id')->where($where)->order('a.addtime desc')->select();//查询所有商家数据
		
		foreach($businessInfo as $key=>$val){
			
			switch($val['is_bind']){
				case 0:
					$businessInfo[$key]['status'] = '禁用';
					break;
				case 1:
					$businessInfo[$key]['status'] = '正常';
					break;
			}
			
			switch($val['status']){
				case 0:
					$businessInfo[$key]['status'] = '禁用';
					break;
				case 1:
					$businessInfo[$key]['status'] = '正常';
					break;
				case 2:
					$businessInfo[$key]['status'] = '待审核';
					break;
				case 3:
					$businessInfo[$key]['status'] = '已拒绝';
					break;
			}
			
			switch($val['busi_type']){
				case 1:
					$businessInfo[$key]['busi_type'] = '门店加盟商';
					break;
				case 2:
					$businessInfo[$key]['busi_type'] = '经销商';
					break;
				case 3:
					$businessInfo[$key]['busi_type'] = '代理商';
					break;
				default:
					$businessInfo[$key]['busi_type'] = '商超连锁';
			}
			
			switch($val['visit_status']){
				case 0:
					$businessInfo[$key]['visit_status'] = '未回访';
					break;
				case 1:
					$businessInfo[$key]['visit_status'] = '跟进中';
					break;
				case 2:
					$businessInfo[$key]['visit_status'] = '已回访';
					break;
				default:
					$businessInfo[$key]['visit_status'] = '未回访';
			}
			
		}
		
		$arr_1 = array('商家号','合同编号','店名','联系人','电话','地址','类型','等级','业务员','业务员姓名','是否绑定','状态','备注','跟进情况');
		
		$arr_2 = array();
		
		$titleArr = parent::bubbling_sort($businessInfo,$arr_1,$arr_2);
		
		$name = '商家列表'.date('Y-m-d H:i:s',time());

		parent::exportexcel($businessInfo,$titleArr,$name);

	}
	
	//禁用商家
/*	public function freezeBusiness(){
		$busi_id = I('busi_id');
		//echo $user_id;exit;
		$data = array(
			'status' => 0
		);
		$rs = M('business')->where("busi_id=$busi_id")->save($data);
		//echo M()->getLastSql();exit;
		if(!$rs){
			$this->error('禁用商家失败','/Home/Business/businessList');
		}else{
			$this->success('禁用商家成功','/Home/Business/businessList');
		}
	}
	
	//解禁商家
	public function unfreezeBusiness(){
		$busi_id = I('busi_id');
		$data = array(
			'status' => 1
		);
		$rs = M('business')->where("busi_id=$busi_id")->save($data);
		if(!$rs){
			$this->error('解冻商家失败','/Home/Business/businessList');
		}else{
			$this->success('解冻商家成功','/Home/Business/businessList');
		}
	}
*/	
	//新增商家页面
	public function add_business(){
		//zy商家业务员的添加与遍历
			//判断根据$_SESSION['company'] 做一个判断如果为1则查询所有业务员，如果为其他则查询其所属的。
			//先做为1的，查询所有的业务员的
			if($_SESSION['company_type']=='1'){
				$sql="SELECT a.user_Id,a.username,a.real_name from `cs_user` as a LEFT JOIN `cs_userrole` as b ON a.user_Id=b.user_Id LEFT JOIN `cs_role` as c ON b.role_Id=c.role_Id WHERE c.role_position=3 and is_use=1 ";
				
				$res=M()->query($sql);

			}else{
				$id = $_SESSION['company'];
				$sql="SELECT a.user_Id,a.username,a.real_name from `cs_user` as a LEFT JOIN `cs_userrole` as b ON a.user_Id=b.user_Id LEFT JOIN `cs_role` as c ON b.role_Id=c.role_Id WHERE c.role_position=3 and is_use=1 and a.company_id=".$id;
				
				$res = M()->query($sql);
			}
			//zy商家业务员的添加与遍历end
		$this->assign('username',$res);
		$this->display();
	}
	
	//新增商家动作
	public function add_busi(){
		if(!IS_POST){
			E('页面不存在!');
		}
		else
		{	
			//zy接收业务员
			$username = I('username');
			$data['saleman_id'] = isset($username)?$username:null;
			
			//zy接收业务员end
			$coop_id = I('coop_id');
			$data['coop_id'] = isset($coop_id)?$coop_id:null;
			
			$name = I('name');
			$data['name'] = isset($name)?$name:null;
			
			$businame = I('businame');
			$data['businame'] = isset($businame)?$businame:null;
			
			$phone = I('phone');
			$data['phone'] = isset($phone)?$phone:null;
			
			$address = I('address');
			$data['address'] =isset($address)?$address:null;
			
			$busi_type = I('busi_type');
			$data['busi_type'] =isset($busi_type)?$busi_type:null;
			
			$busi_level = I('busi_level');
			$data['busi_level'] =isset($busi_level)?$busi_level:null;
			
			//获取随机的商家号
			$data['business_id'] = getRandBusinessId();
			
			$data['addtime'] = time();
			
			$status = I('status');
			$data['status'] =isset($status)?$status:null;

			$saleman_id = M('user')->field('company_id')->where('user_Id='.$data['saleman_id'])->find();

			$data['company_id'] =$saleman_id['company_id'];
			
			$rs = M('business')->data($data)->add();
			if(!$rs){
				$this->error('添加商家失败！','/Home/Business/add_business');
			}else{
				$this->success('恭喜,添加商家成功！','/Home/Business/business_list');
			}
		}
	}
	
	//修改商家|编辑商家 显示页面
	public function update_business(){
		$busi_id = I('busi_id');
		//zy商家业务员的添加与遍历
		//判断根据$_SESSION['company'] 做一个判断如果为1则查询所有业务员，如果为其他则查询其所属的。
		//先做为1的，查询所有的业务员的
		if($_SESSION['company']=='1'){
			$sql = "SELECT a.user_Id,a.username,a.real_name from `cs_user` as a LEFT JOIN `cs_userrole` as b ON a.user_Id=b.user_Id LEFT JOIN `cs_role` as c ON b.role_Id=c.role_Id WHERE c.role_position=3 and is_use=1 ";
				
			$res = M()->query($sql);

		}else{
			$id = $_SESSION['company'];
			$sql="SELECT a.user_Id,a.username,a.real_name from `cs_user` as a LEFT JOIN `cs_userrole` as b ON a.user_Id=b.user_Id LEFT JOIN `cs_role` as c ON b.role_Id=c.role_Id WHERE c.role_position=3 and is_use=1 and a.company_id=".$id;
				
			$res = M()->query($sql);
		}

		//zy商家业务员的添加与遍历end

		$businessInfo = M('business')->where("busi_id=".$busi_id)->find();
		$this->assign('businessInfo',$businessInfo);
		$this->assign('username',$res);
		$this->display();
	}
	
	//修改商家|编辑商家 提交动作
	public function update_busi(){
		if(!IS_POST){
			E('页面不存在!');
		}
		else
		{
			$busi_id = I('busi_id');
			$data['saleman_id'] = I('username');

			$coop_id = I('coop_id');
			$data['coop_id'] = isset($coop_id)?$coop_id:null;
			
			$name = I('name');
			$data['name'] = isset($name)?$name:null;
			
			$businame = I('businame');
			$data['businame'] = isset($businame)?$businame:null;
			
			$phone = I('phone');
			$data['phone'] = isset($phone)?$phone:null;
			
			$address = I('address');
			$data['address'] =isset($address)?$address:null;
			
			$busi_type = I('busi_type');
			$data['busi_type'] =isset($busi_type)?$busi_type:null;
			
			$busi_level = I('busi_level');
			$data['busi_level'] =isset($busi_level)?$busi_level:null;
			

			$saleman_id = M('user')->field('company_id')->where('user_Id='.$data['saleman_id'])->find();

			$data['company_id'] =$saleman_id['company_id'];
			
			$status = I('status');
			$data['status'] =isset($status)?$status:null;

			$rs = M('business')->data($data)->where("busi_id=$busi_id")->save();

			if(!$rs){
				$this->error('修改商家失败！','/Home/Business/update_business/busi_id/'.$busi_id);
			}else{
				$this->success('修改商家成功！','/Home/Business/business_list');
			}
		}
	}
	
//删除商家
	public function del_business(){
	   $busi_id = I('busi_id');
	   $rs = M('business')->where("busi_id=$busi_id")->delete();
	  // echo M()->getLastSql();exit;
	   if(!$rs){
		   $this->error('删除商家失败','/Home/Business/business_list');
	   }else{
		   $this->success('删除商家成功','/Home/Business/business_list');
	   }
	}
	
	
	
//商家审核展示页面
	public function check_business(){
		
		$Model = M('business as a');//实例化商家模型
		
		$name = trim(I('name'));//商家店名
		if($name != ''){
			$where['a.name'] = array('like','%'.$name.'%');
		}
		
		$businame = trim(I('businame'));//商家联系方式
		if($businame != ''){
			$where['a.businame'] = $businame;
		}
		
		$number = trim(I('number'));//业务员工号
		if($number != ''){
			$where['b.username'] = $number;
		}
		
		$audit_status = trim(I('audit_status'));//业务员工号

		if($audit_status > 0){
			
			//判断用户身份（管理员，客服）
			if($_SESSION['role_position'] == 1){
				switch ($audit_status)
				{
					case 1:
						$where['manager_status'] = 2;break;
					case 2:
						$where['manager_status'] = 0;break;
					case 3:
						$where['manager_status'] = 1;break;
				}
		
			}elseif($_SESSION['role_position'] == 2){
				switch ($audit_status)
				{
					case 1:
						$where['service_status'] = 2;break;
					case 2:
						$where['service_status'] = 0;break;
					case 3:
						$where['service_status'] = 1;break;
				}
				
			}
			
		}
		
		
		$startTime = strtotime(trim(I('startTime')));
		$endTime   = strtotime(trim(I('endTime')));
		$date = strtotime( trim(I('endTime')).'23:59:59');
		
		if( $startTime != null && $endTime != null ){
			$where['a.addtime'] = array('between',array($startTime,$date));
		}elseif( $startTime != null && $endTime == null ){
			$where['a.addtime'] = array('egt',$startTime);
		}elseif($startTime == null && $endTime != null ){
			$where['a.addtime'] = array('elt',$endTime);
		}
		
		$where['a.status'] = array('in','2,3');
		
		if( session('role_identity') == 1 ){
			$where['a.company_id'] = $_SESSION['company'];
			
		}
		$role_position = session('role_position');
		
		if( $role_position == 2 ){
			$where['b.ser_uid'] = $_SESSION['userId'];
			
		}elseif( $role_position == 1 ){
			$where['b.manager_uid'] = $_SESSION['userId'];
			
		}

		// 查询满足要求的总记录数
		$count = $Model->field('a.busi_id')->join('`cs_user` as b ON a.saleman_id=b.user_Id')->where($where)->count();
		$Page = new \Org\Util\Page($count,20);//实例化分页模型
		$show  = $Page->show();// 分页显示输出
		
		$rel = $Model->field('a.busi_id,a.name,a.businame,a.business_id,a.phone,a.addtime,a.address,a.busi_type,a.busi_level,a.company_id,manager_status,service_status,a.remark,reason,b.user_Id,b.username,b.real_name,ser_uid,manager_uid')->join('`cs_user` as b ON a.saleman_id=b.user_Id')->limit($Page->limit[0],$Page->limit[1])->where($where)->order('status asc,addtime desc,a.busi_id desc')->select();

		foreach( $rel as $k=>$v ){
			$content_1 = M('busi_check')->field('message')->where(array('busi_id'=>$v['busi_id'],'user_id'=>$v['ser_uid']))->order('id desc')->find();
			
			$content_2 = M('busi_check')->field('message')->where(array('busi_id'=>$v['busi_id'],'user_id'=>$v['manager_uid']))->order('id desc')->find();
			
			$rel[$k]['audit_content_1'] = $content_1['message'];//客服审核的理由
			$rel[$k]['audit_content_2'] = $content_2['message'];//区域经理审核的理由
			
			switch($v['busi_type']){
				case 1:
					$rel[$k]['busi_type'] = '门店加盟商';break;
				case 2:
					$rel[$k]['busi_type'] = '经销商';break;
				case 3:
					$rel[$k]['busi_type'] = '代理商';break;
				case 4:
					$rel[$k]['busi_type'] = '商超连锁';break;
			}
			
			if($role_position == 1){//区域经理审核
				
				if( $v['manager_status'] == 0 ){//如果区域经理未审核
					
					$rel[$k]['button'] = '<a href="javascript:onclick=pitch_on('.$v['busi_id'].');"><span class="btn btn-success btn-mini" style="width:50px;">审核</span></a>';
					
				}elseif( $v['manager_status'] == 1 || ($v['manager_status'] == 2 && $v['service_status'] == 1 ) ){
					
					$rel[$k]['button'] = '<a href="javascript:;"><span class="btn btn-inverse btn-mini" style="width:50px;">已拒绝</span></a>';
					
				}else{
					
					$rel[$k]['button'] = '<a href="javascript:;"><span class="btn btn-warning btn-mini" style="width:50px;">已审核</span></a>';
					
				}
				
			}elseif($role_position == 2){//客服审核
				
				if($v['manager_status'] == 0){//当经理没审核时，客服等待审核
				
					$rel[$k]['button'] = '<a href="javascript:;"><span class="btn btn-warning btn-mini" style="width:50px;">等待审核</span></a>';
					
				}elseif($v['manager_status'] == 1){//当经理拒绝时，客服无法审核
					
					$rel[$k]['button'] = '<a href="javascript:;"><span class="btn btn-inverse btn-mini" style="width:50px;">已拒绝</span></a>';
					
				}elseif($v['manager_status'] == 2 && $v['service_status'] == 0){//当经理同意时，并且客服本身没有审核
					
					$rel[$k]['button'] = '<a href="javascript:onclick=pitch_on('.$v['busi_id'].');"><span class="btn btn-success btn-mini" style="width:50px;">审核</span></a>';
					
				}else{
					
					$rel[$k]['button'] = '<a href="javascript:;"><span class="btn btn-warning btn-mini" style="width:50px;">已审核</span></a>';
					
				}

			}

			
		}
		
		$param = I();
		$this->assign('param',$param);
		$this->assign('role_position',$role_position);
		$this->assign('page',$show);// 赋值分页输出
		$this->assign('result',$rel);
		$this->display();
		
	}
	

	
	
/**
* 
* 说明：本方法为商家审核方法，需要获取操作员user_id，审核的类型（是否同意），售后服务表ID，审核内容等参数
*		方法会自动识别用户的身份（管理员还是客服）
*
*/
	public function check_business_action(){
		$data['data'] = I('data');//审核类型参数（1同意，2拒绝）
		$data['k'] = I('k');	  //商家ID
		$data['m'] = I('area');	  //审核的内容
		$data['user_id']  = $_SESSION['userId']; 	   //操作员ID
		$data['identity'] = $_SESSION['role_position'];//操作员身份

		if($data['k'] == ''){
			echo '参数错误！';
			exit;
		}
		
		$Model = M('business');//实力话商家模型
		
		$rel = $Model->field('status,manager_status,service_status')->where("busi_id='".$data['k']."'")->find();
		
		if($rel['status'] == 1){
			echo "该商户已通过审核！";
			exit;
		}

		if($data['identity'] == 1){     //如果是管理员，则写入管理员字段
		
			if($rel['manager_status'] >= 1){
				echo "您已经审核过了！";
				exit;
			}
			
		}elseif($data['identity'] == 2){//如果是客服，则写入客服字段
		
			if($rel['service_status'] >= 1){
				echo "您已经审核过了！";
				exit;
			}elseif($rel['manager_status'] == 0){
				echo "请等待管理员审核！";
				exit;
				
			}
		
		}else{
			echo "您没有权限！";
			exit;
		}


		$Model->startTrans();//开启事务
		if($data['data'] == 1){//同意
			
			if($data['identity'] == 1){  //如果是管理员，则写入管理员字段
			
				$king['manager_status'] = 2;
				
			}elseif($data['identity'] == 2){//如果是客服，则写入客服字段
			
				$king['business_id'] = getRandBusinessId();
				$king['service_status'] = 2;
				$king['status'] = 1;
				$king['reason'] = '';
				
			}else{
				
				echo "您没有权限！";
				exit;
				
			}
			
			$save_rel = $Model->where("busi_id='".$data['k']."'")->save($king);
		
			if($save_rel){
			
				$serv_data['busi_id']  = $data['k'];
				$serv_data['user_id'] = $data['user_id'];
				$serv_data['check_time'] = time();
				$serv_data['is_pass'] = 1;
				$serv_data['message'] = $data['m'];
				$serv_rel = M('busi_check')->add($serv_data);
			
				if($serv_rel){
					$Model->commit();
					echo '101';
					exit;
				}else{
					$Model->rollback();
					echo "参数错误_2！";
				}
				
			}else{
			
				$Model->rollback();
				echo "参数错误_1！";

			}
			
		}elseif($data['data'] == 2){//拒绝
		
			if($data['identity'] == 1){  //如果是管理员，则写入管理员字段
			
				$king['manager_status'] = 1;//拒绝
				$king['status'] = 3;//拒绝
				
			}elseif($data['identity'] == 2){//如果是客服，则写入客服字段
			
				$king['service_status'] = 1;//拒绝
				$king['status'] = 3;//拒绝
				
			}else{
				
				echo "您没有权限！";
				exit;
				
			}
		
			$save_rel = $Model->where("busi_id='".$data['k']."'")->save($king);
		
			if($save_rel){
			
				$serv_data['busi_id']  = $data['k'];
				$serv_data['user_id'] = $data['user_id'];
				$serv_data['check_time'] = time();
				$serv_data['is_pass'] = 2;
				$serv_data['message'] = $data['m'];
				$serv_rel = M('busi_check')->add($serv_data);
				
				if($serv_rel){
					$Model->commit();
					echo '102';
					exit;
				}else{
					$Model->rollback();
					echo "参数错误_2！";
				}
			
			}else{
			
				$Model->rollback();
				echo "参数错误_1！";
			
			}
		
		}else{
			echo "出错了！";
		}
		
	}
	
	
	
	//批量更换业务员页面展示
	public function change_saleman(){
		
		$data = array(
			'username'=>trim(I('number')),
			'business_id'=>trim(I('business_id'))
		);
		
		foreach($data as $k=>$v){
			if($v != NULL){
				$where[$k]=$v;
			}
		}
		
		$Model = M('business as a');

		if($_SESSION['role_identity'] == 1){
			
			$where['a.company_id'] =$_SESSION['company'];
		}
		
		$rel = $Model->field('busi_id,business_id,coop_id,name,businame,phone,address,busi_type,busi_level,is_bind,status,username,real_name')->join('LEFT JOIN cs_user as b ON a.saleman_id=b.user_Id')->where($where)->order('a.addtime desc')->select();
	
		foreach($rel as $k=>$v){
			switch($v['busi_type']){
				case 1:
					$rel[$k]['busi_type'] = '门店加盟商';break;
				
				case 2:
					$rel[$k]['busi_type'] = '经销商';    break;
				
				case 3:
					$rel[$k]['busi_type'] = '代理商';	 break;
				
				case 4:
					$rel[$k]['busi_type'] = '商超连锁';	 break;
			}
		}
		
		$param = I();
		$salemanList = $this->get_salesman();//获取业务员列表
		$this->assign('param',$param);
		$this->assign('saleman',$salemanList);
		$this->assign('business',$rel);
		$this->display();
	}
	
	
	//批量更换业务员操作
	public function saleman_change(){
		$busi_id = I('busi_id');//接收商家参数
		if( count($busi_id) == 0 ){
			$this->error("请先选择商家!");
		}
		
		$busi_id = implode(',',$busi_id);

		$data = I('saleman');//接收业务员参数
		
		$data_array = explode('/',$data);


		
		if( count($data_array) <= 1 ){
			$this->error("出错啦，请检查业务员状态!");
			
		}
		
		$sql = "UPDATE `cs_business` set saleman_id='".$data_array['0']."',company_id='".$data_array['1']."' WHERE busi_id in(".$busi_id.")" ;
		
		$result = M()->execute($sql);

		if($result>0){
			$this->success("修改成功！");
			
		}else{
			$this->error("修改失败！");
			
		};
		
		
	}
	
	
	
	
	
	
	
}





