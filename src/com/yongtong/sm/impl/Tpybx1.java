package com.yongtong.sm.impl;

import java.util.HashMap;
import java.util.Map;

import com.yongtong.sm.AnalysisSM;

public class Tpybx1 extends AnalysisSM {
	@Override
	public Map<String, Object> analysisSM(String sm) {
		Map<String, Object> map = new HashMap<String, Object>();
	
		String[] s = getValue("]", ",", sm);
		map.put("jsdxjxd", s[0]);
		s = getValue("我司已推荐", "的", s[1]);
		map.put("bardh", s[0]);
		s = getValue("的","您厂维修", s[1]);
		String pp = s[0].substring(0,7);
		map.put("cp", pp);
		return map;
	}

}
