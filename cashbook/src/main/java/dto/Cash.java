package dto;

public class Cash {
	private int cashNo;			// 캐시 번호
	private int categoryNo;		// 카테고리 번호
	private String kind;		// 지출 or 식비
	private String title;		// 소비 제목
	private String cashDate;	// 결제한 시간
	private int amount;			// 금액
	private String memo;		// 메모
	private String color;		// #000000 color HEX 값
	private String createDate;	// 생성일
	private String updateDate;	// 수정일
	
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getCashNo() {
		return cashNo;
	}
	public void setCashNo(int cashNo) {
		this.cashNo = cashNo;
	}
	public int getCategoryNo() {
		return categoryNo;
	}
	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}
	public String getCashDate() {
		return cashDate;
	}
	public void setCashDate(String cashDate) {
		this.cashDate = cashDate;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	
	@Override
	public String toString() {
		return "Cash [cashNo=" + cashNo + ", categoryNo=" + categoryNo + ", cashDate=" + cashDate + ", amount=" + amount
				+ ", memo=" + memo + ", color=" + color + ", createDate=" + createDate + ", updateDate=" + updateDate
				+ "]";
	}
	
}
