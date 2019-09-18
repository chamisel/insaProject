package pm.insa.com.vo;

public class Test {
	private String name;
	private String sex;
	private String join_day;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getJoin_day() {
		return join_day;
	}
	public void setJoin_day(String join_day) {
		this.join_day = join_day;
	}
	@Override
	public String toString() {
		return "Test [name=" + name + ", sex=" + sex + ", join_day=" + join_day + "]";
	}
	
}
