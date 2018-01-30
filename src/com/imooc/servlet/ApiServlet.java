package com.imooc.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.imooc.po.PageAccessToken;
import com.imooc.util.WeixinUtil;

import net.sf.json.JSONObject;

public class ApiServlet extends HttpServlet {
	public ApiServlet() {
		super();
	}
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String code = request.getParameter("code");
		PageAccessToken token = WeixinUtil.getPAGE_ACCESS_TOKEN_URL(code);
		System.out.println(token.getToken());
		response.getWriter().print(JSONObject.fromObject(token));
	}
}
