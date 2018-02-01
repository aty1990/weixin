<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'promise.jsp' starting page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">	    
	<link rel="stylesheet" type="text/css" href="https://aty1990.natapp4.cc/weixin/resource/css/index.css" />
	<style>
		html,body{
			height: 100%;
		}
		.content{
			position: fixed;
			top:41px;
			bottom: 0;
			left: 0;
			right: 0;
			overflow-y: auto;
			background: #F2F2F2;
		}
		.container{
			width: 70%;
			margin-left: 15%;
			margin-top: 30px;
			position: relative;
		}
		.promise-text{
			position: absolute;
			width: 90%;
			height: auto;
			bottom:57px;
			left: 5%;
			line-height: 30px;
			text-align: justify;
		}
		.promise-text i{
			font-style: normal;
			margin-right: 3px;
		}
		.sumbit{
			width: 80%;
			margin-left: 10%;
			margin-top:20px;
		}
		.blue{
			/* transition: all 1s linear;  */
			color:#88B3FF;
		}
		
		.disabled{
			opacity: 0.6;
		}
	</style>
  </head>
  
  <body>
    <div class="promise-page">
		<header style="background: #fff;">
			<div style="float: left;">
				<a href="javascript:history.go(-1)">
					<img src="images/ico_back@2x.png" />
				</a>
			</div>
			<p>借款承诺</p>
		</header>

		<div class="content">
			<div class="container">
				<img src="images/promise.png" width="100%">
				<div class="promise-text">
					<i v-for="word in textList">{{word}}</i>
				</div>
			</div>

			<div class="sumbit" v-show="status==1"  style="clear: both;">
				<input  type="button" @click="start" v-model="text" :class="{'disabled':disabled}" :disabled="disabled"/>
			</div>
			<div class="sumbit" v-show="status==2"  style="clear: both;">
				<input  type="button" @click="stopRead" value="朗读结束"/>
			</div>
			<div class="sumbit" v-show="submit">
				<input  type="button" @click="reStart" value="重新朗读" style="width: 100%;background: url('images/button_normal@2x1.png') no-repeat;background-size: 100% 100%;" />
			</div>
			<div class="sumbit" v-show="submit">
				<input  type="button" @click="commit" value="确认提交" style="width: 100%;" />
			</div>
			<div id="jpId"></div> 
		</div>
	</div>
	<script src="https://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	<script src="https://aty1990.natapp4.cc/weixin/resource/js/jquery-2.1.3.min.js"></script>
	<script src="https://aty1990.natapp4.cc/weixin/resource/js/vue.js"></script>
	<script src="https://aty1990.natapp4.cc/weixin/resource/js/utils.js"></script>
	<script>
	    new Vue({
		  	el: '.promise-page',
		  	data: {
		    	i : 0,
		    	className : "blue",
		    	translateResult : "",
		    	disabled : false,
		    	submit : false,
		    	text : "开始朗读",
		    	textList : ["我","保","证","借","所","借","的","我","保","证","借","所","借","的","我","保","证","借","所","借","的"],
		    	localId : "",					// 音频id
		    	timer : "",						// 定时器
		    	status : 1                      //1开始朗读  2正在朗读  3朗读结束
		  	},
		  	mounted(){
			   //this.initWxConfig();
			   //this.getVoice();
			   this.initSign();
		  	},
		  	methods:{
		  		start(){
		  			var _this = this;
		  			if(this.status==3){
		  				this.submit = true;
		  			}else if(this.status==1){
		  				//$("#jpId").jPlayer("play");
			  			this.text = "正在朗读...";
			  			this.disabled = true;
			  			// 开始录音
			  			wx.startRecord();
			  			this.readText();
			  			setTimeout(function(){
			  				_this.status = 2;
			  			},6000)
		  			}
		  		},
		  		initSign(){
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
							    jsApiList: ['startRecord', 'stopRecord','playVoice','onVoicePlayEnd','uploadVoice','downloadVoice','translateVoice','stopVoice'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
							});
				        } 
					});
		  		},
		  		stopRead(){
		  			var _this = this;
			  		_this.i = 0;
					window.clearInterval(this.timer);
					this.text = "朗读结束";
					this.disabled = false;
					this.submit = true;
					this.status = 3;
					$(".promise-text i").removeClass('blue');
					this.stopRecord();
			  	},
			  	// 停止录音
			  	stopRecord(){
			  		var _this = this;
			  		wx.stopRecord({
						success: function (res) {
							_this.localId = res.localId;
							// 录制完成后自动播放录制的音频
							_this.playVoices();
							// 识别录音
							_this.translate(res.localId);
						}
					});
			  	},
			  	// 识别录音
			  	translate(localId){
			  		var _self = this;
			  		wx.translateVoice({
						localId: localId, 					// 需要识别的音频的本地Id，由录音相关接口获得
						isShowProgressTips: 1, 				// 默认为1，显示进度提示
						success: function (res) {
							// 语音识别的结果
							_self.translateResult = res.translateResult;
							alert(res.translateResult);
						}
					});
			  	},
		  		readText(){
		  			var _self = this;
		  			var div = document.querySelector(".promise-text");
					var iList = div.querySelectorAll("i");
					_self.timer = setInterval(function(){
						iList[_self.i].className = _self.className;
						_self.i ++ ;
						if( _self.i >= iList.length ){
							_self.stopRead()
						};
					},800)
		  		},
		  		reStart(){
		  			var _self = this;
		  			_self.submit = false;
		  			_self.text = "开始朗读";
		  			_self.disabled = false;
		  			_self.status = 1;
		  			if(_self.localId){
		  				// 停止播放接口
		  				wx.stopVoice({
							localId: _self.localId
						});
		  			}
		  		},
		  		commit(){
		  			var _self = this;
		  			if(_self.localId){
		  				// 停止播放接口
		  				wx.stopVoice({
							localId: _self.localId 
						});
		  				/* utils.fetchData({
		  					url  : constans.serviceUrl + '/upload/audio',
							type : "post",
							data : {
								remark : "",
								result : _self.translateResult,
								files  : _self.localId
							},
							success:function(result){
								if(result.code == 500) {
									_self.showMsg(result.msg);
								} else {
									console.log(result);
									//window.location = constans.htmlUrl + "/index.html";
								}
							}
		  				}) */
		  			}
		  		},
		  		initWxConfig(){
		  			utils.getWxSign({
		  				success : function(data){
		  					wx.config({
								debug: false,
								appId: data.body.appid,
								timestamp: data.body.timestamp,
								nonceStr: data.body.noncestr,
								signature: data.body.signature,
								jsApiList: ['startRecord', 'stopRecord','onVoicePlayEnd','uploadVoice','downloadVoice','playVoice']
							});
						
		  				},
		  				error : function(xml,status,errorMsg){

		  				}
		  			})
		  		},
		  		// 播放当前录制的音频
		  		playVoices(){
		  			var _this = this;
		  			wx.playVoice({
						localId: _this.localId
					});
		  		},
		  		getVoice(){
		  			var _self = this;
		  			/* utils.fetchData({
	  					url  : constans.serviceUrl + '/audio/play',
						type : "post",
						success:function(result){
							if(result.code == 500) {
								_self.showMsg(result.msg);
							} else {
								for(var i = 0;i<result.body.length;i++){
									_self.textList.push(result.body[i]);
								}
							}
						}
	  				}) */
		  		}
		  	}
		})
    </script>
  </body>
</html>
