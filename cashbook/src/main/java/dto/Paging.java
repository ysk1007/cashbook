package dto;

public class Paging {
	private int currentPage;	// 현재 페이지
	private int rowPerPage;		// 한 페이지에 보여줄 데이터 수
	
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getRowPerPage() {
		return rowPerPage;
	}
	public void setRowPerPage(int rowPerPage) {
		this.rowPerPage = rowPerPage;
	}
	
	// 데이터 시작할 위치
	public int getStartRow() {
		return (this.currentPage - 1) * this.rowPerPage;
	}
	
	// 마지막 페이지 구하는 메소드
	public int getLastPage(int totalRow) {
		int lastPage = totalRow / this.rowPerPage;
		
		// 전체 페이지가 한 페이지에 보여줄 데이터 수로 안 나누어진다면
		// 데이터가 남아있어서 한 페이지 증가 시켜줘야 함
		if(totalRow % this.rowPerPage != 0) {
			lastPage++;
		}
		
		return lastPage;
	}
}
