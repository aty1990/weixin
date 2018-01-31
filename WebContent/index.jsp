<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE>
<html>
  <head>
    <base href="<%=basePath%>">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>${user.nickname}</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
	<script src="https://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
  </head>
  
  <body>
  	<input type="hidden" value="${user.headimgurl}">
  	<input type="hidden" value="${user.nickname}">
  	<input type="hidden" value="${user.openid}">
  	
  	<button onclick="getjsticket()">jsticket</button>
  	
  	<button onclick="getImg()">调用相册</button>
  	
  	<img src="" id="myimg" width="100%"/>
  	${user.nickname}
  	${sessionScope.signature }
  	<img src="${user.headimgurl}"/>
   	<script>
		function getjsticket(){
			$.ajax({ 
		        type: "post", 
		       	url: "https://aty1990.natapp4.cc/weixin/jsapi",
		       	data:{
		       		url:location.href.split('#')[0]
		       	}, 
		       	cache:false, 
		       	async:false, 
		       	dataType:"json",
		        success: function(data){ 
		        	console.log(data);
		        	console.log(data.timestamp);
					wx.config({
					    debug: true, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
					    appId: data.appid, // 必填，公众号的唯一标识
					    timestamp: data.timestamp, // 必填，生成签名的时间戳
					    nonceStr: data.nonceStr, // 必填，生成签名的随机串
					    signature: data.signature,// 必填，签名，见附录1
					    jsApiList: ['onMenuShareTimeline','chooseImage'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
					});
		        } 
			});
		}
   		function getImg(){
   			wx.chooseImage({
				count: 1, // 默认9
				sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
				sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
				success: function (res) {
					var localIds = res.localIds; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
					
					$("#myimg").attr("src",localIds);
				}
			});
   		}
   	</script>
  </body>
</html>
