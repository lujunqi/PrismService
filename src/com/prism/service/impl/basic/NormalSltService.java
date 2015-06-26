/**
 * 通用查询
 * reqMap minnum maxnum用于翻页，minnum从1开始
 * (1)VIEW视图模板模式
 * (2)FORWARD 页面跳转模式
 * 数据库端处理
 * (1)SQL 普通SQL处理模式
 * (2)DSQL 动态SQL规则模式
 */
package com.prism.service.impl.basic;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;

import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.Velocity;

import com.prism.common.ExcelCommon;
import com.prism.common.JsonUtil;
import com.prism.common.VMResponse;

public class NormalSltService extends BaseService {
	private VelocityContext vc = new VelocityContext();

	public void service() throws ServletException, IOException {
		super.service();
		PrintWriter out = getResponse().getWriter();
		try {
			Long s = new Date().getTime();
			List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
			if (sourceMap.containsKey("DSQL")) {
				convertSql("DSQL", "NSQL");
				list = selectResult("NSQL");
			} else if (sourceMap.containsKey("SQL")) {
				list = selectResult("SQL");
			}
			Long e = new Date().getTime();
			String action = (String) reqMap.get("_action");
			System.out.println(action+"[耗时]================="+(e-s));
			reqMap.put(action, list);
			reqMap.put("this", list);
			getRequest().setAttribute("this", list);
			getRequest().setAttribute(action, list);
			vc.put(action, list);
			vc.put("this", list);

			// 视图模板
			if (sourceMap.containsKey("VIEW")) {
				VMResponse vm = new VMResponse();
				vm.setReqMap(reqMap);
				vc.put("v", vm);
				String content = getResultfromContent("VIEW");
				out.print(content);
			}
			// EXCEL输出
			if (sourceMap.containsKey("EXCEL")) {
				// String modelPath = (String) sourceMap.get("ModelPath");

				Date date = new Date();
				String fileName = date.getTime() + ".xls";
				getResponse().setHeader("Content-disposition",
						"attachment; filename=" + fileName);// 设定输出文件头
				getResponse().setContentType("application/msexcel");// 定义输出类型
				System.out.println(list);
				ExcelCommon excel = new ExcelCommon();
				String rule = "";
				excel.List2Excel(reqMap, null, rule, getResponse()
						.getOutputStream());
			}

			// FORWARD 页面跳转
			if (sourceMap.containsKey("FORWARD")) {
				getRequest()
						.setAttribute("TEMPLATE", sourceMap.get("TEMPLATE"));
				getRequest().getRequestDispatcher(
						(String) sourceMap.get("FORWARD")).forward(
						getRequest(), getResponse());
			}
			// REDIRECT 页面重定向
			if (sourceMap.containsKey("REDIRECT")) {
				getResponse().sendRedirect((String) sourceMap.get("REDIRECT"));
			}
		} catch (Exception e) {
			Map<String, Object> m = new HashMap<String, Object>();
			m.put("code", -1);
			m.put("info", e.getMessage());
			JsonUtil ju = new JsonUtil();
			out.println(ju.toJson(m));
			e.printStackTrace();
		}
	}

	private String getResultfromContent(String s) throws Exception {
		s = (String) sourceMap.get(s);
		StringWriter stringwriter;
		Velocity.init();
		stringwriter = new StringWriter();
		Velocity.evaluate(vc, stringwriter, "mystring", s);
		return stringwriter.toString();
	}
}
