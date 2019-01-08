<?php
namespace Web\Controller;
use Think\Controller;

class ApiController extends CommonController
{

	 public function sms(){
//        echo 2;

        $phone = I('phone');
        $rand = rand(1000,9999);
        // $url = "http://api.chanyoo.cn/utf8/interface/send_sms.aspx?username=guomengtao1&password=aa77bb&content=验证码：".$rand."【高血压】&receiver=".$phone;
        $url = "http://118.178.86.197/cmas/cmasoutapi.do?method=httpSend&username=hnxjw&password=874639&mobile=".$phone."&msg=验证码".$rand."&sign=bf944381d72d1f05f5d6fe68f8070645&needstatus=true&needmo=false";

        var_dump($url);exit;

        $file = file_get_contents($url);
        var_dump($file);exit;

//        echo $file;

//        转换xml结果
        $xml = simplexml_load_string($file);
        $data = json_decode(json_encode($xml),TRUE);

        // echo $data['message'];

        if ($data['message']="短信发送成功"){
//            存入数据库
            $sms = Sms::create([
                'phone' => $phone,
                'rand'  => $rand

            ]);
        }


    }

	//54个中药材名称
	public function name_medicine(){
		//允许跨域请求
    	$this->attend();

		// $tpcode='zycmc';
		$map['col_id'] = 1;
		// $map['status'] = 1;
		$name_medicine=M("content_content")->where($map)->select();
		//过滤
		foreach ($name_medicine as $k => $v) {
			# code...
			$data[$k]['name'] = $name_medicine[$k]['name_medicine'];
			$data[$k]['id'] = $name_medicine[$k]['id'];
		}
		// var_dump($data);exit;


		//json
		$json = json_encode(array(
            "resultCode"=>200,
            "message"=>"查询成功！",
            "data"=>$data
        ),JSON_UNESCAPED_UNICODE);
        
        //转换成字符串JSON
        print($json);exit;

	}

	//曾经填写过的企业名字，生产地点、联系人做成数组
	public function record(){
		//允许跨域请求
    	$this->attend();
    	//先查询数据库是否有次登陆号码？如果没有则返回null;如果有则返回相应的数据
    	//可以跟user_id 查询公司并且分类
    	$user_id=I('user_id');
    	if(empty($user_id)){
    		$data = null;
    		$json = json_encode(array(
            "resultCode"=>200,
            "message"=>"查询成功！",
            "data"=>$data
        	),JSON_UNESCAPED_UNICODE);

    		 print($json);exit;
    	}
    	//公司名字
    	$where['user_id']=$user_id;
    	$data_company = M('content')->distinct('company')->field('company')->where($where)->find();
    	//生产地点
    	$data_address= M('content')->distinct('address')->field('address')->where($where)->find();
    	//联系人
    	$data_name_people = M('content')->distinct('name_people')->field('name_people')->where($where)->find();
    	$data['company']=$data_company['company'];
    	$data['address']=$data_address['address'];
    	$data['name_people']=$data_name_people['name_people'];
    	
    	//json
		$json = json_encode(array(
            "resultCode"=>200,
            "message"=>"查询成功！",
            "data"=>$data
        ),JSON_UNESCAPED_UNICODE);
        
        //转换成字符串JSON
        print($json);exit;



	}




	//提交接口
	public function submission(){
		//允许跨域请求
    	$this->attend();
		//将提交转换并保存
		$all_data = ($_POST);
		//如果area有数据那么我带上单位，如果没有数据则不带上单位
		//过滤area的空格
		$all_data['area']=$this->myTrim($all_data['area']);
		if(!empty($all_data['area'])){
			$all_data['area']=$all_data['area'].'亩';
		}

		// 对提交的内容过滤判断			
		// 获取新增药材
		$new_medicine =I('new_medicine');
		//获取老旧药材库名称
		$where['col_id']=1;
		$old_medicine = M('content_content')->where($where)->field('id,name_medicine,col_id')->select();
		// var_dump($old_medicine);exit;
		// 通过循环对比如果是不一样则新增
		if($new_medicine!=='undefined'){

			foreach ($old_medicine as $k => $v) {
				if($new_medicine==$old_medicine[$k]['name_medicine']){
					// 代表是重复的 获取对应的id
					$new = 2;
					$medicine_id = $old_medicine[$k]['id'];
				}else{
					$new = 1;
					$data_new_medicine['name_medicine'] =$new_medicine;
				}
			}
		}
		if($new ==1){
			// 如果是新增的中药材名字则放入到另一个表单中cs_content_content
			$where_new_medicine['col_id']=1;
			$add_medicine = M('content_content')->where($where_new_medicine)->add($data_new_medicine);
			// var_dump($add_medicine);exit;
			if(empty($add_medicine)){
				// 信药材名插入数据库成功
				$json = json_encode(array(
		            "resultCode"=>400,
		            "message"=>"新增中药材失败！"
       		 	),JSON_UNESCAPED_UNICODE);
		        //转换成字符串JSON
		        print($json);exit;
			}
		}

		

		// $medicine_id = '1,3';
		// $new_medicine = '多少个字';
		$medicine_id = $all_data['medicine_id'];
		// var_dump($medicine_id);exit;
		$where2['id']=array('in',$medicine_id);
		$name_medicine = M('content_content')->field('name_medicine')->where($where2)->select();
		$new_m['name_medicine'] =$new_medicine;
		if($add_medicine){
			if($new_m!==0){
				array_push($name_medicine,$new_m);
			}
		}
		if(empty($name_medicine)){
			$name_medicine=I('new_medicine');
			// var_dump(I('new_medicine'));exit;
			// var_dump($name_medicine);exit;
		}else{

			foreach ($name_medicine as $val2) {
			    $val2 = join(",",$val2);
			    $temp_array[] = $val2;
			}

			$name_medicine = implode(",", $temp_array);
		}

		// var_dump($name_medicine);exit;
		// $medicine_name = I('name_medicine');
		//将体提交的多种中药材加上新增药材
		if(!empty($add_medicine)){
			$medicine_id=$medicine_id.','.$add_medicine;
		}


		//获取参数
		$data['medicine_id']=$medicine_id;
		$data['name_medicine']=$name_medicine;
		// $data['name_medicine']=$name_medicine;
		$data['user_id']=$all_data['user_id'];
		$data['production']=$all_data['production'];
		$data['unit']=$all_data['unit'];
		$data['company']=$all_data['company'];
		$data['address']=$all_data['address'];
		$data['create_time']=time();
		$data['phone_number']=$all_data['phone_number'];
		$data['name_people']=$all_data['name_people'];
		$data['area']=$all_data['area'];
		//将提交的内容接受并插入数据库中

		$add = M('content')->add($data);
		
		if(!empty($add)){
			$json = json_encode(array(
	            "resultCode"=>200,
	            "message"=>"插入成功！"
       		 ),JSON_UNESCAPED_UNICODE);
	        //转换成字符串JSON
	        print($json);exit;
		}else{
			$json = json_encode(array(
	            "resultCode"=>400,
	            "message"=>"提交失败！"
       		 ),JSON_UNESCAPED_UNICODE);
	        //转换成字符串JSON
	        print($json);exit;
		}

	}

	//列表接口
	public function list_page(){
		//允许跨域请求
    	$this->attend();
		//查询列表
		$where_to['user_id']=I('user_id');
		$data = M('content')->where($where_to)->order('create_time desc')->select();
		foreach ($data as $k => $v) {
			unset($data[$k]['create_time']);
			unset($data[$k]['status']);
		}
		//将数据整理成按照公司为单位排列
		foreach ($data as $k2 => $v2) {
  			$data2[$v2['company']][] = $v2;
		}
		//整理数组
			$n=0;
		foreach ($data2 as $k3 => $v3) {
			
			$data3[$n] = $data2[$k3];
			$n=$n+1;
		}

		foreach ($data3 as $k4 => $v4) {
			$data4[$k4]['company']=$data3[$k4][0]['company'];
			$data4[$k4]['data']=$data3[$k4];
		}

		// var_dump($data4);exit;

		if(empty($data)){
			$data4 ='empty';
		}


		// var_dump($data);exit;
		$json = json_encode(array(
	            "resultCode"=>200,
	            "message"=>"查询成功！",
	             "data"=>$data4
       	),JSON_UNESCAPED_UNICODE);
	    //转换成字符串JSON
	    print($json);exit;
	}

	//点击修改显示的时候
	public function edit(){
		//允许跨域请求
    	$this->attend();

		$where['id']=I('id');
		$data = M('content')->where($where)->find();

		if(!empty($data['production'])){
			// $data['production']=str_replace("亩","",$data['production']);

		}
		//提出株 株/亩 万株/亩
		

		if(!empty($data['area'])){
			$data['area']=str_replace("亩","",$data['area']);
		}
		if($data){
			$json = json_encode(array(
	            "resultCode"=>200,
	            "message"=>"查询成功！",
	             "data"=>$data
	       	),JSON_UNESCAPED_UNICODE);
		    //转换成字符串JSON
		    print($json);exit;
		}else{
			$json = json_encode(array(
	            "resultCode"=>400,
	            "message"=>"查询失败！"
	       	),JSON_UNESCAPED_UNICODE);
		    //转换成字符串JSON

		}

	}

	//提交修改内容
	public function edit_to(){
		//允许跨域请求
    	$this->attend();
    	
    	$data['production']=I('production');
    	$data['unit']=I('unit');
    	$data['phone_number']=I('phone_number');
    	$data['address']=I('address');
    	$data['name_people']=I('name_people');
    	if(!empty(I('area'))){
	    	$data['area']=I('area').'亩';
    		
    	}
    	$map['id']=I('id');
    	$data1 = M('content')->where($map)->save($data);
    	if($data1){
			$json = json_encode(array(
	            "resultCode"=>200,
	            "message"=>"查询成功！"
	       	),JSON_UNESCAPED_UNICODE);
		    //转换成字符串JSON
		    print($json);exit;
		}else{
			$json = json_encode(array(
	            "resultCode"=>400,
	            "message"=>"查询失败！"
	       	),JSON_UNESCAPED_UNICODE);
		    //转换成字符串JSON

		}

	}


	//允许跨域请求函数
	function attend(){
		header('Access-Control-Allow-Methods:OPTIONS, GET, POST');
		header('Access-Control-Allow-Headers:x-requested-with');
		header('Access-Control-Max-Age:86400');  
		header('Access-Control-Allow-Origin:'.$_SERVER['HTTP_ORIGIN']);
		header('Access-Control-Allow-Credentials:true');
		header('Access-Control-Allow-Methods:GET, POST, PUT, DELETE, OPTIONS');
		header('Access-Control-Allow-Headers:x-requested-with,content-type');
		header('Access-Control-Allow-Headers:Origin, No-Cache, X-Requested-With, If-Modified-Since, Pragma, Last-Modified, Cache-Control, Expires, Content-Type, X-E4M-With');
		header('Access-Control-Allow-Origin:*');//允许所有来源访问
		header('Access-Control-Allow-Method:POST,GET');//允许访问的方式
	}

	//过滤空格
	function myTrim($str){
	 $search = array(" ","　","\n","\r","\t");
	 $replace = array("","","","","");
	 return str_replace($search, $replace, $str);
	}



}