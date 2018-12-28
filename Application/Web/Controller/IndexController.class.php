<?php
namespace Web\Controller;
use Think\Controller;

class IndexController extends CommonController
{
   
    public function index()
    {

		//关于我们
		$about=M("content_content as t1")->join("cs_content_category as t2 on t1.col_id=t2.id")->where("t2.tpcode='QYWH' and t1.status=1")->limit(2)->order("istop desc,t1.create_time desc,update_time desc")->field("t1.contents")->find();

		//产品中心
		$sarr = array(0,2);
		$pmap['sort2'] = array('in',$sarr);
		$productsList = M("pro")->where($pmap)->order('sort asc')->field('id,thumb,names,description')->select();
		$cmap['status'] = 1;
		$cmap['pid'] =  M("content_category")->where("tpcode='ZXZX'")->getField('id');
		$showNewsCol =  M("content_category")->where($cmap)->order('sort asc')->limit(3)->select();

		//咨询中心
		$news = array();
		foreach($showNewsCol as $k=>$v){

			$id = $v['id'];
			$temp = M("content_content")->where("col_id = $id and status=1")->order('istop desc,create_time desc,update_time desc')->limit(6)->select();
			$news[] = $temp;
		}
		//首页banner
		$banner = M("ad_content as t1")->join("cs_ad_list as t2 on t1.ad_list_id=t2.id")->where("t2.simple_code='SYGG'")->field("t1.img,t1.url")->select();

		foreach($banner as &$v){
			$v['imgurl'] = $remote_server="http://".$_SERVER['SERVER_NAME'].':'.$_SERVER['SERVER_PORT']."/upfile/".$v['img'];
		}
		//首页资讯广告
		$adtopimg = M('ad_list t1')->join("cs_ad_content t2 on t1.id = t2.ad_list_id",'left')->field("t2.img,t1.id,t2.title,t2.url")
				->where('t1.simple_code='."'SYZXGG'")->order("sort asc")->find();
		if($adtopimg){
			$adtopimg['img'] = "http://".$_SERVER['SERVER_NAME'].':'.$_SERVER['SERVER_PORT']."/upfile/".$adtopimg['img'];
			$this->assign('adtopimg',$adtopimg);
		}

		$aboutus = $this->htmlSubString( $about['contents'],200);

		//槟榔的作用
		$blzy=M("content_content as t1")->join("cs_content_category as t2 on t1.col_id=t2.id")->where("t2.tpcode='BLZY' and t1.status=1")->limit(2)->order("istop desc,t1.create_time desc,update_time desc")->field("t1.contents,t1.title,t1.thumb")->limit(3)->select();

		$aboutus = $this->CloseTags($aboutus);
		$this->assign('blzy',$blzy);
		$this->assign('aboutus',$aboutus);
		$this->assign('banner',$banner);
		$this->assign('showNewsCol',$showNewsCol);
		$this->assign('productsList',$productsList);
		$this->assign('news',$news);
		$this->display();

    }

	public function htmlSubString($content,$maxlen=300){
		//把字符按HTML标签变成数组。
		$content = preg_split("/(<[^>]+?>)/si",$content, -1,PREG_SPLIT_NO_EMPTY| PREG_SPLIT_DELIM_CAPTURE);
		$wordrows=0; //中英字数
		$outstr="";  //生成的字串
		$wordend=false; //是否符合最大的长度
		$beginTags=0; //除<img><br><hr>这些短标签外，其它计算开始标签，如<div*>
		$endTags=0;  //计算结尾标签，如</div>，如果$beginTags==$endTags表示标签数目相对称，可以退出循环。
		//print_r($content);

		foreach($content as $key=> $value){
			if($wordend==true)
				break;
			if (trim($value)=="") continue; //如果该值为空，则继续下一个值
			if (strpos(";$value","<")>0){
				//如果与要载取的标签相同，则到处结束截取。
				if (trim($value)==$maxlen) {
					$wordend=true;
					continue;
				}
				if ($wordend==false){

					if (!preg_match("/<img([^>]+?)>/is",$value) && !preg_match("/<param([^>]+?)>/is",$value) && !preg_match("/<!([^>]+?)>/is",$value) && !preg_match("/<br([^>]+?)>/is",$value) && !preg_match("/<hr([^>]+?)>/is",$value)) {
						$beginTags++; //除img,br,hr外的标签都加1
						$outstr.=$value;

					}
				}else if (preg_match("/<\/([^>]+?)>/is",$value,$matches)){
					$endTags++;
					$outstr.=$value;

					if ($beginTags==$endTags && $wordend==true) break; //字已载完了，并且标签数相称，就可以退出循环。
				}else{
					if (!preg_match("/<img([^>]+?)>/is",$value) && !preg_match("/<param([^>]+?)>/is",$value) && !preg_match("/<!([^>]+?)>/is",$value) && !preg_match("/<br([^>]+?)>/is",$value) && !preg_match("/<hr([^>]+?)>/is",$value)) {
						$beginTags++; //除img,br,hr外的标签都加1
						$outstr.=$value;
					}
				}
			}else{
				if (is_numeric($maxlen)){ //截取字数
					$curLength=$this->getStringLength($value);

					$maxLength=$curLength+$wordrows;
					if ($wordend==false){
						if ($maxLength>$maxlen){ //总字数大于要截取的字数，要在该行要截取
							$outstr.= $this->subString($value,0,$maxlen-$wordrows).'... ...';

							$wordend=true;
							break;
						}else{
							$wordrows=$maxLength;
							$outstr.=$value;
						}
					}
				}else{
					if ($wordend==false) $outstr.=$value;
				}
			}


		}

		//循环替换掉多余的标签，如<p></p>这一类
		//while(preg_match("/<([^\/][^>]*?)><\/([^>]+?)>/is",$outstr)){
		//	$outstr=preg_replace_callback("/<([^\/][^>]*?)><\/([^>]+?)>/is","strip_empty_html",$outstr);
		//}
		//
		//把误换的标签换回来
		//if (strpos(";".$outstr,"[html_")>0){
		//	$outstr=str_replace("[html_&lt;]","<",$outstr);
		//	$outstr=str_replace("[html_&gt;]",">",$outstr);
		//}exit;
		//echo htmlspecialchars($outstr);
		return $outstr;
	}

	//去掉多余的空标签
	public function strip_empty_html($matches){
		$arr_tags1=explode(" ",$matches[1]);
		if ($arr_tags1[0]==$matches[2]){ //如果前后标签相同，则替换为空。
			return "";
		}else{
			$matches[0]=str_replace("<","[html_&lt;]",$matches[0]);
			$matches[0]=str_replace(">","[html_&gt;]",$matches[0]);
			return $matches[0];
		}
	}
	//取得字符串的长度，包括中英文。
	public function getStringLength($text){
		if (function_exists('mb_substr')) {
			$length=mb_strlen($text,'UTF-8');
		} elseif (function_exists('iconv_substr')) {
			$length=iconv_strlen($text,'UTF-8');
		} else {
			preg_match_all("/[\x01-\x7f]|[\xc2-\xdf][\x80-\xbf]|\xe0[\xa0-\xbf][\x80-\xbf]|[\xe1-\xef][\x80-\xbf][\x80-\xbf]|\xf0[\x90-\xbf][\x80-\xbf][\x80-\xbf]|[\xf1-\xf7][\x80-\xbf][\x80-\xbf][\x80-\xbf]/", $text, $ar);
			$length=count($ar[0]);
		}
		return $length;
	}
	/***********按一定长度截取字符串（包括中文）*********/
	public function subString($text, $start=0, $limit=12) {
		if (function_exists('mb_substr')) {
			$more = (mb_strlen($text,'UTF-8') > $limit) ? TRUE : FALSE;
			$text = mb_substr($text, 0, $limit, 'UTF-8');
			return $text;
		} elseif (function_exists('iconv_substr')) {
			$more = (iconv_strlen($text,'UTF-8') > $limit) ? TRUE : FALSE;
			$text = iconv_substr($text, 0, $limit, 'UTF-8');
			//return array($text, $more);
			return $text;
		} else {
			preg_match_all("/[\x01-\x7f]|[\xc2-\xdf][\x80-\xbf]|\xe0[\xa0-\xbf][\x80-\xbf]|[\xe1-\xef][\x80-\xbf][\x80-\xbf]|\xf0[\x90-\xbf][\x80-\xbf][\x80-\xbf]|[\xf1-\xf7][\x80-\xbf][\x80-\xbf][\x80-\xbf]/", $text, $ar);
			if(func_num_args() >= 3) {
				if (count($ar[0])>$limit) {
					$more = TRUE;
					$text = join("",array_slice($ar[0],0,$limit));
				} else {
					$more = FALSE;
					$text = join("",array_slice($ar[0],0,$limit));
				}
			} else {
				$more = FALSE;
				$text =  join("",array_slice($ar[0],0));
			}
			return $text;
		}
	}

	public function CloseTags($html)
	{
		// strip fraction of open or close tag from end (e.g. if we take first x characters, we might cut off a tag at the end!)
		$html = preg_replace('/<[^>]*$/','',$html); // ending with fraction of open tag
		// put open tags into an array
		preg_match_all('#<([a-z]+)(?: .*)?(?<![/|/ ])>#iU', $html, $result);
		$opentags = $result[1];
		// put all closed tags into an array
		preg_match_all('#</([a-z]+)>#iU', $html, $result);

		$closetags = $result[1];
		$len_opened = count($opentags);
		// if all tags are closed, we can return
		if (count($closetags) == $len_opened) {
			return $html;
		}
		// close tags in reverse order that they were opened
		$opentags = array_reverse($opentags);
		// self closing tags
		$sc = array('br','input','img','hr','meta','link');
		// ,'frame','iframe','param','area','base','basefont','col'
		// should not skip tags that can have content inside!
		for ($i=0; $i < $len_opened; $i++)
		{
			$ot = strtolower($opentags[$i]);
			if (!in_array($opentags[$i], $closetags) && !in_array($ot,$sc))
			{
				$html .= '</'.$opentags[$i].'>';
			}
			else
			{
				unset($closetags[array_search($opentags[$i], $closetags)]);
			}
		}
		return $html;
	}

}