<?php
/*维护控制器*/
namespace Home\Controller;
//use Home\Controller;
use Think\Controller;
class KeepController extends CommonController
{
	public function index(){
		$this->display();
	}
	
	private function product(){
		$pro_rel = M('pro')->field('id,names')->where('sort2>0')->select();//查询出所有产品
		return $pro_rel;
	}
	
	//铺货(管理)列表
	public function show_goods(){
		
		$data['business_id'] = trim(I('business_id'));
		$data['goods_name'] = trim(I('goods_name'));
		$data['real_name']  = trim(I('real_name'));
		$data['username'] 	= trim(I('saleman_id'));
		$data['name'] 	= trim(I('name'));
		
		foreach($data as $k=>$v){
			if(!empty($v)){
				$where[$k] = $v;
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
		
		$busModel = M('business as a');
		
		if($_SESSION['role_identity'] == 1){
			$where['a.company_id'] = $_SESSION['company'];
		}
		
		$where['a.goods_ext'] = array('neq','');
		
		// 查询满足要求的总记录数
		$count      = $busModel->field('a.id')->join('cs_user as b ON a.saleman_id=b.user_Id')->where($where)->count();
		$Page 		= new \Org\Util\Page($count,20);
		$show       = $Page->show();
		$rel 		= $busModel->field('a.busi_id,name,businame,business_id,phone,a.addtime,address,busi_level,busi_type,goods_ext,a.remark,b.username,b.real_name')->join('cs_user as b ON a.saleman_id=b.user_Id')->where($where)->limit($Page->limit[0],$Page->limit[1])->order('user_Id desc')->select();

		$seachParam = I();
		$this->assign('param',$seachParam);
		$this->assign('page',$show);
		$this->assign('result',$rel);
		$this->display();
		
	}
	
	
	//铺货(管理)导出
	public function show_goods_export(){
		header("Content-type:text/html;charset=utf-8");
		$data['business_id'] = trim(I('business_id'));
		$data['goods_name'] = trim(I('goods_name'));
		$data['real_name']  = trim(I('real_name'));
		$data['username'] 	= trim(I('saleman_id'));
		$data['name'] 	= trim(I('name'));
		
		foreach($data as $k=>$v){
			if(!empty($v)){
				$where[$k] = $v;
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
		if($_SESSION['role_identity'] == 1){
			$where['a.company_id'] = $_SESSION['company'];
		}
		$where['a.goods_ext'] = array('neq','');

		// 查询满足要求的总记录数
		$bus_rel = M('business as a')->field('busi_id,name,a.business_id,b.real_name,b.username,FROM_UNIXTIME(a.addtime,"%Y-%m-%d %H:%i:%s") as addtime,a.reason,c.type,pro_id')->join('cs_user as b ON a.saleman_id=b.user_Id')->join(' LEFT JOIN `cs_business_pro` as c ON a.busi_id=c.business_id ')->where($where)->order('user_Id desc')->select();
		
		$pro_rel = $this->product();//查询出所有产品
		dump($pro_rel);exit;
		$temp = array();
		$i = 0;
		foreach($bus_rel as $key=>$val){
			
			foreach($pro_rel as $k=>$v){
				
				if( $temp[ $val['busi_id'] ] ){
					
				}
				
				
				
			}
			
			
			
		}
		exit;
		
		$title = array('商家店名','商家号','业务员姓名','工号','铺货时间','备注');
		$name = '铺货列表'.date('Y-m-d H:i:s',time());
		$this->exportexcel($rel,$title,$name);

	}

	
	//补货(管理)列表
	public function add_goods(){
		$data['b.business_id'] = trim(I('business_id'));
		$data['goods_name'] = trim(I('goods_name'));
		$data['real_name']  = trim(I('real_name'));
		$data['username'] 	= trim(I('saleman_id'));
		$data['b.name'] 	= trim(I('name'));
		$data['serv_type']  = 1;//1标识为补货
		foreach($data as $k=>$v){
			if(!empty($v)){
				$where[$k] = $v;
			}
		}

		$startTime = strtotime(trim(I('startTime')));
		$endTime   = strtotime(trim(I('endTime')));
		$date = strtotime( trim(I('endTime')).'23:59:59');
		
		if( $startTime != null && $endTime != null ){
			$where['a.add_time'] = array('between',array($startTime,$date));
		}elseif( $startTime != null && $endTime == null ){
			$where['a.add_time'] = array('egt',$startTime);
		}elseif($startTime == null && $endTime != null ){
			$where['a.add_time'] = array('elt',$endTime);
		}
		
		if($_SESSION['role_identity'] == 1){
			$where['b.company_id'] = $_SESSION['company'];
			
		}
		
		$customerModel = M('customer_service as a');
		
		$count      = $customerModel->field('a.id')->join('cs_business as b ON a.busi_id=b.busi_id')->join('cs_user as c ON a.saleman_id=c.user_Id')->where($where)->count();// 查询满足要求的总记录数
			
		$Page 		= new \Org\Util\Page($count,20);
			
		$show       = $Page->show();// 分页显示输出 c.number,
			
		$rel = $customerModel->field('a.*,b.business_id,b.name,c.username,c.real_name,a.manager_status,a.service_status')->join('cs_business as b ON a.busi_id=b.busi_id')->join('cs_user as c ON a.saleman_id=c.user_Id')->where($where)->order('add_time desc')->limit($Page->limit[0],$Page->limit[1])->select();
		

		$param = I();
		$this->assign('param',$param);
		$this->assign('page',$show);// 赋值分页输出
		$this->assign('result',$rel);
		$this->display();
	}
	
	//补货(管理)列表(导出)
	public function add_goods_export(){
		header("Content-type:text/html;charset=utf-8");
		$data['b.business_id'] = trim(I('business_id'));
		$data['goods_name'] = trim(I('goods_name'));
		$data['real_name']  = trim(I('real_name'));
		$data['username'] 	= trim(I('saleman_id'));
		$data['b.name'] 	= trim(I('name'));
		$data['serv_type']  = 1;//1标识为补货
		foreach($data as $k=>$v){
			if(!empty($v)){
				$where[$k] = $v;
			}
		}

		$startTime = strtotime(trim(I('startTime')));
		$endTime   = strtotime(trim(I('endTime')));
		$date = strtotime( trim(I('endTime')).'23:59:59');
		
		if( $startTime != null && $endTime != null ){
			$where['a.add_time'] = array('between',array($startTime,$date));
		}elseif( $startTime != null && $endTime == null ){
			$where['a.add_time'] = array('egt',$startTime);
		}elseif($startTime == null && $endTime != null ){
			$where['a.add_time'] = array('elt',$endTime);
		}
		
		if($_SESSION['role_identity'] == 1){
			$where['b.company_id'] = $_SESSION['company'];
			
		}
		
		$customerModel = M('customer_service as a');
		
		$rel = $customerModel->field('b.name,b.business_id,c.username,c.real_name,a.reason,a.add_time,a.id,d.pro_id,d.predict_num,d.convert_num,d.practical_num')->join('cs_business as b ON a.busi_id=b.busi_id')->join('cs_user as c ON a.saleman_id=c.user_Id')->join('LEFT JOIN `cs_customer_pro` as d ON d.customer_id=a.id')->where($where)->order('add_time desc')->select();
		
		$pro_rel = $this->product();//查询出所有产品
		$temp = array();
		$i = 0;
		foreach( $rel as $key=>$val){
		
			//dump($val['pro_id']);
			
			foreach( $pro_rel as $k=>$v){
				
				if($val['pro_id'] == $v['id'] ){
					
					if( $temp[$val['id']] == null ){
						$i = 0;
						$temp[$val['id']] = $val;
						$temp[$val['id']]['pro_name_'.$i] = $v['names'];
						//$temp[$val['id']]['pro_id_'.$i] = $val['pro_id'];
						$temp[$val['id']]['predict_num_'.$i] = $val['predict_num'];
						$temp[$val['id']]['convert_num_'.$i] = $val['convert_num'];
						$temp[$val['id']]['practical_num_'.$i] = $val['practical_num'];
						
					}else{
						$temp[$val['id']]['pro_name_'.$i] = $v['names'];
						//$temp[$val['id']]['pro_id_'.$i] = $val['pro_id'];
						$temp[$val['id']]['predict_num_'.$i] = $val['predict_num'];
						$temp[$val['id']]['convert_num_'.$i] = $val['convert_num'];
						$temp[$val['id']]['practical_num_'.$i] = $val['practical_num'];
						
					}
					$i++;
				}
				
				
			}
			
			unset($temp[$val['id']]['id']);
			unset($temp[$val['id']]['pro_id']);
			unset($temp[$val['id']]['predict_num']);
			unset($temp[$val['id']]['convert_num']);
			unset($temp[$val['id']]['practical_num']);
			
			
		}
		
		sort($temp);
		
		$arr_1 = array('商家店名','商家号','业务员工号','姓名','备注','铺货时间');
		$arr_2 = array('补货数量','兑换数量','实际送货量');
		
		$titleArr = parent::bubbling_sort($temp,$arr_1,$arr_2);
		
		$name = '补货列表'.date('Y-m-d H:i:s',time());

		parent::exportexcel($temp,$titleArr,$name);
		

	}
	
	

	//退货(管理)列表
	public function return_goods(){
		$data['b.business_id'] = trim(I('business_id'));
		$data['goods_name'] = trim(I('goods_name'));
		$data['real_name']  = trim(I('real_name'));
		$data['username'] 	= trim(I('saleman_id'));
		$data['b.name'] 	= trim(I('name'));
		$data['serv_type']  = 2;//2标识为退货
		foreach($data as $k=>$v){
			if(!empty($v)){
				$where[$k] = $v;
			}
		}
		$startTime = strtotime(trim(I('startTime')));
		$endTime   = strtotime(trim(I('endTime')));
		$date 	   = strtotime( trim(I('endTime')).'23:59:59');
		
		if( $startTime != null && $endTime != null ){
			$where['a.add_time'] = array('between',array($startTime,$date));
			
		}elseif( $startTime != null && $endTime == null ){
			$where['a.add_time'] = array('egt',$startTime);
			
		}elseif($startTime == null && $endTime != null ){
			$where['a.add_time'] = array('elt',$endTime);
			
		}
		
		if($_SESSION['role_identity'] == 1){
			$where['b.company_id'] = $_SESSION['company'];
			
		}
		
		$role_position = session('role_position');
		if( $role_position == 2 ){
			$where['ser_uid'] = $_SESSION['userId'];
			
		}elseif( $role_position == 1 ){
			$where['manager_uid'] = $_SESSION['userId'];
			
		}
		
		$customerModel = M('customer_service as a');//实例化模型
		
		$count  = $customerModel->field('a.id')->join('cs_business as b ON a.busi_id=b.busi_id')->join('cs_user as c ON a.saleman_id=c.user_Id')->where($where)->count();// 查询满足要求的总记录数
	
		$Page   = new \Org\Util\Page($count,20);
	
		$show   = $Page->show();// 分页显示输出
	
		$rel = $customerModel->field('a.*,b.business_id,b.name,c.username,c.real_name,c.ser_uid,c.manager_uid,a.manager_status,a.service_status')->join('cs_business as b ON a.busi_id=b.busi_id')->join('cs_user as c ON a.saleman_id=c.user_Id')->where($where)->order('add_time desc')->limit($Page->limit[0],$Page->limit[1])->select();
	
		foreach( $rel as $k=>$v ){
			$message_1 = M('serv_check')->field('message')->where(array('ser_id'=>$v['id'],'user_id'=>$v['ser_uid']))->order('Id desc')->find();
			$message_2 = M('serv_check')->field('message')->where(array('ser_id'=>$v['id'],'user_id'=>$v['manager_uid']))->order('Id desc')->find();
			$rel[$k]['message_1'] = $message_1['message'];
			$rel[$k]['message_2'] = $message_2['message'];
			
			if($_SESSION['role_position'] == 1){//如果是区域经理
				
				if($v['manager_status'] == 0 && $v['service_status'] == 0){
					$rel[$k]['button'] = '<a href="javascript:onclick=pitch_on('.$v['id'].');"><span class="btn btn-success btn-mini" style="width:50px;">审核</span></a>';
				}else{
					$rel[$k]['button'] = '<a href="javascript:;"><span class="btn btn-warning btn-mini" style="width:50px;">已审核</span></a>';
				}
				
			}elseif($_SESSION['role_position'] == 2){//如果是客服

				if($v['manager_status'] == 0){//当经理没审核时，客服等待审核
				
					$rel[$k]['button'] = '<a href="javascript:;"><span class="btn btn-warning btn-mini" style="width:50px;">等待审核</span></a>';
					
				}elseif($v['manager_status'] == 1){//当经理拒绝时，客服无法审核
					
					$rel[$k]['button'] = '<a href="javascript:;"><span class="btn btn-inverse btn-mini" style="width:50px;">审核</span></a>';
					
				}elseif($v['manager_status'] == 2 && $v['service_status'] == 0){//当经理同意时，并且客服本身没有审核
					
					$rel[$k]['button'] = '<a href="javascript:onclick=pitch_on('.$v['id'].');"><span class="btn btn-success btn-mini" style="width:50px;">审核</span></a>';
					
				}else{
					
					$rel[$k]['button'] = '<a href="javascript:;"><span class="btn btn-warning btn-mini" style="width:50px;">已审核</span></a>';
					
				}
				
			}
		
			
		}

		$param = I();
		// var_dump($rel);exit;
		$this->assign('param',$param);
		$this->assign('page',$show);// 赋值分页输出
		$this->assign('result',$rel);
		$this->display();
	}
	
	//退货(管理)列表(导出)
	public function return_goods_export(){
		header("Content-type:text/html;charset=utf-8");
		$data['b.business_id'] = trim(I('business_id'));
		$data['goods_name'] = trim(I('goods_name'));
		$data['real_name']  = trim(I('real_name'));
		$data['username'] 	= trim(I('saleman_id'));
		$data['b.name'] 	= trim(I('name'));
		$data['serv_type']  = 2;//2标识为退货
		foreach($data as $k=>$v){
			if(!empty($v)){
				$where[$k] = $v;
			}
		}
		$startTime = strtotime(trim(I('startTime')));
		$endTime   = strtotime(trim(I('endTime')));
		$date 	   = strtotime( trim(I('endTime')).'23:59:59');
		
		if( $startTime != null && $endTime != null ){
			$where['a.add_time'] = array('between',array($startTime,$date));
			
		}elseif( $startTime != null && $endTime == null ){
			$where['a.add_time'] = array('egt',$startTime);
			
		}elseif($startTime == null && $endTime != null ){
			$where['a.add_time'] = array('elt',$endTime);
			
		}
		
		if($_SESSION['role_identity'] == 1){
			$where['b.company_id'] = $_SESSION['company'];
			
		}
		
		$role_position = session('role_position');
		if( $role_position == 2 ){
			$where['ser_uid'] = $_SESSION['userId'];
			
		}elseif( $role_position == 1 ){
			$where['manager_uid'] = $_SESSION['userId'];
			
		}
		
		$customerModel = M('customer_service as a');//实例化模型

		$rel = $customerModel->field('b.name,b.business_id,c.username,c.real_name,a.reason,a.add_time,d.pro_id,d.practical_num,a.id,a.status,c.ser_uid,c.manager_uid')->join('cs_business as b ON a.busi_id=b.busi_id')->join('cs_user as c ON a.saleman_id=c.user_Id')->join('LEFT JOIN `cs_customer_pro` as d ON d.customer_id=a.id')->where($where)->order('add_time desc')->select();
	
		foreach( $rel as $k=>$v ){
			$message_1 = M('serv_check')->field('message')->where(array('ser_id'=>$v['id'],'user_id'=>$v['ser_uid']))->order('Id desc')->find();
			$message_2 = M('serv_check')->field('message')->where(array('ser_id'=>$v['id'],'user_id'=>$v['manager_uid']))->order('Id desc')->find();
			$rel[$k]['message_1'] = $message_1['message'];
			$rel[$k]['message_2'] = $message_2['message'];
		}

		$pro_rel = $this->product();//查询出所有产品
		$temp = array();
		$i = 0;
		foreach( $rel as $key=>$val){
		
			//dump($val['pro_id']);
			
			foreach( $pro_rel as $k=>$v){
				
				if($val['pro_id'] == $v['id'] ){
					
					if( $temp[$val['id']] == null ){
						$i = 0;
						$temp[$val['id']] = $val;
						$temp[$val['id']]['pro_name_'.$i] = $v['names'];
						//$temp[$val['id']]['pro_id_'.$i] = $val['pro_id'];
						//$temp[$val['id']]['predict_num_'.$i] = $val['predict_num'];
						//$temp[$val['id']]['convert_num_'.$i] = $val['convert_num'];
						$temp[$val['id']]['practical_num_'.$i] = $val['practical_num'];
						
					}else{
						$temp[$val['id']]['pro_name_'.$i] = $v['names'];
						//$temp[$val['id']]['pro_id_'.$i] = $val['pro_id'];
						//$temp[$val['id']]['predict_num_'.$i] = $val['predict_num'];
						//$temp[$val['id']]['convert_num_'.$i] = $val['convert_num'];
						$temp[$val['id']]['practical_num_'.$i] = $val['practical_num'];
						
					}
					$i++;
				}
				
				
			}
			
			unset($temp[$val['id']]['id']);
			unset($temp[$val['id']]['pro_id']);
			unset($temp[$val['id']]['status']);
			unset($temp[$val['id']]['ser_uid']);
			unset($temp[$val['id']]['manager_uid']);
			unset($temp[$val['id']]['practical_num']);
			
			
		}
		
		sort($temp);
		
		$arr_1 = array('商家店名','商家号','业务员工号','姓名','退货原因','退货时间','经理审核理由','客服审核理由');
		
		$arr_2 = array('退货数量');
		
		$titleArr = parent::bubbling_sort($temp,$arr_1,$arr_2);
		
		$name = '退货列表'.date('Y-m-d H:i:s',time());

		parent::exportexcel($temp,$titleArr,$name);


	}
	
	
	
	
	

/**
* 
* 说明：本方法为退货审核方法，需要获取操作员user_id，审核的类型（是否同意），售后服务表ID，审核内容等参数
*		方法会自动识别用户的身份（管理员还是客服）
*
*/
	public function quit_goods(){

		$data['data'] = I('data');//审核类型参数（1同意，2拒绝）
		$data['k'] = I('k');	  //售后服务表ID
		$data['m'] = I('area');	  //审核的内容
		$data['user_id']  = $_SESSION['userId']; 	   //操作员ID
		$data['identity'] = $_SESSION['role_position'];//操作员身份
		
		if($data['k'] == ''){
			echo '参数错误！';
			exit;
		}
		
		$Model = M('customer_service');
		
		$rel = $Model->field('serv_type,manager_status,service_status')->where("id='".$data['k']."'")->find();
		
		if($rel['serv_type'] != 2){
			echo "参数错误！";
			exit;
		}

		if($data['identity'] == 1){  //如果是管理员，则写入管理员字段
		
			if($rel['manager_status'] >= 1){
				echo "您已经审核过了！";
				exit;
			}
			
		}elseif($data['identity'] == 2){//如果是客服，则写入客服字段
		
			if($rel['service_status'] >= 1){
				echo "您已经审核过了！";
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
			
				$king['status'] = 1;
				$king['service_status'] = 2;
				
			}else{
				
				echo "您没有权限！";
				exit;
				
			}
			
			$save_rel = $Model->where("id='".$data['k']."'")->save($king);
		
			if($save_rel){
			
				$serv_data['ser_id']  = $data['k'];
				$serv_data['user_id'] = $data['user_id'];
				$serv_data['check_time'] = time();
				$serv_data['is_pass'] = 1;
				$serv_data['message'] = $data['m'];
				$serv_rel = M('serv_check')->add($serv_data);
			
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
				
				$king['status'] = 2;//拒绝
				$king['manager_status'] = 1;//拒绝
				
				
			}elseif($data['identity'] == 2){//如果是客服，则写入客服字段
			
				$king['status'] = 2;//拒绝
				$king['service_status'] = 1;//拒绝
				
			}else{
				
				echo "您没有权限！";
				exit;
				
			}
		
			$save_rel = $Model->where("id='".$data['k']."'")->save($king);
		
			if($save_rel){			
				$serv_data['ser_id']  = $data['k'];
				$serv_data['user_id'] = $data['user_id'];
				$serv_data['check_time'] = time();
				$serv_data['is_pass'] = 2;
				$serv_data['message'] = $data['m'];
				$serv_rel = M('serv_check')->add($serv_data);
				
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
			
		}
		
	}
	
	
	
	//换货(管理)列表
	public function change_goods(){
		$data['b.business_id'] = trim(I('business_id'));
		$data['goods_name'] = trim(I('goods_name'));
		$data['real_name']  = trim(I('real_name'));
		$data['username'] 	= trim(I('saleman_id'));
		$data['b.name'] 	= trim(I('name'));
		
		foreach($data as $k=>$v){
			if(!empty($v)){
				$where[$k] = array('like',"%$v%");
			}
		}
		$where['serv_type']  = 3;//3标识为退货
		
		$startTime = strtotime(trim(I('startTime')));
		$endTime   = strtotime(trim(I('endTime')));
		$date 	   = strtotime( trim(I('endTime')).'23:59:59');
		
		if( $startTime != null && $endTime != null ){
			$where['a.add_time'] = array('between',array($startTime,$date));
			
		}elseif( $startTime != null && $endTime == null ){
			$where['a.add_time'] = array('egt',$startTime);
			
		}elseif($startTime == null && $endTime != null ){
			$where['a.add_time'] = array('elt',$endTime);
			
		}
		
		if($_SESSION['role_identity'] == 1){//如果是分部人员
			$where['b.company_id'] = $_SESSION['company'];
		}
		
		$role_position = session('role_position');//接收角色的身份
		if( $role_position == 2 ){//如果客服人员
			$where['ser_uid'] = $_SESSION['userId'];
			
		}elseif( $role_position == 1 ){//如果是区域经理
			$where['manager_uid'] = $_SESSION['userId'];
			
		}
		
		$customerModel = M('customer_service as a');//实例化模型
		
		$count      = $customerModel->field('a.id')->join('cs_business as b ON a.busi_id=b.busi_id')->join('cs_user as c ON a.saleman_id=c.user_Id')->where($where)->count();// 查询满足要求的总记录数
			
		$Page   	= new \Org\Util\Page($count,20);
			
		$show       = $Page->show();// 分页显示输出 c.number,

		$rel = $customerModel->field('a.*,b.business_id,b.name,c.username,c.real_name,a.manager_status,a.service_status,ser_uid,manager_uid')->join('cs_business as b ON a.busi_id=b.busi_id')->join('cs_user as c ON a.saleman_id=c.user_Id')->where($where)->order('add_time desc')->limit($Page->limit[0],$Page->limit[1])->select();
		
		foreach( $rel as $k=>$v ){
			
			$message_1 = M('serv_check')->field('message')->where(array('ser_id'=>$v['id'],'user_id'=>$v['ser_uid']))->order('Id desc')->find();
			$message_2 = M('serv_check')->field('message')->where(array('ser_id'=>$v['id'],'user_id'=>$v['manager_uid']))->order('Id desc')->find();
			$rel[$k]['message_1'] = $message_1['message'];
			$rel[$k]['message_2'] = $message_2['message'];
			
			if($_SESSION['role_position'] == 1){
				
				if($v['manager_status'] == 0 && $v['service_status'] == 0){
					$rel[$k]['button'] = '<a href="javascript:onclick=pitch_on('.$v['id'].');"><span class="btn btn-success btn-mini" style="width:50px;">审核</span></a>';
				}else{
					$rel[$k]['button'] = '<a href="javascript:;"><span class="btn btn-warning btn-mini" style="width:50px;">已审核</span></a>';
				}
				
			}elseif($_SESSION['role_position'] == 2){
				
				if($v['manager_status'] == 0){//当经理没审核时，客服等待审核
				
					$rel[$k]['button'] = '<a href="javascript:;"><span class="btn btn-warning btn-mini" style="width:50px;">等待审核</span></a>';
					
				}elseif($v['manager_status'] == 1){//当经理拒绝时，客服无法审核
					
					$rel[$k]['button'] = '<a href="javascript:;"><span class="btn btn-inverse btn-mini" style="width:50px;">审核</span></a>';
					
				}elseif($v['manager_status'] == 2 && $v['service_status'] == 0){//当经理同意时，并且客服本身没有审核
					
					$rel[$k]['button'] = '<a href="javascript:onclick=pitch_on('.$v['id'].');"><span class="btn btn-success btn-mini" style="width:50px;">审核</span></a>';
					
				}else{
					
					$rel[$k]['button'] = '<a href="javascript:;"><span class="btn btn-warning btn-mini" style="width:50px;">已审核</span></a>';
					
				}

			}
		
			
		}
		$param = I();
		$this->assign('param',$param);
		$this->assign('page',$show);// 赋值分页输出
		$this->assign('result',$rel);
		$this->display();
	
	}
	
	
	//换货(管理)列表
	public function change_goods_export(){
		header("Content-type:text/html;charset=utf-8");
		$data['b.business_id'] = trim(I('business_id'));
		$data['goods_name'] = trim(I('goods_name'));
		$data['real_name']  = trim(I('real_name'));
		$data['username'] 	= trim(I('saleman_id'));
		$data['b.name'] 	= trim(I('name'));
		
		foreach($data as $k=>$v){
			if(!empty($v)){
				$where[$k] = array('like',"%$v%");
			}
		}
		$where['serv_type']  = 3;//3标识为换货
		
		$startTime = strtotime(trim(I('startTime')));
		$endTime   = strtotime(trim(I('endTime')));
		$date 	   = strtotime( trim(I('endTime')).'23:59:59');
		
		if( $startTime != null && $endTime != null ){
			$where['a.add_time'] = array('between',array($startTime,$date));
			
		}elseif( $startTime != null && $endTime == null ){
			$where['a.add_time'] = array('egt',$startTime);
			
		}elseif($startTime == null && $endTime != null ){
			$where['a.add_time'] = array('elt',$endTime);
			
		}
		
		if($_SESSION['role_identity'] == 1){//如果是分部人员
			$where['b.company_id'] = $_SESSION['company'];
		}
		
		$role_position = session('role_position');//接收角色的身份
		if( $role_position == 2 ){//如果客服人员
			$where['ser_uid'] = $_SESSION['userId'];
			
		}elseif( $role_position == 1 ){//如果是区域经理
			$where['manager_uid'] = $_SESSION['userId'];
			
		}
		
		$customerModel = M('customer_service as a');//实例化模型
		
		//$rel = $customerModel->field('a.*,b.business_id,b.name,c.username,c.real_name,a.manager_status,a.service_status,ser_uid,manager_uid')->join('cs_business as b ON a.busi_id=b.busi_id')->join('cs_user as c ON a.saleman_id=c.user_Id')->where($where)->order('add_time desc')->select();
		
		$rel = $customerModel->field('b.name,b.business_id,c.username,c.real_name,a.reason,a.add_time,d.pro_id,d.practical_num,a.id,a.status,c.ser_uid,c.manager_uid')->join('cs_business as b ON a.busi_id=b.busi_id')->join('cs_user as c ON a.saleman_id=c.user_Id')->join('LEFT JOIN `cs_customer_pro` as d ON d.customer_id=a.id')->where($where)->order('add_time desc')->select();
		
		
		foreach( $rel as $k=>$v ){
			
			$message_1 = M('serv_check')->field('message')->where(array('ser_id'=>$v['id'],'user_id'=>$v['ser_uid']))->order('Id desc')->find();
			$message_2 = M('serv_check')->field('message')->where(array('ser_id'=>$v['id'],'user_id'=>$v['manager_uid']))->order('Id desc')->find();
			$rel[$k]['message_1'] = $message_1['message'];
			$rel[$k]['message_2'] = $message_2['message'];

		}
		
		$pro_rel = $this->product();//查询出所有产品
		$temp = array();
		$i = 0;
		foreach( $rel as $key=>$val){
		
			//dump($val['pro_id']);
			
			foreach( $pro_rel as $k=>$v){
				
				if($val['pro_id'] == $v['id'] ){
					
					if( $temp[$val['id']] == null ){
						$i = 0;
						$temp[$val['id']] = $val;
						$temp[$val['id']]['pro_name_'.$i] = $v['names'];
						//$temp[$val['id']]['pro_id_'.$i] = $val['pro_id'];
						//$temp[$val['id']]['predict_num_'.$i] = $val['predict_num'];
						//$temp[$val['id']]['convert_num_'.$i] = $val['convert_num'];
						$temp[$val['id']]['practical_num_'.$i] = $val['practical_num'];
						
					}else{
						$temp[$val['id']]['pro_name_'.$i] = $v['names'];
						//$temp[$val['id']]['pro_id_'.$i] = $val['pro_id'];
						//$temp[$val['id']]['predict_num_'.$i] = $val['predict_num'];
						//$temp[$val['id']]['convert_num_'.$i] = $val['convert_num'];
						$temp[$val['id']]['practical_num_'.$i] = $val['practical_num'];
						
					}
					$i++;
				}
				
				
			}
			
			unset($temp[$val['id']]['id']);
			unset($temp[$val['id']]['pro_id']);
			unset($temp[$val['id']]['status']);
			unset($temp[$val['id']]['ser_uid']);
			unset($temp[$val['id']]['manager_uid']);
			unset($temp[$val['id']]['practical_num']);
			
			
		}
		
		sort($temp);
		
		$arr_1 = array('商家店名','商家号','业务员工号','姓名','换货原因','换货时间','经理审核理由','客服审核理由');
		
		$arr_2 = array('换货数量');
		
		$titleArr = parent::bubbling_sort($temp,$arr_1,$arr_2);
		
		$name = '换货列表'.date('Y-m-d H:i:s',time());

		parent::exportexcel($temp,$titleArr,$name);
		

	}

	
/**
* 
* 说明：本方法为退货审核方法，需要获取操作员user_id，审核的类型（是否同意），售后服务表ID，审核内容等参数
*		方法会自动识别用户的身份（管理员还是客服）
*
*/
	public function change_goods_audit(){

		$data['data'] = I('data');//审核类型参数（1同意，2拒绝）
		$data['k'] = I('k');	  //售后服务表ID
		$data['m'] = I('area');	  //审核的内容
		$data['user_id']  = $_SESSION['userId']; 	   //操作员ID
		$data['identity'] = $_SESSION['role_position'];//操作员身份
		if($data['k'] == ''){
			echo '参数错误！';
			exit;
		}
		
		$Model = M('customer_service');
		
		$rel = $Model->field('serv_type,manager_status,service_status')->where("id='".$data['k']."'")->find();

		if($rel['serv_type'] != 3){
			echo "参数错误！";
			exit;
		}

		if($data['identity'] == 1){  //如果是管理员，则写入管理员字段
		
			if($rel['manager_status'] >= 1){
				echo "您已经审核过了！";
				exit;
			}
			
		}elseif($data['identity'] == 2){//如果是客服，则写入客服字段
		
			if($rel['service_status'] >= 1){
				echo "您已经审核过了！";
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
			
				$king['status'] = 1;
				$king['service_status'] = 2;
				
			}else{
				
				echo "您没有权限！";
				exit;
				
			}
			
			$save_rel = $Model->where("id='".$data['k']."'")->save($king);
		
			if($save_rel){
			
				$serv_data['ser_id']  = $data['k'];
				$serv_data['user_id'] = $data['user_id'];
				$serv_data['check_time'] = time();
				$serv_data['is_pass'] = 1;
				$serv_data['message'] = $data['m'];
				$serv_rel = M('serv_check')->add($serv_data);
			
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
			
				$king['status'] = 2;//拒绝
				$king['manager_status'] = 1;//拒绝
				
			}elseif($data['identity'] == 2){//如果是客服，则写入客服字段
			
				$king['status'] = 2;//拒绝
				$king['service_status'] = 1;//拒绝
				
			}else{
				
				echo "您没有权限！";
				exit;
				
			}
		
			$save_rel = $Model->where("id='".$data['k']."'")->save($king);
		
			if($save_rel){
			
				$serv_data['ser_id']  = $data['k'];
				$serv_data['user_id'] = $data['user_id'];
				$serv_data['check_time'] = time();
				$serv_data['is_pass'] = 2;
				$serv_data['message'] = $data['m'];
				$serv_rel = M('serv_check')->add($serv_data);
				
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
	
	
	//ajax查看商品ajax_pitch_on1 曾洋 2017年6月6日16:28:38
	public function ajax_pitch_on1(){
		$s_id = I('name');

		$res = M('customer_service as a')->field("c.id,b.predict_num as num,b.convert_num as exchange_num,b.practical_num,c.names")->join('LEFT JOIN `cs_customer_pro` as b ON a.id=b.customer_id')->join('LEFT JOIN `cs_pro` as c ON b.pro_id=c.id')->where("b.customer_id='$s_id'")->select();
		if( $res != null ){
			$temp['ext'] = $res;
		
			echo json_encode($temp);
		}else{
			echo null;
		}
		

	}
	
	
	//ajax查看商品ajax_pitch_on2 曾洋 2017年6月6日16:28:38
	public function ajax_pitch_on2(){
		$s_id = I('name');
		$res = M('customer_service as a')->field("c.id,b.predict_num as num,b.convert_num as exchange_num,b.practical_num,c.names")->join('LEFT JOIN `cs_customer_pro` as b ON a.id=b.customer_id')->join('LEFT JOIN `cs_pro` as c ON b.pro_id=c.id')->where("b.customer_id='$s_id'")->select();
		if( $res != null ){
			$temp['ext'] = $res;
		
			echo json_encode($temp);
		}else{
			echo null;
		}
	}
	
	
	//ajax查看商品ajax_pitch_on3 曾洋 2017年6月6日16:28:38
	public function ajax_pitch_on3(){
		header("Content-type:text/html;charset=utf-8");
		$s_id = I('name');
		/* $s = M('customer_service')->field("goods_ext")->where("id='$s_id'")->find();
		$data = json_decode($s['goods_ext'],true);
		echo json_encode($data); */
		
		$res = M('customer_service as a')->field("c.id,b.predict_num as num,b.convert_num as exchange_num,b.practical_num,c.names")->join('LEFT JOIN `cs_customer_pro` as b ON a.id=b.customer_id')->join('LEFT JOIN `cs_pro` as c ON b.pro_id=c.id')->where("b.customer_id='$s_id'")->select();
		if( $res != null ){
			$temp['ext'] = $res;
		
			echo json_encode($temp);
		}else{
			echo null;
		}
		
		
	}
	

	public function ajax_pitch_on4(){
		header("Content-type:text/html;charset=utf-8");
		$s_id = I('name');
		$s = M('business as a')->field("b.type,c.id,b.pro_num as num,c.names")->join('LEFT JOIN `cs_business_pro` as b ON a.busi_id=b.business_id')->join('LEFT JOIN `cs_pro` as c ON b.pro_id=c.id')->where("busi_id='$s_id'")->select();
		
		if( $s != null ){
			
			$temp = array();

			foreach($s as $k=>$v){
				
				switch($v['type']){
					case 1:
						$temp['cash'][]  = $v;

						break;
						
					case 2:

						$temp['free'][]  = $v;
						
					break;
					
					case 3:

						$temp['on_credit'][]  = $v;
						
						break;
				}

			}

			$data = json_encode($temp);
			echo $data;
			
		}else{
			echo null;
			
		}

	}
	
	
	

	
}



?>