<?php
namespace Web\Controller;
use Think\Controller;

class CommonController extends Controller
{
    //�Զ�������
    public function _initialize(){
        $map['pid'] = 0;
        $map['status'] = 1;
        $topCol =  M('content_category')->where($map)->order('sort asc')->select();//���Ŀ

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
        $this->assign('pcolInfo',$pcolInfo);//��ǰ������Ŀ��Ϣ
        $this->assign('scolInfo',$scolInfo);//��ǰ����Ŀ��Ϣ

        //�������
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

    //��ȡ����Ŀ�б�
    public function getSunCol($ptpcode)
    {
        $map1['status'] = 1;
        $map1['pid'] = $this->getIdByTpcode($ptpcode);
        return M('content_category')->where($map1)->order('sort asc')->select();
    }

    //���ݼ����ȡID
    public function getIdByTpcode($tpcode)
    {
        $map['tpcode'] = $tpcode;
        $pCol = M('content_category')->where($map)->find();//����Ŀ��Ϣ
        return $pCol['id'];
    }

    //����id��ȡģ��
    public function getTplById($id)
    {
        $map['id'] = $id;
        $pCol = M('content_category')->where($map)->find();//����Ŀ��Ϣ
        return $pCol['tpl'];
    }

    //���¼�������
    public function cutstr_html($content,$lenght){
        //�Դ������������ $content ���з�ת��
        $content =html_entity_decode($content);
        //�� strip_tags ����ȥ�����е� html ��ǩ
        $content =strip_tags($content);
        //�滻����
        $content =ereg_replace("\t","", $content);
        //�滻���з�
        $content =ereg_replace("\r\n","", $content);
        $content =ereg_replace("\r","", $content);
        $content =ereg_replace("\n","", $content);

        //�滻�С�Ӣ�Ŀո�
        $content =ereg_replace(" ","", $content);
        $content =ereg_replace(" ","", $content);

        //���ǵ��������ݵĳ��̡��Ӹ��ж�
        //��Ҫ��ȡ���ַ������Ȳ�Ϊ�պ����µ����ݵĳ��ȴ���Ҫ��ȡ���ַ�������ʱҪ��ȡ������Ͳ���ȡ
        if($lenght && mb_strlen(trim($content),'utf-8') > $lenght){
            //�� mb_substr �����ݱ���ת�� utr-8�ټ��㳤�ȣ����ӵ�һ���ַ���ʼ��ȡ��ָ�����ȣ��ټ���ʡ�Ժ�
            return mb_substr(trim($content),0,$lenght,'utf-8').'...';
        }else{
            return trim($string);
        }
        

    }

    //�Զ���ȡ���µ�һ��ͼƬ
    public  function get_html_first_imgurl($html){
        // var_dump($html);exit;
    $pattern = '~]*[\s]?[\/]?[\s]?>~';
    preg_match_all($pattern, $html, $matches);//������ʽ��ͼƬ����������ȡ������
    var_dump($matches);exit;
    $img_arr = $matches[0];//ȫ��ͼƬ����
    $first_img_url = "";
    if (!empty($img_arr)) {
        $first_img = $img_arr[0];
        $p="#src=('|\")(.*)('|\")#isU";//������ʽ
        preg_match_all ($p, $first_img, $img_val);
        if(isset($img_val[2][0])){
            $first_img_url = $img_val[2][0]; //��ȡ��һ��ͼƬ��ַ
        }
    }
    return $first_img_url;
    }



    public  function img($comtent){
        var_dump($content);
        $data['content']=$content;//��ȡ������
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
        return "<img src='".$match[1]."' title='".$match[1]."'>";//��ȡ��ͼƬ����
    }
    else {
        return "û��ͼƬ";
    }
}







}