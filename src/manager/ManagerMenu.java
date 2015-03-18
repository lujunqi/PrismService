package manager;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ManagerMenu {
	public String service(HttpServletRequest req, HttpServletResponse res) {
		String result = "";
		@SuppressWarnings("unchecked")
		List<Map<String, Object>> list = (List<Map<String, Object>>) req
				.getAttribute("this");
		
		Map<String, Map<String, Object>> rmap = new HashMap<String, Map<String, Object>>();
		for (Map<String, Object> map : list) {
			if ("C0".equals(map.get("SUP_MENU"))) {
				String t = String
						.format("<li class=\"major\">\n"
								+ "  <h2 class=\"subtit\"><a class=\"\" href=\"#\" target=\"main\"><span class=\"\">%1$s</span></a></h2>\n"
								+ "  <ul class=\"sublist\" >\n" + "    %2$s\n"
								+ "  </ul>\n" + "</li>", map.get("MENU_NAME"),
								"%1$s");
				Map<String, Object> tmap = new HashMap<String, Object>();
				tmap.put("info", t);
				tmap.put("sub", new ArrayList<String>());

				rmap.put("C" + map.get("MENU_ID") + "", tmap);

			} else {
				String t = String.format(
						"<li><a target=\"main\" href=\"%1$s\">%2$s</a></li>",
						map.get("MENU_URL"), map.get("MENU_NAME"));
				Map<String, Object> tmap = rmap.get(map.get("SUP_MENU"));
				@SuppressWarnings("unchecked")
				List<String> list1 = (List<String>)tmap.get("sub");
				list1.add(t);
			}
		}
		for (Entry<String, Map<String, Object>> en : rmap.entrySet()) {
			Map<String, Object> map = en.getValue();
			@SuppressWarnings("unchecked")
			List<String> list1 = (List<String>)map.get("sub");
			String str0 = "";
			for (String str : list1) {
				str0+=str;
			}
			result = String.format(map.get("info")+"", str0)+result;
		}
		
		return result;
	}
}

/*

 */