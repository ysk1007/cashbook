package dto;

public class Category {
	private int categoryNo;	// 카테고리 번호
	private String kind;		// 카테고리 종류
	private String title;		// 제목
	private String createDate;	// 생성일
	private boolean doDelete;	// 삭제 가능한지
	
	public boolean isDoDelete() {
		return doDelete;
	}
	public void setDoDelete(boolean doDelete) {
		this.doDelete = doDelete;
	}
	public int getCategoryNo() {
		return categoryNo;
	}
	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}
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
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	
	@Override
	public String toString() {
		return "Category [categoryNo=" + categoryNo + ", kind=" + kind + ", title=" + title + ", createDate="
				+ createDate + "]";
	}
}
