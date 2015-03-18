package com.prism.common;

import java.io.File;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jxl.Workbook;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import com.prism.common.bean.VMExcel;

public class VMResponse {
	private Map<String, Object> reqMap = new HashMap<String, Object>();

	public Map<String, Object> getReqMap() {
		return reqMap;
	}

	public void setReqMap(Map<String, Object> reqMap) {
		this.reqMap = reqMap;
	}

	public String toJson(String key) {
		JsonUtil ju = new JsonUtil();
		return ju.toJson(reqMap.get(key));
	}

	public String toJson() {
		return toJson("this");
	}

	public void toExcel(String key, String modelPath, 
			OutputStream os) {
		Object obj = reqMap.get(key);
		if (obj instanceof List) {
			try {
				@SuppressWarnings("unchecked")
				List<Map<String, Object>> list = (List<Map<String, Object>>) obj;
				Workbook wb = Workbook.getWorkbook(new File(modelPath));
				WritableWorkbook wwb = Workbook.createWorkbook(os, wb);
				WritableSheet ws = wwb.getSheet(0);
				VMExcel excel = new VMExcel(ws);
				for (Map<String,Object> map : list) {
//					excel.add(1, r, value, mc, mr);
				}
			} catch (Exception e) {

			}
		}
		// excel.List2Excel(param, modelPath, rule, os);
	}
}
