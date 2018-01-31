package com.imooc.servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.imooc.po.PageAccessToken;
import com.imooc.po.UserInfo;
import com.imooc.util.SignUtil;
import com.imooc.util.WeixinUtil;

import net.sf.json.JSONObject;

public class JsApiServlet extends HttpServlet {
	public JsApiServlet() {
		super();
	}
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = request.getParameter("url");
		try {
			JSONObject json = JSONObject.fromObject(share(url,request.getSession().getAttribute("accessToken").toString())); 
			response.getWriter().print(json);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public  Map<String, String> share(String url,String accessToken) throws Exception{
		Map<String, String> ret = new HashMap<String, String>();
        String jsapi_ticket = WeixinUtil.getJsapiTicket(accessToken);
        String timestamp = Long.toString(System.currentTimeMillis() / 1000);
        String nonceStr = UUID.randomUUID().toString();
        String signature = SignUtil.getSignature(jsapi_ticket, nonceStr, timestamp,url);
        ret.put("url", url);
        ret.put("jsapi_ticket", jsapi_ticket);
        ret.put("nonceStr", nonceStr);
        ret.put("timestamp", timestamp);
        ret.put("signature", signature);
        ret.put("appid", "wxe64a74307bc7a375");
        return ret;
	}
}
