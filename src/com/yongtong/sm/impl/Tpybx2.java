package com.yongtong.sm.impl;

import java.util.HashMap;
import java.util.Map;

import com.yongtong.sm.AnalysisSM;

public class Tpybx2 extends AnalysisSM {
	@Override
	public Map<String, Object> analysisSM(String sm) {
		Map<String, Object> map = new HashMap<String, Object>();
		String[] s = getValue("]", "，", sm);
		map.put("jsdxjxd", s[0]);
		s = getValue("我司已推荐", "的", s[1]);
		String[] s19 = s[0].split("\\W");
		String s20 = s19[s19.length-1];
		map.put("bardh", s20);
		map.put("bar", s[0].substring(0,s[0].length()-s20.length()));
		s = getValue("的","您厂维修", s[1]);
		String cp = s[0].substring(0,7);
		map.put("cp", cp);
		s[1] = s[0].substring(7);
		String pp = getPP(s[1]);
		map.put("pp", pp);
		map.put("cxd", s[1].substring(pp.length()));
		return map;
	}
	private String getPP(String str){
		int step = 0;
		int begin = 7;
		for (int i = begin; i < str.length(); i++) {
			String s = str.charAt(i) + "";
			byte[] by = s.getBytes();
			if(by.length>1){ //中文
				step = i;
				break;
			}
		}
		return str.substring(0,step);
	}

}
