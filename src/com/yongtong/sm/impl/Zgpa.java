package com.yongtong.sm.impl;

import java.util.HashMap;
import java.util.Map;

import com.yongtong.sm.AnalysisSM;

public class Zgpa extends AnalysisSM {
	@Override
	public Map<String, Object> analysisSM(String sm) {
		Map<String, Object> map = new HashMap<String, Object>();
		String[] s = getValue("", "，", sm);
		map.put("sfyrcwx", s[0]);
		s = getValue("，", "，", s[1]);
		map.put("sxlx", s[0]);
		s = getValue("，", "，", s[1]);
		map.put("ck", s[0]);
		s = getValue("报案号", "，", s[1]);
		map.put("bah", s[0]);
		
		s = getValue("车牌", "品牌", s[1]);
		map.put("cp", s[0]);
		s = getValue("品牌", "，", s[1]);
		map.put("pp", s[0]);
		s = getValue("客户", "客户电话", s[1]);
		map.put("bar", s[0]);
		s = getValue("客户电话", "，", s[1]);
		map.put("bardh", s[0]);
		
		s = getValue("出险地：", "，", s[1]);
		map.put("cxd", s[0]);
		s = getValue("出险经过：", "【", s[1]);
		map.put("cxljg", s[0]);
		
		return map;
	}

}
