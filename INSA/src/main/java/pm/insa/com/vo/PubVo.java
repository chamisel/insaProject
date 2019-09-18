package pm.insa.com.vo;


public class PubVo {
	private String gubun;
	private String code;
	private String name;
	private String note;
	public String getGubun() {
		return gubun;
	}
	public void setGubun(String gubun) {
		this.gubun = gubun;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	@Override
	public String toString() {
		return "PubVo [gubun=" + gubun + ", code=" + code + ", name=" + name + ", note=" + note + "]";
	}
	
}
