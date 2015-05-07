package com.prism.source;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.prism.dbutil.DBCommand;
import com.prism.exception.DAOException;

public class SourceMap extends HashMap<String, Object> implements Map<String, Object>{

	private static final long serialVersionUID = 1L;

	public void setKey(String action, Object dbConn) {
		String sql = "SELECT * FROM SM_BEAN WHERE ACTION=${ACTION<STRING>}";
		DBCommand cmd = new DBCommand(dbConn);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("ACTION", action);
		try {
			List<Map<String, Object>> list = cmd.executeSelect(sql, map);
			for (Map<String, Object> map2 : list) {
				String key2 = (String)map2.get("KEY");
				Object val2 = map2.get("VAL");
				this.put(key2, val2);
			}
			if(!this.containsKey("VIEW")){//默认值
				this.put("VIEW", "$v.toJson()");
			}
		} catch (DAOException e) {
			e.printStackTrace();
		}
	}



}
