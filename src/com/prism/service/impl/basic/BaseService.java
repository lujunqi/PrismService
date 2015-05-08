/**
 * service基础方法
 */
package com.prism.service.impl.basic;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.StringWriter;
import java.security.MessageDigest;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.Velocity;

import com.prism.common.JsonUtil;
import com.prism.common.VMRequest;
import com.prism.dbutil.DBCommand;
import com.prism.exception.BMOException;
import com.prism.exception.DAOException;
import com.prism.service.Service;

public class BaseService implements Service {
	protected Map<String, Object> reqMap;
	private VelocityContext vc = new VelocityContext();
	protected Object dbConn;
	private HttpServletRequest req;
	private HttpServletResponse res;

	@SuppressWarnings("unchecked")
	public void service() throws ServletException, IOException {
		reqMap = (Map<String, Object>) req.getAttribute("reqMap");
		dbConn = req.getAttribute("DBConnection");
		vc = new VelocityContext();
		// cookie参数
		Cookie[] cookies = req.getCookies();
		Map<String, Object> cookieMap = new HashMap<String, Object>();
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				Cookie cookie = cookies[i];
				cookieMap.put(cookie.getName(), cookie.getValue());
			}
		}
		reqMap.put("cookie", cookieMap);
		// session参数
		HttpSession session = req.getSession();
		Map<String, Object> sessionMap = new HashMap<String, Object>();
		Enumeration<String> en2 = session.getAttributeNames();
		while (en2.hasMoreElements()) {
			String name = (String) en2.nextElement();
			Object value = session.getAttribute(name);
			sessionMap.put(name, value);
		}
		reqMap.put("session", sessionMap);
		// json参数 单数据为String，多数据为List<Map>
		if (sourceMap.containsKey("JSON")) {
			JsonUtil ju = new JsonUtil();
			Object json = sourceMap.get("JSON");

			if (json instanceof String) {
				if (reqMap.containsKey(json)) {
					Object val = ju.toObject((String) reqMap.get(json));
					vc.put((String) json, val);
					reqMap.put((String) json, val);
				}

			} else if (json instanceof List) {
				if (reqMap.containsKey(json)) {
					List<String> list = (List<String>) json;
					for (int i = 0; i < list.size(); i++) {
						String key = (String) list.get(i);
						vc.put(key, ju.toObject((String) reqMap.get(json)));
					}
				}
			}
		}
	}

	// SELECT
	protected List<Map<String, Object>> selectResult(String key)
			throws BMOException {
		String sql = (String) sourceMap.get(key);
		String exname = getExtendName();
		if ("TOTAL".equalsIgnoreCase(exname)) {
			sql = "SELECT COUNT(1) AS TOTAL FROM (" + sql + ")";
		}
		log(sql);
		DBCommand cmd = new DBCommand(dbConn);
		try {
			if (reqMap.containsKey("prism_begin_number")
					&& reqMap.containsKey("prism_end_number")) {
				int minnum = Integer.parseInt(reqMap.get("prism_begin_number")
						+ "");
				int maxnum = Integer.parseInt(reqMap.get("prism_end_number")
						+ "");

				return cmd.executeSelect(sql, reqMap, minnum, maxnum);
			} else {
				return cmd.executeSelect(sql, reqMap);
			}
		} catch (DAOException e) {
			e.printStackTrace();
			throw new BMOException(e);
		}
	}

	private String getExtendName() {
		try {
			String relativeuri = req.getRequestURI().replaceFirst(
					req.getContextPath(), "");
			int exLen = relativeuri.lastIndexOf(".");
			StringBuffer sb = new StringBuffer(relativeuri);
			return sb.substring(exLen + 1);
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}

	protected List<Map<String, Object>> selectResult(String key, int minnum,
			int maxnum) throws BMOException {
		String sql = (String) sourceMap.get(key);
		log(sql);
		DBCommand cmd = new DBCommand(dbConn);
		try {
			return cmd.executeSelect(sql, reqMap, minnum, maxnum);
		} catch (DAOException e) {
			throw new BMOException(e);
		}
	}

	protected Map<String, Object> callResult(String key) throws BMOException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.putAll(reqMap);
		String sql = (String) sourceMap.get(key);
		log(sql);
		DBCommand cmd = new DBCommand(dbConn);
		try {
			return cmd.executeCall(sql, map);
		} catch (DAOException e) {
			throw new BMOException(e);
		}
	}

	protected Object updateResult(String key) throws BMOException {
		String sql = (String) sourceMap.get(key);
		log(sql);
		DBCommand cmd = new DBCommand(dbConn);
		try {
			return cmd.executeUpdate(sql, reqMap);
		} catch (DAOException e) {
			throw new BMOException(e);
		}
	}

	protected String convertSql() {
		return convertSql("SQL", "SQL");
	}

	protected String convertSql(String oldKey, String newKey) {
		try {
			String sql = (String) sourceMap.get(oldKey);
			log(sql);
			VMRequest v = new VMRequest();
			v.setReqMap(reqMap);
			vc.put("v", v);
			String newSql = getResultfromContent(sql);
			sourceMap.put(newKey, newSql);
			return newSql;
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
	}

	private void log(String sql) {
		System.out.println(sql);
		System.out.println(reqMap);
		System.out.println("====================="+UUID.randomUUID());
	}

	protected Object getStaticData(Object key) {
		String basePath = "e:/staticdata/";
		File[] fs = new File(basePath).listFiles();
		for (int i = 0; i < fs.length; i++) {
			Long d1 = fs[i].lastModified();
			Long d2 = new Date().getTime();
			if ((d2 - d1) > 30*1000) {// 30秒后数据失效
				fs[i].delete();
			}
		}
		File f = new File(basePath, reqMap.get("_action") + "_" + MD5(key + ""));

		if (f.exists()) {
			try {
				ObjectInputStream in = new ObjectInputStream(
						new FileInputStream(f));
				Object obj = in.readObject();
				in.close();
				return obj;
			} catch (FileNotFoundException e) {
				e.printStackTrace();
				return null;
			} catch (IOException e) {
				e.printStackTrace();
				return null;
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
				return null;
			}
		} else {
			return null;
		}
	}

	protected void setStaticData(Object key, Object val) {
		try {
			String basePath = "e:/staticdata/";
			File f = new File(basePath, reqMap.get("_action") + "_"
					+ MD5(key + ""));
			ObjectOutputStream os = new ObjectOutputStream(
					new FileOutputStream(f));
			os.writeObject(val);
			os.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	private String MD5(String s) {
		char hexDigits[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
				'A', 'B', 'C', 'D', 'E', 'F' };
		try {
			byte[] btInput = s.getBytes();
			// 获得MD5摘要算法的 MessageDigest 对象
			MessageDigest mdInst = MessageDigest.getInstance("MD5");
			// 使用指定的字节更新摘要
			mdInst.update(btInput);
			// 获得密文
			byte[] md = mdInst.digest();
			// 把密文转换成十六进制的字符串形式
			int j = md.length;
			char str[] = new char[j * 2];
			int k = 0;
			for (int i = 0; i < j; i++) {
				byte byte0 = md[i];
				str[k++] = hexDigits[byte0 >>> 4 & 0xf];
				str[k++] = hexDigits[byte0 & 0xf];
			}
			return new String(str);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	protected Map<String, Object> sourceMap = new HashMap<String, Object>();

	public void setSourceMap(Map<String, Object> sourceMap) {
		this.sourceMap = sourceMap;
	}

	public Map<String, Object> getSourceMap() {
		return sourceMap;
	}

	private String getResultfromContent(String s) throws Exception {
		StringWriter stringwriter;
		Velocity.init();
		stringwriter = new StringWriter();
		Velocity.evaluate(vc, stringwriter, "mystring", s);
		return stringwriter.toString();
	}

	@Override
	public HttpServletRequest getRequest() {
		return this.req;
	}

	@Override
	public void setRequest(HttpServletRequest req) {
		this.req = req;
	}

	@Override
	public HttpServletResponse getResponse() {
		return this.res;
	}

	@Override
	public void setResponse(HttpServletResponse res) {
		this.res = res;
	}

}
