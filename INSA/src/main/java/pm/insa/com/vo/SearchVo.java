package pm.insa.com.vo;


public class SearchVo {

	private int sabun;				//사번		
	private String name;			//성명			
	private String hp;				//핸드폰번호
	private String reg_no;			//주민번호
	private String pos_gbn_code;	//직위
	private int salary;				//연봉(만원)
	private String join_day;		//입사일자
	private String retire_day;		//퇴사일자
	private String put_yn;			//투입여부
	public int getSabun() {
		return sabun;
	}
	public void setSabun(int sabun) {
		this.sabun = sabun;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getHp() {
		return hp;
	}
	public void setHp(String hp) {
		this.hp = hp;
	}
	public String getReg_no() {
		return reg_no;
	}
	public void setReg_no(String reg_no) {
		this.reg_no = reg_no;
	}
	public String getPos_gbn_code() {
		return pos_gbn_code;
	}
	public void setPos_gbn_code(String pos_gbn_code) {
		this.pos_gbn_code = pos_gbn_code;
	}
	public int getSalary() {
		return salary;
	}
	public void setSalary(int salary) {
		this.salary = salary;
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
	public String getPut_yn() {
		return put_yn;
	}
	public void setPut_yn(String put_yn) {
		this.put_yn = put_yn;
	}
	@Override
	public String toString() {
		return "SearchVo [sabun=" + sabun + ", name=" + name + ", hp=" + hp + ", reg_no=" + reg_no + ", pos_gbn_code="
				+ pos_gbn_code + ", salary=" + salary + ", join_day=" + join_day + ", retire_day=" + retire_day
				+ ", put_yn=" + put_yn + "]";
	}

	
}

