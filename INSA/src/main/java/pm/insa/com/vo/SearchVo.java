package pm.insa.com.vo;


public class SearchVo {

	private String sabun;
	private String name;
	private String pos_gbn_code;
	private String join_day;
	private String retire_day;
	private String join_gbn_code;
	public String getSabun() {
		return sabun;
	}
	public void setSabun(String sabun) {
		this.sabun = sabun;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPos_gbn_code() {
		return pos_gbn_code;
	}
	public void setPos_gbn_code(String pos_gbn_code) {
		this.pos_gbn_code = pos_gbn_code;
	}
	public String getJoin_day() {
		return join_day;
	}
	public void setJoin_day(String join_day) {
		this.join_day = join_day;
	}
	public String getRetire_day() {
		return retire_day;
	}
	public void setRetire_day(String retire_day) {
		this.retire_day = retire_day;
	}
	public String getJoin_gbn_code() {
		return join_gbn_code;
	}
	public void setJoin_gbn_code(String join_gbn_code) {
		this.join_gbn_code = join_gbn_code;
	}
	@Override
	public String toString() {
		return "SearchVo [sabun=" + sabun + ", name=" + name + ", pos_gbn_code=" + pos_gbn_code + ", join_day="
				+ join_day + ", retire_day=" + retire_day + ", join_gbn_code=" + join_gbn_code + "]";
	}	
	
}

