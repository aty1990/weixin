package com.imooc.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.imooc.po.PageAccessToken;
import com.imooc.po.UserInfo;
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
		response.setCharacterEncoding("UTF-8");
		String code = request.getParameter("code");
		UserInfo user = WeixinUtil.getPAGE_ACCESS_TOKEN_URL(code);
		request.getSession().setAttribute("accessToken", user.getAccessToken());
		request.setAttribute("user", JSONObject.fromObject(user)); 
		request.getRequestDispatcher("promise.jsp").forward(request, response);
	}
}
