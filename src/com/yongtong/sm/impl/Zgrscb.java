/**
 * 
 */
package com.yongtong.sm.impl;

import java.util.HashMap;
import java.util.Map;

import com.yongtong.sm.AnalysisSM;

/**
 * @author Administrator
 *
 */
public class Zgrscb extends AnalysisSM {

	@Override
	public Map<String, Object> analysisSM(String sm) {
		Map<String, Object> map = new HashMap<String, Object>();
		String[] s = getValue("", "车架号", sm);
		map.put("cp", s[0]);
		s = getValue("车架号", ",", s[1]);
		map.put("cjh", s[0]);
		
		s = getValue(",", ",", s[1]);
		String[] s42 = s[0].split("\\W");
		map.put("xx", s42[0]);
		map.put("pp", s[0].substring(s42[0].length()));
		
		s = getValue(",出险时间", ",出险地", s[1]);
		map.put("cxsj", s[0]);
		
		s = getValue(",出险地","报案号", s[1]);
		map.put("cxd", s[0]);
		
		s = getValue("报案号",",报案人：", s[1]);
		map.put("bah", s[0]);
		
		s = getValue(",报案人：",",我司查勘员:", s[1]);
		s42 = s[0].split("\\W");

		map.put("bardh", s42[s42.length-1]);
		map.put("bar", s[0].substring(0,s[0].length()-s42[s42.length-1].length()));
		
		s = getValue(",我司查勘员:","*", s[1]);
		map.put("kcy", s[0]);
		
		s = getValue("*",",", s[1]);
		map.put("kcydh", s[0]);
		
		s = getValue(",",".【", s[1]);
		map.put("sxlx", s[0]);

		return map;
	}

}
