<?php
/** 
*PHP文件 
* 
*系统菜单权限角色集中控制器
* @author      zhuda<675671998@qq.com> 
* @version     $Id$ 
* @since        1.0 
*/ 
namespace Home\Controller;
use Home\Controller;
class ProController extends CommonController
{
	
//默认页展示
    public function index()
    {
    
		// var_dump('kk');die;
		//菜单列表
		$colModel = M('content_category');
		$where_1['pid'] = 0;
		$list_1 = $colModel->where($where_1)->order('sort asc')->select();
		foreach($list_1 as &$val){
			//拼接显示字段
			$val['status'] = $val['status'] == 1 ? "<font color='#75B731'>启用</font>" : "<font color='#F83D35'>禁用</font>";

			$collist[] =$val;//组装新数组
			$where_2['pid'] = $val['id'];
			$list2 = $colModel->where($where_2)->order("sort asc")->select();
			if (!empty($list2)) {
				foreach ($list2 as &$vf) {
					$vf['name'] = "  &nbsp;&nbsp;--  " . $vf['name'];
					$vf['status'] = $vf['status'] == 1 ? "<font color='#75B731'>启用</font>" : "<font color='#F83D35'>禁用</font>";
					$collist[] = $vf;
				}
			}
		}
    	$this->assign('collist',$collist);
		$this->display();
       
    }

	//添加商品
	public function add_index(){
		$columnlist = M('content_category')->field('id,name')->where("pid=0")->select();
		$this->assign('columnlist',$columnlist);//商品菜单下拉列表
		$this->assign(' col_title','添加商品.');
		$this->assign('col', "add");
		$this->assign('col_from_url', "/".MODULE_NAME."/Pro/post_column_add/");//from表单提交地址
		$this->display();
	}


	//商品下拉列表
	public function col_menu($type=0){
		$colModel = M('content_category');
		if($type==1)
			$where_1['status'] = 1;
		$where_1['pid'] = 0;
		$col_menu = array();
		$list_1 = $colModel->where($where_1)->field('id,pid,name,status')->order('sort asc')->select();
		foreach($list_1 as &$key){
			//拼接显示字段
			$key['status'] = $key['status'] == 0 ? $key['name']." <font color='#F83D35'>(已隐藏)</font>" : $key['name'];

			$col_menu[] = $key;//组装新数组
			$where_2['pid'] = $key['id'];
			$list2 = $colModel->where($where_2)->field('id,pid,name,status')->order("sort asc")->select();
			if (!empty($list2)) {
				foreach ($list2 as &$vf) {
					$vf['name'] = "  &nbsp;&nbsp;&nbsp;&nbsp;--  " . $vf['name'];
					$col_menu[] = $vf;
				}
			}
		}
		return $col_menu;

	}


	//修改商品
	public function edit_index(){
		$Model = M('content_category');
		$columnlist = M('content_category')->field('id,name')->where("pid=0")->select();
		$u = I('u');
		$col_data = $Model->where("`id`='".$u."'")->find();
		$this->assign('columnlist',$columnlist);//商品菜单下拉列表
		$this->assign('col_data',$col_data);
		$this->assign('col_title','修改商品');
		$this->assign('col', "edit");
		$this->assign('u', "$u");
		$this->assign('col_from_url', "/".MODULE_NAME."/Pro/post_column_edit/");//from表单提交地址
		$this->display("add_index");
	}

	//添加商品
	public function post_column_add(){

		if(IS_POST || $_FILES){
			$o = I('o');
			if(I('name') == ''){
				$this->error('商品名称必须填写！');
			}
			if($o == 'add'){
				$data['name']   = I('name');

				$data['sort'] = I('sort');
				$data['col_url'] = I('col_url');
				if(I('pid')!='')
				$data['pid'] = I('pid');
				if($_FILES){
					list($n,$suffix)= explode('.',$_FILES['thumb']['name']);
					$img_name='/upfile/coloum/'.'column'.time().'.'.$suffix;
					move_uploaded_file($_FILES['thumb']['tmp_name'],'.'.$img_name);
					$data['thumb'] = $img_name;
				}
				$data['tpcode'] = I('tpcode');
				$data['status'] = I('status');
				$data['tpl'] = I('tpl');
				$data['create_time']  = time();
				// var_dump(I('name'));die;
				$add = M('content_category')->add($data);
				if($add){
					$this->success('操作成功！','/'.MODULE_NAME.'/Pro/index/');exit;
				}else{
					$this->error('哎呀，出错了！');exit;
				}

			}
		}
	}

	//修改商品
	public function post_column_edit(){
		if(IS_POST || $_FILES){
			$o = I('o');
			if(I('name') == ''){
				$this->error('商品名称必须填写！');
			}
			$u = I('u');

			if(I('pid')!=''){
				$paramc['id'] = $u;
				$col =  M('content_category')->where($paramc)->find();
				if($col['pid'] != I('pid')){
					if($col['pid'] ==0 ){
						$this->error('此商品为顶级商品，不可以更改父商品！');exit;
					}
					$paramp['id'] = I('pid');
					$re =  M('content_category')->where($paramc)->find();
					if($re['pid']!=0){
						$this->error('不可以更改子商品到非顶级商品下');exit;
					}
				}

			}
			if($o == 'edit'){
				$data['name']   = I('name');
				$data['sort'] = I('sort');
				$data['pid']   = I('pid');
				$data['col_url'] = I('col_url');
				$data['tpcode']   = I('tpcode');
				$data['status']   = I('status');
				$data['tpl']   = I('tpl');
				$data['create_time'] 	 = time();
				$where['id'] = $u;
				if($_FILES['thumb']['error']==0){
					list($n,$suffix)= explode('.',$_FILES['thumb']['name']);
					$img_name='/upfile/coloum/'.'column'.time().'.'.$suffix;
					$info =  M('content_category')->where($where)->find();
					if($info['thumb']){
						$img_name = $info['thumb'];
					}
					move_uploaded_file($_FILES['thumb']['tmp_name'],'.'.$img_name);
					$data['thumb'] = $img_name;
				}
				$rel =  M('content_category')->where($where)->save($data);
				if($rel){

					$this->success('操作成功！','/'.MODULE_NAME.'/Pro/index/');exit;
				}else{
					$this->error('哎呀，出错了！');exit;
				}

			}
		}
	}

	//删除商品
	public function col_del()
	{
		$u = I('u');
		$Model   = M('content_category');
		$premise = $Model->where("`pid`='".$u."'")->find();
		if($premise){
			$this->error('该目录下存在子目录,不可删除!');
		}
		$cocont =  M('pro')->where("`col_id`=$u")->find();
		if($cocont){
			$this->error('该目录下存在商品内容,不可删除!');
		}
		$rel = $Model->where("`id`='".$u."'")->delete();
		if($rel){

			echo "<script>alert(['删除成功');window.history.back();</script>";
			// exit;
			//$this->success('操作成功！','/'.MODULE_NAME.'/Pro/index');exit;
		}else{
			$this->error('哎呀，出错了！');
		}
	}


	//商品内容
	public function content_list()
	{
		//菜单列表
		if(empty($_POST)){
			$status = 1;
		}else{
			$status = I('status');
		}

		session('page',I('page'));

		$colModel = M('pro');
		$col_id = I('col_id');


		//根据朱达分页写的
		// $I = M('pro');//积分日志表
		$count = $colModel->count(); //积分日志总数
		$page = new \Org\Util\Page($count,20);//实例化自定义分页类
		$integInfo = $colModel->order('sort Asc,create_time desc')->limit($page->limit[0],$page->limit[1])->select(); //扫码记录详情
		$this->assign('content_list',$integInfo);
		$integPage = $page->show();//调用显示方法 赋值给$codePage等待给模板传值de
		//当前页面为
		
		$this->assign('Propage',$integPage);

		//注释分页
	// 	public function business_list(){
 //        $business = M('business');
	// 	$count = $business->count();
		
	// 	$page = new \Org\Util\Page($count,50);
	// 	$businessInfo = $business->order('addtime desc')->limit($page->limit[0],$page->limit[1])->select();
		
	// 	$this->assign('businessInfo',$businessInfo);
		
	// 	$businessPage = $page->show();
	// 	$this->assign('businessPage',$businessPage);
	// 	$this->display();
	// }





		$type = 1;
		if(I('c_status') != 1){
			$type=0;
		}
		$where = "1=1";
		$col_menu =$this->col_menu($type);
		if($status!=1 ){
			$where =" status=1 ";
		}
		$this->assign('c_status',I('c_status'));
		$this->assign('col_id',I('col_id'));
		$this->assign('status',$status);
		$this->assign('col_menu',$col_menu);
		$this->display();


	}

	//添加商品内容
	public function add_content(){                       
		$Model = M('pro');
		$columnlist =$this->col_menu();
		$time = date("Y-m-d");
		$this->assign('columnlist',$columnlist);//商品菜单下拉列表
		$this->assign('col_title','添加商品');//新增商品内容
		$this->assign('time', $time);
		$this->assign('col', "add");
		$this->assign('col_from_url', "/".MODULE_NAME."/Pro/post_content_add/");//from表单提交地址
		$this->display();
	}

	//修改商品内容
	public function content_edit_index(){
		$Model = M('pro');
		$columnlist = $this->col_menu();
		$u = I('u');
		$content_data = $Model->where("`id`='".$u."'")->find();
//dump($content_data);

		$this->assign('columnlist',$columnlist);//商品菜单下拉列表
		$this->assign('content_data',$content_data);
		$this->assign('col_title','修改商品');
		$this->assign('col', "edit");
		$this->assign('u', "$u");
		$this->assign('col_from_url', "/".MODULE_NAME."/Pro/post_content_edit/");
		$this->display("add_content");
	}
	//添加商品内容
	public function post_content_add(){

		if(IS_POST || $_FILES){
			$o = I('o');
			// if(I('title') == ''){
			// 	$this->error('内容标题必须填写！');
			// }
			// if(!I('col_id')){
			// 	$this->error('所属商品必须填写！');
			// }
			if($o == 'add'){
				$a = I('title');
				$data['title']   = I('title');
				$data['names']   = I('names');
				$data['peiliao']   = I('peiliao');
				$data['zhucun']   = I('zhucun');
				$data['shiyong']   = I('shiyong');
				$data['jinghan']   = I('jinghan');
				$data['shengchan']   = I('shengchan');
				$data['price']   = I('price');
				$data['jifen']   = I('jifen');
				$data['sort']   = I('sort');
				$data['baozhi']   = I('baozhi');
				$data['chandi']   = I('chandi');
				$data['col_id']    = I('col_id');
				$arr = I('sort2');
				// var_dump($a);die;
				//必填项
				if(I('names') == ''){
				$this->error('商品名称必须填写！');
		     	}
		     	if(I('title') == ''){
				$this->error('商品编号必须填写！');
		     	}
		     	if(I('title') == ''){
				$this->error('添加时间必须填写！');
		     	}
		     	if(I('description') == ''){
				$this->error('商品简介必须填写！');
		     	}
		     	if(I('contents') == ''){
				$this->error('商品详细介绍必须填写！');
		     	}
		     	if(I('sort2') == ''){
				$this->error('发布渠道必须填写！');
		     	}
		     	if(I('jifen') == ''){
				$this->error('需要积分必须填写！');
		     	}
		     	if(I('price') == ''){
				$this->error('零售价必须填写！');
		     	}
		     	if(I('sort') == ''){
				$this->error('排序必须填写！');
		     	}
				
				$data['sort2'] = implode("",$arr);
				//商品编号唯一性
				// $m = new Model(); // 实例化一个数据库操作类 
				 
				$count1 = M('pro')->where("title='$a'")->count(); // $count 用户名在数据库出现的次数  
				if (intval($count1)>0) {  
  					  // echo '<font color="red">抱歉，商品编号'. $data['title'] .'已被注册，请更换！</font>';  
  					  
  					  // exit;已存在同名的栏目编码，请重新输入！
  					  $this->error('已存在同名的商品编码'. $data['title'] .'，请重新输入！');exit;
				} 

				//栏目名称唯一性
					 
				// $count1 = M('content_category')->where("name='$a'")->count(); // $count 用户名在数据库出现的次数  
				// if (intval($count1)>0) {  

			  // $this->error('已存在同名的栏目编码'. $data['name'] .'，请重新输入！');exit;
				// }

				if($data['sort2']==01){
					$data['sort2']=2;
				}

				if($_FILES['thumb']['error']==0) {
					list($n,$suffix)= explode('.',$_FILES['thumb']['name']);
					$img_name='/upfile/content/'.'pro'.time().'.'.$suffix;
					move_uploaded_file($_FILES['thumb']['tmp_name'],'.'.$img_name);
					$data['thumb'] = $img_name;
				}

				if(I('istop') != '' ){
					$data['istop'] = I('istop');
				}
				
				$status=I('status');
				if(strcmp($status,'')==0){
					$data['status'] = 1;
					
				}else{
					$data['status']=0;
				}

				
				$data['description'] = I('description');
				$data['contents'] = htmlspecialchars_decode(I('contents'));
				$data['create_time']  =I('create_time');
				$add = M('pro')->add($data);

				//修改排序
				$tid=M('ad_content')->getLastInsID();
				$tosort =I('sort');

				//获取排序结果集
				$sortarr = M('pro')->field('sort,id')->order('sort asc')->select();
				$update = ColumnController::sort_to_sort($sortarr,$tid,$tosort);
				foreach($update as $k=>$v){
					M('pro')->where("id=".$v['id'])->save(array('sort'=>$v['sort']));
				}
				if($add){
					$this->success('操作成功！',U('/'.MODULE_NAME.'/Pro/content_list/',array('col_id'=>I('col_id'),'status'=>1)));exit;
				}else{
					$this->error('哎呀，出错了！');exit;
				}

			}
		}

	}

	//删除商品内容
	public function content_del()
	{
		header("Content-type:text/html;charset=utf-8");
		$u = I('u');
		$Model   = M('pro');
		$rel = $Model->where("`id`='".$u."'")->delete();
		if($rel){
			// echo "<script>alert('删除成功');history.go(-1);location.reload()</script>";
			// echo "<script>alert('已经成功');location.reload()</script>";
			$this->success('操作成功！',U('/'.MODULE_NAME.'/Pro/content_list/',array('page'=>session('page'))));exit;
		}else{
			$this->error('哎呀，出错了！');
		}
	}


	//修改商品内容
	public function post_content_edit(){

		if(IS_POST || $_FILES){
			$o = I('o');
			// if(I('title') == ''){
			// 	$this->error('内容标题必须填写！');
			// }
			if($o == 'edit'){
				// if(!I('col_id')){
				// 	$this->error('所属商品必须填写！');
				// }
				$data['title']   = I('title');
				$data['names']   = I('names');
				$data['peiliao']   = I('peiliao');
				$data['zhucun']   = I('zhucun');
				$data['shiyong']   = I('shiyong');
				$data['jinghan']   = I('jinghan');
				$data['shengchan']   = I('shengchan');
				$data['price']   = I('price');
				$data['jifen']   = I('jifen');
				$data['sort']   = I('sort');
				$data['baozhi']   = I('baozhi');
				$data['chandi']   = I('chandi');
				$data['col_id']    = I('col_id');

				$arr = I('sort2');
				$data['sort2'] = implode("",$arr);
				
				if($data['sort2']==='01'){
					$data['sort2']=2;
				}
				$where['id'] = I('u');
				if($_FILES['thumb']['error']==0){									
					list($n,$suffix)= explode('.',$_FILES['thumb']['name']);
					$img_name='/upfile/content/'.'pro'.time().'.'.$suffix;
					$info =  M('pro')->where($where)->find();
					if($info['thumb']){
						$img_name = $info['thumb'];
					}
					move_uploaded_file($_FILES['thumb']['tmp_name'],'.'.$img_name);
					$data['thumb'] = $img_name;
				}
				$data['description'] = I('description');
				$data['names'] = I('names');
				$data['contents'] = htmlspecialchars_decode(I('contents'));
				$data['create_time'] = I('create_time');
				$data['update_time'] = date("Y-m-d h:i:s");
				$data['istop'] = 0;
				if(I('istop') != '' ){
					$data['istop'] = I('istop');
				}
				
				$status=I('status');
				if(strcmp($status,'')==0){
					$data['status'] = 1;
					
				}else{
					$data['status']=0;
				}


				//修改排序
				$id=I('u');
				$tosort =I('sort');

				//获取排序结果集
				$sortarr = M('pro')->field('sort,id')->order('sort asc')->select();
				$update = ColumnController::sort_to_sort($sortarr,$id,$tosort);
				foreach($update as $k=>$v){
					M('pro')->where("id=".$v['id'])->save(array('sort'=>$v['sort']));
				}

				$rel =  M('pro')->where($where)->save($data);

				if($rel){
					$this->success('操作成功！',U('/'.MODULE_NAME.'/Pro/content_list/',array('page'=>session('page'))));exit;
				}else{
					$this->error('哎呀，出错了！');exit;
				}


			}
		}
	}
}
