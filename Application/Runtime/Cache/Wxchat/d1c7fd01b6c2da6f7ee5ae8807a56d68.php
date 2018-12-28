<?php if (!defined('THINK_PATH')) exit();?><html>
	<!-- 扫码结果页 -->
        <head>
        <meta>
        <title>湖南知味堂</title>
        <meta name="description" content="">
        <meta name="keywords" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <meta http-equiv="Content-Type" content="text/html; charset=utf8">
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta content="telephone=no" name="format-detection">
        <meta content="telephone=no" name="format-detection">
        <link rel="stylesheet" type="text/css" href="/Public/css/public2.css">
        <link rel="stylesheet" type="text/css" href="/Public/css/base2.css">
        <script src="/Public/js/jquery.min2.js"></script>
		<style>
			
		</style>
        </head>
        <body>
        <div class="appBody"> 
        <header class="text-center"><img src="/Public/images/logo.png" class="logo1"></header> 
        <div class="main-new flex1" > 

        <div class="white-bj pt15 pb15 mb10 pl15 pr15 text-center">
			<p class="f35px">
				<?php if($addtime != null): ?>你好,<?php echo ($userInfo["nickname"]); else: ?>你已经成为会员<?php endif; ?>
			</p>
			<p class="f28px color-73"><?php if($msg != null): echo ($msg); endif; ?></p>
			<p class="mt10 f35px color-red1">本次扫描获得<span class="f50px color-red"><?php echo ($nowPoints); ?></span>积分</p>
			<p class="color-73">您的可用积分<span class="f28px color-49"><?php echo ($userPoints); ?></span>积分</p>
			<p class="f24px color-b2 mt10">积分已转入您的账户，现金红包将以微信红包方式发放<a href="javascript:;" class=" color-red" style="text-decoration: underline;">去领红包</a></p>
        </div>
          <!--兑换-->
        <div class="mt10 duihuan-list pl15 pr15">
            <ul class="clearfix">
                <?php if(is_array($activeInfo)): $i = 0; $__LIST__ = $activeInfo;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?><li>
                    <div class="goodsBox"><img src="/Public/<?php echo ($vo["imagePath"]); ?>"></div>
                    <div class="pl10 pr10 pb5">
                    <p class="text-center text-overflow"><span class="pr5"></span><?php echo ($vo["name"]); ?></p>
                    <div class=" pos-r">积分<span class="f30px color-red"><?php echo ($vo["points"]); ?></span>
                        <a href="/Wxchat/Active/change/id/<?php echo ($vo["id"]); ?>" class="bradius3 duihuan-btn pos-a">立即兑换</a>
                    </div>
					</div>
                    </li><?php endforeach; endif; else: echo "" ;endif; ?>
				 </ul>
        <!--兑换-->
        </div>

        <div class="footer pt15 pb15  f30px">
        <div class="shaom-box text-center mb10">
        <img src="/Public/images/ewm.jpg" class="inline-block mr15"><p class="f24px color-red1 inline-block">关注知味堂公众号<br>随时了解积分活动与明细！</p>
        </div>
        <p class="pl15 pr15 f24px text-center color-b2">本活动规则解释权归湖南醇品滋味贸易有限公司所有</p></div>
        </div>
		 </div>
		
       <script>
      /*  var huiz='<div class="webkit-box box-center alert z-index1000">'+
		    	'<div class="alert-select pos-r pt10 pb10">'+
				'<div class="text-center pt20 pb20 color-red1 f30px">积分不足无法兑换</div>'+
				'<div class="fz30px sure-btn bradius4" id="hz-sure">确定</div></div></div>'+
		 		'</div>'
				
				$(".duihuan-btn").click(function(){
					$("body").append(huiz);
					$("#hz-sure").click(function(){
						$(".alert").remove();
						})
					})*/
        </script>
        </body>
        </html>