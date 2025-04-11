package dto;

public class Receit {
	private int cashNo;
	private String fileName;
	private String createDate;
	
	public int getCashNo() {
		return cashNo;
	}
	public void setCashNo(int cashNo) {
		this.cashNo = cashNo;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	
	@Override
	public String toString() {
		return "Receit [cashNo=" + cashNo + ", fileName=" + fileName + ", createDate=" + createDate + "]";
	}
	
	
}
