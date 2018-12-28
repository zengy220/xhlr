<?php
namespace Web\Controller;
use Think\Controller;

class MapController extends CommonController
{
	public function index(){

		$map['col_id'] = $this->id;
		$map['status'] = 1;
		$count=M("content_content")->where($map)->count();
		$p=new \Org\Util\Page($count,10,"/page_content/id/$this->id/ptpcode/$this->ptpcode");
		$show=$p->show();
		$news=M("content_content")->where($map)->order('istop desc,create_time desc,update_time desc')->limit($p->limit[0],$p->limit[1])->select();
		// var_dump($news);exit;
		$id = 32;
        $this->assign('id',$id);
        $this->assign('show',$show);
		$this->assign('news',$news);
        $this->display($this->getTplById($this->id));
	}

	public function shuju(){
         // ini_set('display_errors','Off');
        $map_info_url = 'C:\phpStudy\PHPTutorial\WWW\zwt4\Public\map_info';
        readfile($map_info_url);
	}
	


}