package com.yongtong.sm;

import java.util.Map;

public abstract class AnalysisSM {
	public abstract Map<String, Object> analysisSM(String sm);

	protected String[] getValue(String begin, String end, String src) {
		int b_len = begin.length();
		int b_index = src.indexOf(begin);
		src = src.substring(b_index + b_len);
		int e_index = src.indexOf(end);
		String s1 = src.substring(0, e_index).trim();
		// sb = sb.delete(0, result.length()+b_len);
		String s2 = src.substring(s1.length());
		String[] result = new String[] { s1, s2 };
		return result;
	}
}
