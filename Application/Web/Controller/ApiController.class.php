<?php
namespace Web\Controller;
use Think\Controller;

class ApiController extends CommonController
{

	//54个中药材名称
	public function name_medicine(){
		//允许跨域请求
    	$this->attend();

		$tpcode='zycmc';
		$map['col_id'] = $this->getIdByTpcode($tpcode);
		$map['status'] = 1;
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

	//提交接口
	public function submission(){
		//允许跨域请求
    	$this->attend();
		//将提交的json格式转换并保存
		$all_data = ($_POST);
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
		$where2['id']=array('in',$medicine_id);
		$name_medicine = M('content_content')->field('name_medicine')->where($where2)->select();
		$new_m['name_medicine'] =$new_medicine;
		if($add_medicine){
			if($new_m!==0){
				array_push($name_medicine,$new_m);
			}
		}
		if($name_medicine=='undefined'){
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
		$data['user_id']=$all_data['userId'];
		$data['production']=$all_data['production'];
		$data['company']=$all_data['company'];
		$data['address']=$all_data['address'];
		$data['create_time']=time();
		$data['phone_number']=$all_data['phone_number'];
		$data['name_people']=$all_data['name_people'];
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
		$where_to['user_id']=I('userId');
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

	public function edit(){
		//允许跨域请求
    	$this->attend();

		$where['id']=I('id');
		$data = M('content')->where($where)->find();
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

	public function edit_to(){
		//允许跨域请求
    	$this->attend();
    	
    	$data['production']=I('production');
    	$data['phone_number']=I('phone_number');
    	$data['address']=I('address');
    	$data['name_people']=I('name_people');
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

















	//内容获取控制器
    public function page_content()
    {
    	//允许跨域请求
    	$this->attend();
    	//简述截取字符串个数
    	$lenght=300;
		$tpcode = I('name');
		if($tpcode=='xwzx'){
			$tpcode ='xwzx2';
		}
		$map['col_id'] = $this->getIdByTpcode($tpcode);
		$map['status'] = 1;
		$count=M("content_content")->where($map)->count();
		// 默认是第一个
		$page = empty(I('page'))?1:I('page');
		$each =4;
		$news=M("content_content")->where($map)->order('istop desc,create_time desc,id desc,update_time desc')->limit($each*($page-1),$each)->select();


		// 接口
		foreach ($news as $k => $v) {
			$news_interface[$k]['title']=$news[$k]['title'];
			//文章第一张图片
			$first_image = $this->get_html_first_imgurl($news[$k]['contents']);
			// $first_image = $this->img($news[$k]['contents']);

			echo $news[$k]['title'];
			echo "<br>11111111111";
			var_dump($news[$k]['contents']);
			echo "<br>11111111111";
			var_dump($first_image);exit;
			if(!empty($news[$k]['thumb'])){
				$news_interface[$k]['image']="http://".$_SERVER['SERVER_NAME'].':'.$_SERVER['SERVER_PORT'].$news[$k]['thumb'];
			}elseif (!empty($first_image)) {
				$news_interface[$k]['image']=$first_image;
			}else{
				$news_interface[$k]['image']="http://".$_SERVER['SERVER_NAME'].':'.$_SERVER['SERVER_PORT'].'/Public/'.'images/'.'new.jpg';
			}
			$news_interface[$k]['id']=$news[$k]['id'];
			// $news_interface[$k]['content']=$news[$k]['contents'];
			//简述截取
			$news_interface[$k]['description']=$this->cutstr_html($news[$k]['contents'],$lenght);
			$news_interface[$k]['time']=$news[$k]['create_time'];
		}
		//page
		$page_detail['size']=$count;
		$page_detail['total']=ceil($count/$each);
		$page_detail['current']=$page;

		//json
		$json = json_encode(array(
            "resultCode"=>200,
            "message"=>"查询成功！",
            "data"=>$news_interface,
            "page"=>$page_detail
        ),JSON_UNESCAPED_UNICODE);
        
        //转换成字符串JSON
        print($json);exit;

    }

	//内容控制器详情
	public function page_detail(){
		//允许跨域请求
    	$this->attend();

		$news_id=I("news_id");
		$info = M("content_content")->where("id=$news_id")->find();
		$now_info['id']=$info['id'];
		$now_info['title']=$info['title'];
		$now_info['contents']=$info['contents'];
		$now_info['time']=$info['create_time'];
		$json = json_encode(array(
            "resultCode"=>200,
            "message"=>"查询成功！",
            "data"=>$now_info
        ),JSON_UNESCAPED_UNICODE);
        
        //转换成字符串JSON
        print($json);exit;
	}

	//广告内容接口
	public function ad(){
		//允许跨域请求
		$this->attend();

		$banner = M("ad_content as t1")->join("cs_ad_list as t2 on t1.ad_list_id=t2.id")->where("t2.simple_code='SYLB1'")->field("t1.url")->select();

		foreach($banner as &$v){
			$v['imgurl'] = $remote_server="http://".$_SERVER['SERVER_NAME'].':'.$_SERVER['SERVER_PORT']."/upfile/".$v['img'];
		}

		$json = json_encode(array(
            "resultCode"=>200,
            "message"=>"查询成功！",
            "data"=>$banner
        ),JSON_UNESCAPED_UNICODE);
        
        //转换成字符串JSON
        print($json);exit;
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

	//将获取的简码搜索出对应的id
	// function tpcode(){
	// 	$tpcode=I('name');
	// 	$where['tpcode']=$tpcode;
	// 	$data = M('content_category')->field('id')->where($where)->find();
	// 	// var_dump($data['id']);exit;
	// 	print_r($data);
	// }




}