package com.jpush;

import java.io.StringWriter;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.Velocity;

import cn.jpush.api.JPushClient;

import com.prism.common.HttpWeb;
import com.prism.common.JsonUtil;
import com.prism.dbutil.DBConnection;
import com.prism.dbutil.VMPreparedStatement;
import com.prism.source.SourceMap;

public class TaskJob {
	private DBConnection connection;
	private String sql = "";
	private String title = "";
	private static final String corpid = "wx970cddf1694f3fc3";
	private static final String corpsecret = "oiVl1KmK-G0iwHorQIXjlXqs4Y3klleuzXK6fWvvVW_1fTK3gYu0nq13nNeZifyu";

	// 企业版微信推送
	public void jobWeiXin() {
		SimpleDateFormat dateformat1 = new SimpleDateFormat(
				"yyyy-MM-dd HH:mm:ss E");
		String a1 = dateformat1.format(new Date());
		Connection conn = connection.getConnection();
		Map<String, Object> m = new HashMap<String, Object>();
		try {
			SourceMap sourcemap = new SourceMap();
			sourcemap.setKey(sql, connection);
			VMPreparedStatement cmd = new VMPreparedStatement(conn);
			List<Map<String, Object>> l = cmd.getListColValue(sourcemap
					.get("SQL") + "");
			if (l.isEmpty()) { // 没数据不推送
				connection.closeConnection();
				System.out.println("没有数据不推送" + l);
				return;
			} else {
				Map<String, Object> text = new HashMap<String, Object>();
				vc = new VelocityContext();
				vc.put("l", l);
				
				
				
				m.put("msgtype", "text");
				m.put("agentid", "1");
				m.put("safe", "0");
				String sql = "SELECT T.USER_ID,T.USER_NAME,TOUSER FROM HNTL.SM_USER T WHERE T.TOUSER IS NOT NULL";
				if (sourcemap.containsKey("USQL")) {
					sql = "" + sourcemap.get("USQL");
				}
				cmd = new VMPreparedStatement(conn);
				List<Map<String, Object>> users = cmd.getListColValue(sql);
				String touser = "";
				for (Map<String, Object> m2 : users) {
					touser += m2.get("TOUSER") + "|";
				}
				
				m.put("touser", touser);
				
				if (sourcemap.containsKey("TEMPLATE")) {
					text.put(
							"content",
							getResultfromContent(sourcemap.get("TEMPLATE") + ""));
					m.put("text", text);
				} else {
					text.put("content", "您有新的消息");
					m.put("text", text);
				}
				JsonUtil ju = new JsonUtil();
				String content = ju.toJson(m);
				String accessToken = getCoAccessToken();
				coResText(accessToken, content);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			System.out.println("任务进行中。。。" + a1);
			connection.closeConnection();
		}

	}

	// 获取企业AccessToken
	public String getCoAccessToken() {
		String url = String
				.format("https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=%1$s&corpsecret=%2$s",
						corpid, corpsecret);
		JsonUtil ju = new JsonUtil();
		@SuppressWarnings("unchecked")
		Map<String, Object> j = (Map<String, Object>) ju.toObject(HttpWeb
				.getGetResponse(url));
		return j.get("access_token") + "";
	}

	// 企业微信发送信息
	public void coResText(String accesstoken, String content) {
		String url = String
				.format("https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token=%1$s",
						accesstoken);
		// String url =
		// "https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token=jMd2AbPnWdLRAp8D34Gr9JY1JFQX938gVLVtXzfwlv-s_7IjZdr616moiJoR1aJH";
		JsonUtil ju = new JsonUtil();
		@SuppressWarnings("unchecked")
		Map<String, Object> j = (Map<String, Object>) ju.toObject(HttpWeb
				.getGetResponse(url, content));
		System.out.println(j);

	}

	private final static String masterSecret = "d39e87324896dbbcdaa19f16";
	private final static String appKey = "9b5ca7e9af102750a0123f16";

	public void jobJPush() {// jpush推送
		SimpleDateFormat dateformat1 = new SimpleDateFormat(
				"yyyy-MM-dd HH:mm:ss E");
		String a1 = dateformat1.format(new Date());

		Connection conn = connection.getConnection();

		JPushClient jpush = new JPushClient(masterSecret, appKey);
		try {
			SourceMap map = new SourceMap();
			map.setKey(sql, connection);
			System.out.println(conn.isClosed());
			VMPreparedStatement cmd = new VMPreparedStatement(conn);
			List<Map<String, Object>> l = cmd.getListColValue(map.get("SQL")
					+ "");
			Map<String, String> extras = new HashMap<String, String>();
			if (!l.isEmpty()) {
				Map<String, Object> m = l.get(0);
				for (Map.Entry<String, Object> e : m.entrySet()) {
					extras.put(e.getKey(), e.getValue() + "");
				}
			} else {// 没有数据就不执行
				connection.closeConnection();
				System.out.println("没有数据不推送" + l);
				return;
			}
			String sql = "SELECT T.USER_ID FROM HNTL.SM_USER T";
			if (map.containsKey("USQL")) {
				sql = "" + map.get("USQL");
			}
			cmd = new VMPreparedStatement(conn);
			l = cmd.getListColValue(sql);
			String[] alias = new String[l.size()];
			int i = 0;
			for (Map<String, Object> m2 : l) {
				alias[i] = m2.get("USER_ID") + "";
				i++;
			}
			connection.closeConnection();
			jpush.sendAndroidNotificationWithAlias("通联支付", title, extras, alias);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			System.out.println("任务进行中。。。" + a1);
		}

	}

	public DBConnection getConnection() {
		return connection;
	}

	public void setConnection(DBConnection connection) {
		this.connection = connection;
	}

	public String getSql() {
		return sql;
	}

	public void setSql(String sql) {
		this.sql = sql;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	private VelocityContext vc = new VelocityContext();

	private String getResultfromContent(String s) throws Exception {
		StringWriter stringwriter;
		Velocity.init();
		stringwriter = new StringWriter();
		Velocity.evaluate(vc, stringwriter, "mystring", s);
		return stringwriter.toString();
	}
}