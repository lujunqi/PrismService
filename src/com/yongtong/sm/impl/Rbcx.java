package com.yongtong.sm.impl;

import java.util.HashMap;
import java.util.Map;

import com.yongtong.sm.AnalysisSM;

public class Rbcx extends AnalysisSM {

	@Override
	public Map<String, Object> analysisSM(String sm) {
		Map<String, Object> map = new HashMap<String, Object>();
		String[] s = getValue("报案号后6位", ",", sm);
		map.put("bah", s[0]);
		
		s = getValue("送修类型：", ",", s[1]);
		map.put("sxlx", s[0]);
		s = getValue(",", ",", s[1]);
		map.put("bar", s[0]);
		s = getValue(",", ",", s[1]);
		map.put("bardh", s[0]);
		s = getValue(",", ",",s[1]);
		map.put("cp", s[0]);
		s = getValue(",", ",",s[1]);
		map.put("pp", s[0]);
		s = getValue(",", "请知悉",s[1]);
		map.put("cxd", s[0]);
		
		return map;
	}

}

