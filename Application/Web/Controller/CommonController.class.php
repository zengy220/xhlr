<?php
namespace Web\Controller;
use Think\Controller;

class CommonController extends Controller
{
    //自动加载类
    public function _initialize(){
        $map['pid'] = 0;
        $map['status'] = 1;
        $topCol =  M('content_category')->where($map)->order('sort asc')->select();//项部栏目

        foreach($topCol as &$v){
            $vmap['pid']=$v['id'];
            $v['col_url'] = M('content_category')->where($vmap)->order('sort asc')->getField('col_url');
        }

        $ptpcode = I('ptpcode');
        $id = I('id');

        $pars['tpcode'] = $ptpcode;
        $pcolInfo =  M('content_category')->where($pars)->find();

        $sunCol = $this->getSunCol($ptpcode);
        if($id == ''){
            $map1['pid'] = $this->getIdByTpcode($ptpcode);
            $map1['status'] = 1;
            $res = M('content_category')->where($map1)->order('sort asc')->find();
            $id = $res['id'];
            $isShowTop = true;
            $this->assign('isShowTop',$isShowTop);
        }

        $colInfo=M("content_category")->where("tpcode='$ptpcode' and pid=0")->find();
		$bread_list=M("content_category")->where("id='$id'")->find();
		$this->assign('colInfo',$colInfo);
		$this->assign('bread_list',$bread_list);
        $this->assign('pcolInfo',$pcolInfo);

        $scolmap['id']= $id;
        $scolInfo =  $res = M('content_category')->where($scolmap)->find();
        $this->assign('pcolInfo',$pcolInfo);//当前顶级栏目信息
        $this->assign('scolInfo',$scolInfo);//当前子栏目信息

        //顶部广告
        $adtopimg = M('ad_list t1')->join("cs_ad_content t2 on t1.id = t2.ad_list_id",'left')->field("t2.img,t1.id,t2.title,t2.url")
            ->where('t1.simple_code='."'".$ptpcode."'")->order("sort asc")->find();
        if($adtopimg){
            $adtopimg['img'] = "http://".$_SERVER['SERVER_NAME'].':'.$_SERVER['SERVER_PORT']."/upfile/".$adtopimg['img'];
            $this->assign('adimg',$adtopimg);
        }
        // var_dump($ptpcode);
        // echo "333<br>";
        // var_dump($topCol);exit;
        $this->assign('topCol',$topCol);
        $this->assign('id',$id);
        $this->assign('ptpcode',$ptpcode);
        $this->assign('sunCol',$sunCol);
    }

    //获取子栏目列表
    public function getSunCol($ptpcode)
    {
        $map1['status'] = 1;
        $map1['pid'] = $this->getIdByTpcode($ptpcode);
        return M('content_category')->where($map1)->order('sort asc')->select();
    }

    //根据简码获取ID
    public function getIdByTpcode($tpcode)
    {
        $map['tpcode'] = $tpcode;
        $pCol = M('content_category')->where($map)->find();//父栏目信息
        return $pCol['id'];
    }

    //根据id获取模版
    public function getTplById($id)
    {
        $map['id'] = $id;
        $pCol = M('content_category')->where($map)->find();//父栏目信息
        return $pCol['tpl'];
    }

    //文章简述函数
    public function cutstr_html($content,$lenght){
        //对传入的文章内容 $content 进行反转义
        $content =html_entity_decode($content);
        //用 strip_tags 函数去掉所有的 html 标签
        $content =strip_tags($content);
        //替换跳格
        $content =ereg_replace("\t","", $content);
        //替换换行符
        $content =ereg_replace("\r\n","", $content);
        $content =ereg_replace("\r","", $content);
        $content =ereg_replace("\n","", $content);

        //替换中、英文空格
        $content =ereg_replace(" ","", $content);
        $content =ereg_replace(" ","", $content);

        //考虑到文章内容的长短、加个判断
        //当要截取的字符串长度不为空和文章的内容的长度大于要截取的字符串长度时要截取，否则就不截取
        if($lenght && mb_strlen(trim($content),'utf-8') > $lenght){
            //用 mb_substr 把内容编码转换 utr-8再计算长度，并从第一个字符开始截取到指定长度，再加上省略号
            return mb_substr(trim($content),0,$lenght,'utf-8').'...';
        }else{
            return trim($string);
        }
        

    }

    //自动获取文章第一张图片
    public  function get_html_first_imgurl($html){
        // var_dump($html);exit;
    $pattern = '~]*[\s]?[\/]?[\s]?>~';
    preg_match_all($pattern, $html, $matches);//正则表达式把图片的整个都获取出来了
    var_dump($matches);exit;
    $img_arr = $matches[0];//全部图片数组
    $first_img_url = "";
    if (!empty($img_arr)) {
        $first_img = $img_arr[0];
        $p="#src=('|\")(.*)('|\")#isU";//正则表达式
        preg_match_all ($p, $first_img, $img_val);
        if(isset($img_val[2][0])){
            $first_img_url = $img_val[2][0]; //获取第一张图片地址
        }
    }
    return $first_img_url;
    }



    public  function img($comtent){
        var_dump($content);
        $data['content']=$content;//获取的内容
        $soContent=$data['content'];
        $soImages = '~<img [^>]* />~';
        var_dump($soContent);exit;
        preg_match_all( $soImages, $soContent, $thePics );
        $allPics = count($thePics[0]);
        var_dump($allPics);exit;
        preg_match('/<img.+src=\"?(.+\.(jpg|gif|bmp|bnp|PNG))\"?.+>/i',$thePics[0][0],$match);
        $data['ig']=$thePics[0][0];
        //dump($data['img']);
        if( $allPics> 0 ){
        return "$match[1]";
        }
        else {
        return 222;
        }
}

public function  images($content){

    $soContent = $content;
    $soImages = '~<img [^>]* />~';
    preg_match_all( $soImages, $soContent, $thePics );
    $allPics = count($thePics[0]);
    preg_match('/<img.+src=\"?(.+\.(jpg|gif|bmp|bnp|png))\"?.+>/i',$thePics[0][0],$match);
    dump($thePics);
    if( $allPics> 0 ){
        return "<img src='".$match[1]."' title='".$match[1]."'>";//获取的图片名称
    }
    else {
        return "没有图片";
    }
}







}