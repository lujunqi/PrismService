package test;

public class Test0904 {
	enum EN {
		FRANK("F1","F2"), LIU("L1","L2");
		private String p1;
		private String p2;

		private EN(String p1,String p2) {
			this.p1 = p1;
			this.p2 = p1;
		}
		public String toString(){
//			super.toString();
			return "="+p1+"="+p2;
		}
	};

	public static void main(String[] args) {
		System.out.println(EN.FRANK.p1);
	}
}
