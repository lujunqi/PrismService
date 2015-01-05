package com.yongtong.service;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.baidu.yun.channel.auth.ChannelKeyPair;
import com.baidu.yun.channel.client.BaiduChannelClient;
import com.baidu.yun.channel.exception.ChannelClientException;
import com.baidu.yun.channel.exception.ChannelServerException;
import com.baidu.yun.channel.model.PushUnicastMessageRequest;
import com.baidu.yun.channel.model.PushUnicastMessageResponse;
import com.baidu.yun.core.log.YunLogEvent;
import com.baidu.yun.core.log.YunLogHandler;
import com.prism.dbutil.DBCommand;
import com.prism.dbutil.DBConnection;
import com.prism.exception.DAOException;
import com.yongtong.sm.AnalysisSM;

public class MessageService extends HttpServlet {
	private static final long serialVersionUID = 876062299485122017L;
	private static final String[] xmls = { "config/base/baseConf.xml" };
	private static ApplicationContext context;
	private Map<String, String> sqlMap = new HashMap<String, String>();

	public void init() throws ServletException {
		System.out.println("短信监听...");
		context = new ClassPathXmlApplicationContext(xmls);
		// 短信内容
		String ms = "[太平洋保险]华运通一汽丰田，我司已推荐鲁剑13874851138的湘A00E51丰田TV7252V湖南长沙芙蓉南路新元杰作写字楼停车场的出险车辆返回您厂维修";
//		analysisSM(ms);
	}
	public void service(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html;charset=UTF-8");
//		String tel_no = req.getParameter("tel_no");
		String info = req.getParameter("info");
		System.out.println(info);
		analysisSM(info);
	}
	public static void main(String[] args) {
		MessageService m = new MessageService();
		try {
			m.init();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@SuppressWarnings("unchecked")
	private void analysisSM(String sm) {
		String insurerType = getInsurerType(sm);
		try {
			if ("".equals(insurerType)) {
				return;
			}
			AnalysisSM m = (AnalysisSM) context.getBean(insurerType);
			Map<String, Object> map = m.analysisSM(sm);
			map.put("sm", sm);
			map.put("sm_no", "13907310001");
			map.put("insurer_id", insurer_id);
			sqlMap = (Map<String, String>) context.getBean("sqlMap");
			DBConnection dbConn = (DBConnection) context
					.getBean("DBConnection");
			DBCommand cmd = new DBCommand(dbConn);
			
			// 通知
			List<Map<String, Object>> list = cmd.executeSelect(
					sqlMap.get("SQL3"), map);
			if (!list.isEmpty()) {
				Map<String, Object> m68 = list.get(0);
				map.put("A_MOBILE_ID", m68.get("A_MOBILE_ID")+"");
				
				cmd.executeUpdate(sqlMap.get("SQL1"), map);
				long channelId = Long
						.parseLong(m68.get("PUSH_CHANNEL_ID") + "");
				String userId = m68.get("PUSH_USER_ID") + "";
				baiduPush(channelId, userId, sm);
			}
		} catch (Exception e) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("sm", sm);
			map.put("sm_no", "13907310001");
			map.put("insurer_id", insurer_id);
			DBConnection dbConn = (DBConnection) context
					.getBean("DBConnection");
			DBCommand cmd = new DBCommand(dbConn);
			try {
				cmd.executeUpdate(sqlMap.get("SQL2"), map);
			} catch (DAOException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		}
	}

	private void baiduPush(Long channelId, String userId, String sm) {
		// 1. 设置developer平台的ApiKey/SecretKey
		String apiKey = "GW1Nyk67VEmrXoq0iOoIw1zK";
		String secretKey = "8cT2Xw2q82VjmA6XGtW81jXuqBvH6lkk";
		ChannelKeyPair pair = new ChannelKeyPair(apiKey, secretKey);

		// 2. 创建BaiduChannelClient对象实例
		BaiduChannelClient channelClient = new BaiduChannelClient(pair);

		// 3. 若要了解交互细节，请注册YunLogHandler类
		channelClient.setChannelLogHandler(new YunLogHandler() {
			@Override
			public void onHandle(YunLogEvent event) {
				System.out.println(event.getMessage());
			}
		});

		try {

			// 4. 创建请求类对象
			// 手机端的ChannelId， 手机端的UserId， 先用1111111111111代替，用户需替换为自己的
			PushUnicastMessageRequest request = new PushUnicastMessageRequest();
			request.setDeviceType(3); // device_type => 1: web 2: pc 3:android
										// 4:ios 5:wp
			request.setChannelId(channelId);// 3577713164356852272L);
			request.setUserId(userId);// "886422116738313948");
			// request.setMessage("Hello Channel 点对点透传!");
			request.setMessageType(1);
			request.setMessage("{\"title\":\"通知\",\"description\":\"" + sm
					+ "\"}");

			// 5. 调用pushMessage接口
			PushUnicastMessageResponse response = channelClient
					.pushUnicastMessage(request);

			// 6. 认证推送成功
			System.out.println("push amount : " + response.getSuccessAmount());

		} catch (ChannelClientException e) {
			// 处理客户端错误异常
			e.printStackTrace();
		} catch (ChannelServerException e) {
			// 处理服务端错误异常
			System.out.println(String.format(
					"request_id: %d, error_code: %d, error_message: %s",
					e.getRequestId(), e.getErrorCode(), e.getErrorMsg()));
		}

	}

	private String insurer_id = "0";

	private String getInsurerType(String sm) {
		String result = "";
		if (sm.indexOf("【中国人寿财险】") != -1) {
			result = "zgrscb";
			insurer_id = "1";
		}
		if (sm.indexOf("【人保财险】") != -1) {
			result = "rbcx";
			insurer_id = "2";
		}
		if (sm.indexOf("【中国平安】") != -1) {
			result = "zgpa";
			insurer_id = "3";
		}
		if (sm.indexOf("[太平洋保险]") != -1) {
			if (sm.indexOf("三者车") != -1) {
				result = "tpybx1";
				insurer_id = "4";
			} else {
				result = "tpybx2";
				insurer_id = "4";
			}
		}
		return result;
	}

}
