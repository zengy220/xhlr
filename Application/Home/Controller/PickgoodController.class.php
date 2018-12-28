<?php
/** 
	提货控制器
*/ 
namespace Home\Controller;
// use Home\Controller;
use Think\Controller;
class PickgoodController extends CommonController{
	public function index(){

	}
	//提货记录列表
	private function product(){
		$pro_rel = M('pro')->field('id,names')->where('sort2>0')->select();//查询出所有产品
		return $pro_rel;
	}
	public function pick_list(){
		
		$data['real_name']  = trim(I('real_name'));
		$data['username'] 	= trim(I('saleman_id'));
		$data['b.name'] 	= trim(I('name'));
		$data['serv_type']  = 4;//2标识为退货
		foreach($data as $k=>$v){
			if(!empty($v)){
				//$where[$k] = $v;
				$where[$k] = array('like',"%$v%");
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
		
		$C = M('customer_service');//售后服务表
		
		if( session('role_identity') == 1 ){
			$where['b.company_id'] = session('company');
		}
		
		$count = $C->alias('a')->join("left join cs_user as b on b.user_Id=a.saleman_id")->field("b.user_Id,b.real_name,a.goods_ext,a.reason,a.add_time")->order('a.add_time desc')->where($where)->count(); // 查询满足要求的总记录数
	
		$Page 	= new \Org\Util\Page($count,20);
	
		$show   = $Page->show();
	
		$pickGoodInfo=$C->alias('a')->field("b.user_Id,b.real_name,b.username,a.goods_ext,a.id,a.reason,a.add_time")->join("left join cs_user as b on b.user_Id=a.saleman_id")->where($where)->limit($Page->limit[0],$Page->limit[1])->order('a.add_time desc')->select();
		
		$seachParam = I();
		$this->assign('param',$seachParam);
		$this->assign('temp',$pickGoodInfo);
		$this->assign('page',$show);
		$this->display();
		
	}
	
	
	public function pick_list_export(){
		header("Content-type:text/html;charset=utf-8");
		$data['real_name']  = trim(I('real_name'));
		$data['username'] 	= trim(I('saleman_id'));
		$data['b.name'] 	= trim(I('name'));
		
		foreach($data as $k=>$v){
			if(!empty($v)){
				$where[$k] = array('like',"%$v%");
			}
		}
		
		$where['serv_type']  = 4;//4标识为提货
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
		
		$C = M('customer_service');//售后服务表
		
		if( session('role_identity') == 1 ){
			$where['b.company_id'] = session('company');
		}
	
		$rel = $C->alias('a')->field("b.username,b.real_name,a.reason,a.add_time,d.pro_id,d.practical_num,a.id")->join("left join cs_user as b on b.user_Id=a.saleman_id")->join('LEFT JOIN `cs_customer_pro` as d ON d.customer_id=a.id')->where($where)->order('a.add_time desc')->select();
		
		
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
		
		$arr_1 = array('业务员工号','姓名','备注','提货时间');
		
		$arr_2 = array('提货数量');
		
		$titleArr = parent::bubbling_sort($temp,$arr_1,$arr_2);
		
		$name = '提货列表'.date('Y-m-d H:i:s',time());

		parent::exportexcel($temp,$titleArr,$name);
		
		
		
		
		
		
	}
	
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

	
}
	



?>