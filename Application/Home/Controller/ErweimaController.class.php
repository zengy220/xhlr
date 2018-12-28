<?php
namespace Home\Controller;
use Think\Controller;
class ErweimaController extends CommonController
{
	
    //显示制作二维码界面
    public function show_qrcode(){
		
		
		$str = 'http://www.24u.com/index.php?user&q=action/red_wechat/%7B%22id%22%3A%22724%22%2C%22mch_billno%22%3A%2220170808110722%22%2C%22sign%22%3A%22C3F66576E7DDD2E4D654CFA62FFE7229%22%2C%22total_amount%22%3A%221.08%22%2C%22total_num%22%3A%221%22%2C%22type%22%3A%220%22%7D';
		
		
		$a = urldecode($str);
		dump($a);
		
        //$this->display();
    }

    public function mk_more_qrcode(){

        $page=I('get.page'); //页码
        if(empty($page)){
            $page = 0;
        }

        $count=I('get.count'); //每页数量
        if(empty($count)){
            $count = 16;
        }

        $total=I('total'); //总数
		//var_dump($total);exit;
        if(empty($total)){
            $total = 10;
        }

        $type_id=I('get.type_id'); //类型
        if(empty($type_id)){
            $type_id = 1;
        }

        //本次结束
        $thisTarget=($page+1)*$count;
        if($thisTarget>$total){
            $thisTarget=$total;
        }
        //本次起始
        $i=$page*$count+1;

        import("Org.Des.MyDes");
        $key="zwt2017";
        $des = new \MyDes($key);

        Vendor('phpqrcode.phpqrcode');  
       
        $level=3;  
        $size=4;   
        $errorCorrectionLevel =intval($level) ;//容错级别  
        $matrixPointSize = intval($size);//生成图片大小  
        $object = new \QRcode(); 

        for($i=1;$i<=$total;$i++)
        {
        $g=M('gift');
		
		$data = array(
            'type_id' => $type_id,
            'status'  => 0,
            'user_id' => 0,
            'time'    => time()
        );

        $rs = $g->add($data);//产品编号=插入空值进(gift表)自增id 
            //echo $rs; echo '<br/>';  exit;
        if($rs>0)
        { 
                $enstr=$des->encrypt($rs.'zwt2017');
                //update update 这条记录 更新产品编号和加密码
                
                $sql = "update cs_gift set code_en='$enstr' where id=".$rs;
                M('gift')->query($sql);
        }       
        
        //http://167j281a16.51mypc.cn/wxchat/product/Qrcode/myqcode/132882E85866F4F0
        $url=C('ORDER_URL').'/Wxchat/Product/Qrcode/myqcode/'.$enstr;
		
        $level=3;
        $size=4;  
        Vendor('phpqrcode.phpqrcode');  
        $errorCorrectionLevel =intval($level) ;//容错级别  
        $matrixPointSize = intval($size);//生成图片大小  

        ob_clean();
        $object->png($url,"fold/".md5(microtime()).".png", $errorCorrectionLevel, $matrixPointSize, 2);
      
        }
		
		//header('Location:/Home');
		//exit;
    }
	
	
//二维码类别管理
	public function code_type(){
		
		$res = M('code_type')->order('Id desc')->select();
		$this->assign('data',$res);
		$this->display();
	}
	
//新增类别
	public function add_code_type(){
		$m = I('Type_explain');
		$k = I('Type_astrict');

		if( $m == '' ){
			echo 901;
		}else if( $k == 0 ){
			echo 902;
		}else{
			$data = array(
				'Type_explain'=>$m,
				'Type_astrict'=>$k,
				'Type_addtime'=>time()
			);

			$add = M('code_type')->data($data)->add();
			
			if($add>0){
				
				if($add <= 9){
					$Type_num['Type_num'] = '0'.$add;
				}else{
					$Type_num['Type_num'] = $add;
				}
				
				$res =  M('code_type')->where("Id=".$add)->save($Type_num);
				
				if(!$res){
					$del = M('code_type')->where("Id=".$add)->delete();
					echo 999;
				}else{
					echo $add;
				}
				
				
			}
			
		}
		
		
		
	}

//修改类别
	public function edit_code_type(){
		$Id = I('Id');
		if(IS_POST){
			$Type_explain = I("Type_explain");
			$Type_astrict = I("Type_astrict");
			$Id = I("Id");
			
			if($Type_explain == ''){
				$this->error("类别说明必须填写！");
			}
			
			if($Type_astrict == 0){
				$this->error("扫码限制必须填写！");
			}
			
			$data = array(
				'Type_explain'=>$Type_explain,
				'Type_astrict'=>$Type_astrict,
			);
			
			$rel = M('code_type')->where("Id=".$Id)->save($data);
			
			if($rel){
				$this->success("修改成功！","/Home/Erweima/code_type");
			}else{
				$this->error("修改失败！");
			}
			
		}else{
			$res = M('code_type')->where('Id='.$Id)->find();
			$this->assign('data',$res);
			$this->display();
		}

	}
	
//二维码规则列表
	public function code_rule(){
		$res = M('code_rule as a')->field("Rule_Id,StartTime,EndTime,CodeStart,CodeEnd,RuleStatus,Type_num,Type_explain")->join("LEFT JOIN `cs_code_type` as b ON a.Type_id=b.Id ")->where($where)->order('Rule_Id desc')->select();
		$rel = M("code_type")->order("Id desc")->select();
		
		$this->assign('ctype',$rel);
		$this->assign('data',$res);
		$this->display();
	}
	
//新增二维码规则
	public function add_code_rule(){
		
		$TimeUnlimited=I('TimeUnlimited');
		$CodeUnlimited=I('CodeUnlimited');
		$RuleStatus   =I('RuleStatus');
		$data['Type_id']  = I('Type_id');

		if($TimeUnlimited == ''){
			$data['StartTime']	 = strtotime(I('StartTime'));
			$data['EndTime']	 = strtotime(I('EndTime'));
		}
		if($CodeUnlimited == ''){
			$data['CodeStart']	 = $data['Type_id'].I('CodeStart');
			$data['CodeEnd']	 = $data['Type_id'].I('CodeEnd');
		}
		$ruleModel = M("code_rule");
		
		if( $data['StartTime'] != '' || $data['CodeStart'] != ''){
			
			$verify = $ruleModel->where("Type_id=".$data['Type_id'])->select();
			
			foreach( $verify as $k => $v ){
				
				if( $data['StartTime'] != ''){
					if(	($data['StartTime'] >= $v['StartTime'] && $data['StartTime'] <= $v['EndTime'])
					 || ($data['EndTime'] >= $v['StartTime'] && $data['EndTime'] <= $v['EndTime'] ) 
					 || ($data['StartTime'] < $v['StartTime'] && $data['EndTime'] >= $v['StartTime'])){
						echo 998;exit;
					}
				}
				

				
				/*if( $data['CodeStart'] != '' ){
					if( ($data['CodeStart'] >= $v['CodeStart'] && $data['CodeStart'] <= $v['CodeEnd'])
					 || ($data['CodeEnd'] >= $v['CodeStart'] && $data['CodeEnd'] <= $v['CodeEnd'] )
					 || ($data['CodeStart'] < $v['CodeStart'] && $data['CodeEnd'] >= $v['CodeStart'])){
						echo 997;exit;
					 }
				}*/
				
			}
			
		}	
	
		
		if($RuleStatus == ''){
			$data['RuleStatus']	 = 1;
		}
		$res = $ruleModel->data($data)->add();
		
		if($res){
			echo 901;
		}else{
			echo 999;
		}
		
		
	}
	
//编辑二维码规则
	public function edit_code_rule(){
		
		$Id = I('Id');
		$ruleModel = M("code_rule");
		if(IS_POST){
			
			
			dump($_POST);
			
			
		}else{
			$res = $ruleModel->where("Rule_Id=".$Id)->find();
			
			$res['StartTime'] = date('Y-m-d',$res['StartTime']);
			$res['EndTime'] = date('Y-m-d',$res['EndTime']);
			
			$rel = M("code_type")->order("Id desc")->select();
			$this->assign('ctype',$rel);
			$this->assign('data',$res);
			$this->display();
		}
	}
	
	
//中奖设置列表
	public function code_prize(){
		$Rule_Id = I('Id');
		
 		$Prize_type = I('Prize_type');

		$code_prize = M('code_prize')->where("Rule_Id=".$Rule_Id)->order('Prize_id asc')->select();//查询奖品分类
		
		$where['Prize_id'] = !empty($Prize_type) ? $Prize_type : $code_prize[0]['Prize_id'];

		$code_type  = empty($Prize_type) ? $code_prize[0]['Prize_type'] : '';
		$code_title = empty($Prize_type) ? $code_prize[0]['Prize_title'] : '';
		
		$Prize_condition = empty($Prize_type) ? $code_prize[0]['Prize_condition'] : '';
		
		foreach($code_prize as $k=>$v){
			$code_prize[$k]['url'] = "/Home/Erweima/code_prize/Id/".$Rule_Id."/Prize_type/".$v['Prize_id'];
		if( $code_title == '' || $Prize_condition == '' || $code_type){
				
				$i = in_array($where['Prize_id'],$v);
				if($i){
					$code_title = $v['Prize_title'];
					$Prize_condition = $v['Prize_condition'];
					$code_type = $v['Prize_type'];
				}
			
			}
			
		}

		$classify = M('code_classify')->where($where)->select();//查询奖品分类的奖项
		$this->assign('list',$classify);
		$this->assign('Rule_Id',$Rule_Id);
		$this->assign('code_title',$code_title);
		$this->assign('code_prize',$code_prize);
		$this->assign('code_type',$code_type);
		$this->assign('Prize_type',$where['Prize_id']);
		$this->assign('Prize_condition',$Prize_condition);
		$this->display();
		
	}
	
//删除奖品
	public function del_prize(){
		$Id = I("id");
		
		$res = M('code_prize')->where("Prize_id=".$Id)->find();
		
		if(!$res){
			echo 902;exit;
		}
		
		$del_1 = M('code_prize')->where("Prize_id=".$Id)->delete();
		$del_2 = M('code_classify')->where("Prize_id=".$Id)->delete();
		if( $del_1 || $del_2 ){
			echo '000';
		}else{
			echo 901;
		}
		
		
	}
	
//中奖设置，添加奖项
	public function add_code_prize(){
		$Classify_probability = I('Classify_probability');//中奖概率
		$communal  = I('communal');						  //公用内容
		$Prize_type= I('Prize_type');					  //奖品类别
		$Rule_Id   = I('Rule_Id');						  //规则ID
		
		$Model = M('code_classify');
		
		$c_sum = $Model->field('SUM(Classify_probability) as c_sum')->where("Prize_id=".$Prize_type)->find();
		$sum = $Classify_probability + $c_sum['c_sum'];
		
		if($sum>100){
			echo 903;exit;
		}
		
		if($Prize_type == '' || $Rule_Id == '' || $communal == '' || $Classify_probability == ''){
			echo 901;//参数缺失
			exit;
		}
		$data = array(
			'Prize_id'=>$Prize_type,
			'Rule_Id' =>$Rule_Id,
			'Classify_resource'=>$communal,
			'Classify_probability'=>$Classify_probability,
		);
		
		$result = $Model->data($data)->add();
		if($result>0){
			echo '000';//添加成功
			
		}else{
			echo 902;//添加失败
			
		}
		
	}
	
//中奖设置，修改奖项
	public function edit_code_prize(){
		
		$Model = M('code_classify');

		if(IS_POST){
			
			$data = array(
				'Prize_id'=>I('Prize_id'),
				'Classify_Id'=>I('Classify_Id'),
				'Classify_resource'=>I('Classify_resource'),
				'Classify_probability'=>I('Classify_probability'),
			);
			
			if( $data['Classify_Id'] == '' || $data['Classify_resource'] == '' || $data['Classify_probability'] == '' ){
				echo 901;
			}
			
			$list = $Model->field('sum(Classify_probability) as i')->where('Prize_id='.$data['Prize_id'])->find();
			$self_num = $Model->field('Classify_probability as k')->where('Classify_Id='.$data['Classify_Id'])->find();
			$sum = $list['i'] - $self_num['k'] + $data['Classify_probability'];

			if($sum > 100){
				echo 903;exit;
			}
			
			$result = $Model->where('Classify_Id='.$data['Classify_Id'])->save($data);
			
			if($result){
				echo '000';exit;
			}else{
				echo 902;exit;
			}

			
		}else{
			$classifyid = I("classifyid");
			$list = $Model->where("Classify_Id=".$classifyid)->find();
			$this->assign('list',$list);
			$this->display();
		}
		

	}
	
//中奖设置，删除奖项

	public function del_code_prize(){
		
		$classifyid = I("id");
		$del = M('code_classify')->where("Classify_Id=".$classifyid)->delete();
		if($del){
			echo '000';
			
		}else{
			echo 901;
			
		};
		
	}
	
//添加奖品
	public function add_prize(){
		
		$data = array(
			'Prize_condition'=>I('Prize_condition'),
			'Prize_type'=>I('PrizeType'),
			'Prize_title'=>I('Prize_title'),
			'Rule_Id'=>I('Rule_Id')
		);
		
		foreach($data as $k=>$v){
			if($v == ''){
				echo 901;break;
			}
		}
		
		$res = M('code_prize')->data($data)->add();
		if($res>0){
			echo '000';exit;
		}else{
			echo 902;exit;
		}
		
	}
	
	
//二维码导出页面
	public function code_export_show(){
		
		$type_select = M('code_rule as a')->field("Id,Rule_Id,StartTime,EndTime,CodeStart,CodeEnd,RuleStatus,Type_num,Type_explain")->join("LEFT JOIN `cs_code_type` as b ON a.Type_id=b.Id ")->where($where)->order('Rule_Id desc')->select();
		$rel = M("code_type")->order("Id desc")->select();
		
		$code_derived = M("code_derived")->order('Derived_Id desc')->select();
		
		
		

		$this->assign('select_data',$type_select);
		$this->assign('code_derived',$code_derived);
		$this->display();
	}
	
//二维码导出获取二维码类别最后导出的值
	public function ajax_get_type(){
		
		$Rule_Id = I('Rule_Id');
		
		$rule_result = M('code_derived')->field('End_num')->where("Rule_Id=".$Rule_Id)->order("Derived_Id desc")->find();
		
		if(  !empty($rule_result['End_num']) ){
			$data = $rule_result['End_num']+1;
		}else{
		
			$num = M('code_rule')->field('Type_id')->where("Rule_Id=".$Rule_Id)->find();
			$data=  $num['Type_id'].'000001';
		}
		
		echo $data;
		
	}
	
//二维码导出功能
	public function code_export(){
		$Count = I('Count');
		$Rule_Id = I('Rule_Id');
		$Start_num = I('Start_num');
		$End_num = I('End_num');
		$Derived_explain = I('Derived_explain');
		$RuleModel = M('code_rule as a');

		if (!empty($Count)) {
			$resultRule = $RuleModel->join('LEFT JOIN cs_code_derived as b ON a.Rule_Id=b.Rule_Id')->field('a.Rule_Id,a.Type_id,End_num')->where('a.Rule_Id='.$Rule_Id)->order("Derived_Id desc")->find();
		} else {
			$Rule_Id = I('Rule_Id2');
			$Count = $End_num - $Start_num + 1;
			$resultRule = $RuleModel->join('LEFT JOIN cs_code_derived as b ON a.Rule_Id=b.Rule_Id')->field('b.Derived_time,b.Type_Id')->where('a.Rule_Id='.$Rule_Id)->order("Derived_Id desc")->find();
			$data = array(
				'Derived_time'=>$resultRule['Derived_time'],
				'Derived_explain'=>$Derived_explain,
				'Start_num'=>$Start_num,
				'End_num'=>$End_num,
				'Count'  =>$Count,
				'Rule_Id'=>$Rule_Id,
				'Type_Id'=>$resultRule['Type_Id'],
			);
			$this->export_txt($data,false);return;
		}
		
		// dump($resultRule);die;
		
		if( !empty($resultRule['End_num']) ){
			
			$startCode = $resultRule['End_num'] + 1; //本次导出开始码段
			$endCode = $startCode + $Count - 1;			//本次导出开始码段
			
		}else{
			
			$k = '';
		
			for( $i = strlen($Count); $i<=5; $i++  ){
				$k .= '0';
			}
			
			$startCode = $resultRule['Type_id'].'000001';//本次导出开始码段

			$endCode = intval($startCode) + intval($Count);//本次导出结束码段

		}

		$data = array(
			'Derived_time'=>time(),
			'Derived_explain'=>$Derived_explain,
			'Start_num'=>$startCode,
			'End_num'=>$endCode,
			'Count'  =>$Count,
			'Rule_Id'=>$resultRule['Rule_Id'],
			'Type_Id'=>$resultRule['Type_id'],
		);
		// var_dump($data);exit;
		
		$this->export_txt($data,true);
	}
	
	private function export_txt($data,$bool){
		
		$title = 'erweima'.date('Y-m-d[His]',time());
		$code_url = C('SCAN_CODE_URL');//获取二维码配置地址
		$token = $data['Rule_Id'].C('TOKEN');//获取加密参数
		
		Header( "Content-type:   application/octet-stream "); 
		Header( "Accept-Ranges:   bytes "); 
		header( "Content-Disposition:   attachment;   filename=$title.txt "); 
		header( "Expires:   0 "); 
		header( "Cache-Control:   must-revalidate,   post-check=0,   pre-check=0 "); 
		header( "Pragma:   public ");
		
		for($i=$data['Start_num']; $i<=$data['End_num']; $i++  ){
			
			$token .= $i;
			$token = md5($token);
			$url = $code_url.$data['Rule_Id'].'/e_code/'.$i.'/e_token/'.$token."\r\n";
			echo $url;
			
		}
		if( $bool == true ){
			$this->write_log($data);
		}
		
	}
	
	private function write_log($data){
		$add_log = M('code_derived')->data($data)->add();
		
	}
	
//重复导出
	public function repeat_export_code(){
		$Derived_Id = I('Id'); 
		$rel = M('code_derived')->where("Derived_Id=".$Derived_Id)->find();
		$this->export_txt($rel,false);
	}
	
	
	
	
	

	
}