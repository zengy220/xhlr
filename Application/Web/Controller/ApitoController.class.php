<?php

class ApitoController extends CommonController{

	function index(){

		// header("Content-Type:text/html;charset=utf-8");
	 
			//账号
			$username= "hnxjw";
			 
			//验证码
			$rand = rand(1000,9999);
			//密码
			$password=  "874639";
			 
			//修改为您要发送的手机号
			$mobile = I('phone');
			 
			//发送地址，请咨询客服
			$url = "http://118.178.86.197/cmas/cmasoutapi.do?method=httpSend&username=hnxjw&password=1234&mobile=13800138000&msg=httptest&sign=520e890c77010ff61b2&needstatus=true&needmo=false";
			 
			//是否需要状态报告,为true即可
			$needstatus = "true"; 
			 
			//产品，为空即可
			$product = ""; 
			 
			$ch = curl_init();
			 
			/* 设置验证方式 */
			curl_setopt($ch, CURLOPT_HTTPHEADER, 
			array('Accept:text/plain;charset=utf-8', 'Content-Type:application/x-www-form-urlencoded','charset=utf-8'));
			 
			/* 设置返回结果为流 */
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
			 
			/* 设置超时时间*/
			curl_setopt($ch, CURLOPT_TIMEOUT, 10);
			 
			/* 设置通信方式 */
			curl_setopt($ch, CURLOPT_POST, 1);
			curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
			 
			 
			// 发送短信
			$msg="【科技】您的验证码是：".$rand;  
			$data=array('msg'=>$msg,'username'=>$username,'pswd'=>$pswd,'mobile'=>
			$mobile,'needstatus'=>$needstatus,'product'=>$product);
			$result = $this->send($ch,$data);
			echo '<pre>';print_r($result);
			 
			curl_close($ch);
			exit;
	}


	//验证码
	function send($ch,$data){
	    curl_setopt ($ch, CURLOPT_URL, $url);
	    curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($data));
	    return curl_exec($ch);
	}


		 
}
?>