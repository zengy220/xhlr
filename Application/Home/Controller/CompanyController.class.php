<?php
/*	组织|分公司控制器  */
namespace Home\Controller;
use Home\Controller;
class CompanyController extends CommonController
{
	public function index(){
		echo '分公司控制器首页方法';
	}
	
	//组织|分公司列表
	public function company_list(){
		$company = M('company');
		if( isset($_SESSION['role_identity']) && $_SESSION['role_identity'] == 0 ){
			$count = $company->count();
			$page = new \Org\Util\Page($count,50);
			$companyInfo = $company->order('company_id asc')->limit($page->limit[0],$page->limit[1])->select();
			$companyPage = $page->show();
		}else{
			$companyInfo = $company->where('company_id='.$_SESSION['company'])->order('company_id asc')->select();
		}
		
		$this->assign('companyInfo',$companyInfo);
		$this->assign('companyPage',$companyPage);
		$this->display();
	}
	
	//添加组织页面
	public function company_add_html(){
		$this->display();
	}
	
	//添加组织动作
	public function company_add(){
		header("Content-type:text/html;charset=utf-8");
		$companyModel = M('company');
		$data = array(
			'company_name'  => trim(I('company_name')),
			'company_type'  => 2,
			'company_status'=> trim(I('company_status')),
			'company_num'	=> trim(I('company_num')),
			'company_time'  => time()
		);
		
		if($data['company_num'] == 0){
			echo '<script>alert("必须填写组织编号!");history.go(-1)</script>';exit;
		}
		
		$company_num = $companyModel->field('company_num')->where("company_num='".$data['company_num']."'")->find();
		
		if($company_num['company_num'] != null){
			echo '<script>alert("组织编号已存在！");history.go(-1)</script>';exit;
		}
		
		$rs = $companyModel->add($data);
		if(!$rs){
			$this->error('添加组织失败','/Home/Company/company_list');
		}else{
			$this->success('添加组织成功','/Home/Company/company_list');
		}
	}
	
	//删除组织
	public function company_del(){
		$company_id = I('company_id');
		
		if($company_id == $_SESSION['company']){
			$this->error('您不能删除自己的组织！');exit;
		}
		$rs = M('company')->where("company_id=$company_id")->delete();
		if(!$rs){
			$this->error('删除组织失败','/Home/Company/company_list');
		}else{
			$this->error('删除组织成功','/Home/Company/company_list');
		}
	}
	
	//编辑组织页面
	public function company_update_html(){
		$company_id = I('company_id');
		$companyInfo = M('company')->where("company_id='".$company_id."'")->find();

		$rel = M('system_variables')->where("variable_type=1")->select();
		$this->assign('data',$rel);
		$this->assign('companyInfo',$companyInfo);
		$this->display();
	}
	
	//编辑组织动作
	public function company_update(){
		$company_id = I('company_id'); 
		$data = array(
			'company_name'  => trim(I('company_name')),
			'company_status'=> trim(I('company_status')),
			'company_time'  => time()
		);
		$rs = M('company')->data($data)->where('company_id='.$company_id)->save();
		//echo M()->getLastSql();exit;
		
		if(!$rs){
			$this->error('修改组织失败', '/Home/Company/company_update_html/company_id/'.$company_id);
		}else{
			$this->success('修改组织成功','/Home/Company/company_list');
		}
	}
	
	
}
