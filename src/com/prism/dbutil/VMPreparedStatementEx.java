package com.prism.dbutil;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.prism.dbutil.bean.ExMatcher;
import com.prism.dbutil.bean.Reflect;
import com.prism.dbutil.bean.ReflectEx;
import com.prism.dbutil.bean.VMReflect;

/**
 * @author Lost.Fly
 * 模板SQL规则：输入规则 :{classname.method<dbtype>} 
 *                        支持类，
 *                        类的方法以及代参数的方法 
 *                        DBTYPE 为数据映射类型命名java.sql.Types的常量名对应
 *            输出规则 ^{mapname<dbtype>}
 *                        mapname为MAP的key值
 *                        DBTYPE 为数据映射类型命名java.sql.Types的常量名对应
 * 未实现的：1、date类型参数输入oracle版本的，jdbc固有的问题
 *         2、模板规则暂时不实现输入/出类的属性
 *         3、模板中过于复杂的类处理不实现 如：class.method.method
 */
public class VMPreparedStatementEx implements XStatement{
	private Connection conn = null;
	private Map<String,Object> map = new HashMap<String,Object>();
	private PreparedStatement cmd=null;
	private List<String> colsname = new ArrayList<String>();
	public VMPreparedStatementEx(Connection conn){
		this.conn = conn;
	}
	/**
	 * @param key String型 
	 * @param password Object型 输入映射对象
	 * @return Object型 同map的put方法
	 */
	public Object put(String key, Object obj){
		return map.put(key,obj);
	}
	/**
	 * @param key String型
	 * @param password int型 输入映射对象
	 * @return Object型 同map的put方法
	 */
	public Object put(String key, int obj){
		return map.put(key,Integer.valueOf(obj+""));
	}
	
	/**
	 * @param key String型
	 * @param password long型 输入映射对象
	 * @return Object型 同map的put方法
	 */
	public Object put(String key,long obj){
		return map.put(key,Long.valueOf(obj+""));
	}
	/**
	 * @param key Map型 
	 */
	public void putAll(Map<String,Object> map){
		this.map.putAll(map);
	}
	
	/**用于新增、修改、删除操作
	 * @param sql String型 输入的模板SQL语句
	 * @return Object型 影响记录数
	 */
	public Object executeUpdate(String sql)throws SQLException{		
		PreparedStatement cmd = conn.prepareStatement(preparedSql(sql));
		
		List<String> list = getParam(sql);
		for(int i=0;i<list.size();i++){
			String param = (String)list.get(i);
			VMReflect vm = new VMReflect();
			Reflect rf = new Reflect(param);
			int type = rf.getType();
			Object val = vm.put(param,map.get(rf.getClassName()));
			if(type==1111){
				cmd.setObject(i+1,val);
			}else{
				cmd.setObject(i+1,val,type);
			}
		}
		Integer reval = new Integer(cmd.executeUpdate());
		cmd.close();
		return reval;
	}
	/**用于存储过程操作
	 * @param sql String型 输入的模板SQL语句
	 * @return MAP型 返回存储过程中OUT的数据
	 */
	public Map<String,Object> executeCall(String sql)throws SQLException{
		Map<String,Object> tmap = new HashMap<String,Object>();
		CallableStatement cmd = conn.prepareCall(preparedSql(sql));
		List<String> list = getParam(sql);
		for(int i=0;i<list.size();i++){
			String param = (String)list.get(i);
			VMReflect vm = new VMReflect();
			Reflect rf = new Reflect(param);
			int type = rf.getType();
			int direct = rf.getDirect();
			if(direct==1){
				String classname = rf.getClassName();
				cmd.registerOutParameter(i+1,type);
				tmap.put(classname,(i+1)+"");
			}else if(direct==0){
				Object val = vm.put(param,map.get(rf.getClassName()));
				cmd.setObject(i+1,val,type);
			}
		}
		cmd.execute();
		Iterator<String> it = tmap.keySet().iterator();
		while(it.hasNext()){
			String key = (String)it.next();
			int paramindex = Integer.parseInt((String)tmap.get(key));
			Object val = cmd.getObject(paramindex);
			tmap.put(key,val);
		}
		cmd.close();
		return tmap;
	}
	/**用于可查询出大记录集时的查询操作，通过maxinum限制
	 * @param sql String型 输入的模板SQL语句
	 * @param maxinum int型 输入限制返回最大记录数 -1为不限制
	 * @return ArrayList型 返回ArrayList类型的记录集，单行记录为MAP表示 key为字段名（大写）
	 */
	public List<Map<String,Object>> getListColValue(String sql,int maxinum)throws SQLException{
		ResultSet rs = getResultSet(sql);
		List<Map<String,Object>> relist = getListFormRs(rs,maxinum);
		rs.close();
		cmd.close();
		return relist;
	}
	public List<String> getColsName(){
		return colsname;
	}
	/**用于可查询出大记录集时的查询操作
	 * @param sql String型 输入的模板SQL语句
	 * @return ResultSet型 返回ResultSet类型的记录集，
	 */
	public ResultSet getResultSet(String sql)throws SQLException{
		cmd = conn.prepareStatement(preparedSql(sql));
		List<String> list = getParam(sql);
		for(int i=0;i<list.size();i++){
			String param = (String)list.get(i);
			VMReflect vm = new VMReflect();
			ReflectEx rf = new ReflectEx(param);
			int type = rf.getType();
			Object val = vm.put(param,map.get(rf.getClassName()));
			if(type==1111){
				cmd.setObject(i+1,val);
			}else{
				cmd.setObject(i+1,val,type);
			}
		}
		ResultSet rs = cmd.executeQuery();
		return rs;
	}
	/**用于可查询出小记录集时的查询操作
	 * @param sql String型 输入的模板SQL语句
	 * @return ArrayList型 返回ArrayList类型的记录集，单行记录为MAP表示 key为字段名（大写）
	 */
	public List<Map<String,Object>> getListColValue(String sql)throws SQLException{
		return getListColValue(sql,-1);
	}
	public List<Map<String,Object>> getListFormRs(ResultSet rs,int maxinum)throws SQLException{
		List<Map<String,Object>> relist = new ArrayList<Map<String,Object>>();
		ResultSetMetaData rsmd=rs.getMetaData(); 
		int step = 0;
		while(rs.next()){
			step++;
			if(step>maxinum && maxinum!=-1){
				break;
			}
			Map<String,Object> remap = new HashMap<String,Object>();
			for(int i=1;i<=rsmd.getColumnCount();i++){
				String name = rsmd.getColumnName(i);
				colsname.add(name);
				Object value = rs.getObject(i);
				remap.put(name.toUpperCase(),value);
			}
			relist.add(remap);
		}
		return relist;
	}
	//SQL 预编译 
	private String preparedSql(String sql){
		ExMatcher ex = new ExMatcher();
		String regex = "s/[\\s(\\:,\\^)]\\{([\\s(\\w,.,\\(,\\),#,<,>)]+)\\}/?/";
		return ex.perl(sql,regex);
	}
	private List<String> getParam(String sql){
		ExMatcher ex = new ExMatcher();
		String regex = "[\\s(\\:,\\^)]\\{([\\s(\\w,.,\\(,\\),#,<,>)]+)\\}";
		return ex.regexs(sql,regex,0);
	}
}
