package model;

import java.sql.*;
import java.util.*;
import dto.*;

public class CategoryDao {
	//-------------------- SELECT --------------------

	// 카테코리 하나 가져오기
	public Category selectCategoryOne(int num) throws ClassNotFoundException, SQLException{
		Category ct = new Category();
		
		// SQL 연결
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook","root","java1234");
		
		// 쿼리
		String sql = "SELECT "
				+ " category_no AS categoryNo, "
				+ " kind, "
				+ " title, "
				+ " createdate AS createDate "
				+ " FROM category "
				+ " WHERE category_no = ?";
		
		// ? 할당
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, num);
		
		// 쿼리 실행
		rs = stmt.executeQuery();
		
		// 쿼리 디버깅
		//System.out.println(stmt);
		
		// rs가 다음으로 움직이면서 데이터가 없을때 까지 실행
		if(rs.next()) {
			ct.setCategoryNo(rs.getInt("categoryNo"));
			ct.setKind(rs.getString("kind"));
			ct.setTitle(rs.getString("title"));
			ct.setCreateDate(rs.getString("createDate"));
		}
		
		conn.close();
		
		return ct;
	}
	
	// 카테고리 리스트
	public ArrayList<Category> selectCategoryList(Paging p,String kind, String title) throws ClassNotFoundException, SQLException{
		ArrayList<Category> list = new ArrayList<>();
		
		// SQL 연결
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook","root","java1234");
		
		// 쿼리
		String sql = "SELECT "
				+ " category_no AS categoryNo, "
				+ " kind, "
				+ " title, "
				+ " createdate AS createDate "
				+ " FROM category "
				+ " WHERE kind LIKE ? AND title LIKE ?"
				+ " ORDER BY category_no DESC"
				+ " LIMIT ?,?";
		
		// ? 할당
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+kind+"%");
		stmt.setString(2, "%"+title+"%");
		
		// 페이징
		stmt.setInt(3, p.getStartRow());
		stmt.setInt(4, p.getRowPerPage());
		
		// 쿼리 실행
		rs = stmt.executeQuery();
		
		// 쿼리 디버깅
		System.out.println(stmt);
		
		// rs가 다음으로 움직이면서 데이터가 없을때 까지 실행
		while(rs.next()) {
			Category ct = new Category();
			
			ct.setCategoryNo(rs.getInt("categoryNo"));
			ct.setKind(rs.getString("kind"));
			ct.setTitle(rs.getString("title"));
			ct.setCreateDate(rs.getString("createDate"));
			
			list.add(ct);
		}
		
		conn.close();
		
		return list;
	}

	// 리스트 카운트
	public int selectListRow(String kind, String title) throws ClassNotFoundException, SQLException{
		int count = 0;
		// SQL 연결
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook","root","java1234");
		
		// 쿼리
		String sql = "SELECT "
				+ " COUNT(*) AS count"
				+ " FROM category "
				+ " WHERE kind LIKE ? AND title LIKE ?";
		
		// ? 할당
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+kind+"%");
		stmt.setString(2, "%"+title+"%");

		// 쿼리 실행
		rs = stmt.executeQuery();
		
		// 쿼리 디버깅
		//System.out.println(stmt);
		
		if(rs.next()) {
			count = rs.getInt("count");
		}
		
		conn.close();
		
		return count;
	}
	
	// 카테고리 리스트 종류하고 이름 가져오기
	public ArrayList<Category> selectCategoryValue(String kind) throws ClassNotFoundException, SQLException{
		ArrayList<Category> list = new ArrayList<>();
		
		// SQL 연결
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook","root","java1234");
		
		// 쿼리
		String sql = "SELECT "
				+ " category_no AS categoryNo,"
				+ " kind,"
				+ " title "
				+ " FROM category"
				+ " WHERE kind LIKE ?";
		
		stmt = conn.prepareStatement(sql);
		
		// ? 값
		stmt.setString(1, "%"+kind+"%");
		
		// 쿼리 실행
		rs = stmt.executeQuery();

		// 쿼리 디버깅
		//System.out.println(stmt);
		
		// rs가 다음으로 움직이면서 데이터가 없을때 까지 실행
		while(rs.next()) {
			Category ct = new Category();
			
			ct.setCategoryNo(rs.getInt("categoryNo"));
			ct.setKind(rs.getString("kind"));
			ct.setTitle(rs.getString("title"));
			
			list.add(ct);
		}
		
		conn.close();
		
		return list;
	}
	
	//-------------------- UPDATE --------------------
	
	public boolean updateCategory(Category ct) throws ClassNotFoundException, SQLException{
		boolean isSuccess = false;	// 쿼리 성공 유무
		int row = 0;	// 영향 받은 행의 개수
		
		// SQL 연결
		Connection conn = null;
		PreparedStatement stmt = null;
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook","root","java1234");
		
		// 수정 쿼리
		String sql = "UPDATE category SET "
				+ " kind = ?,"
				+ " title = ?"
				+ " WHERE category_no = ?";
		
		stmt = conn.prepareStatement(sql);
		
		// ? 할당
		stmt.setString(1, ct.getKind());
		stmt.setString(2, ct.getTitle());
		stmt.setInt(3, ct.getCategoryNo());
		
		// 쿼리 실행
		row = stmt.executeUpdate();
		
		// 쿼리 디버깅
		System.out.println(stmt);

		if(row == 1) {
			isSuccess = true;
		}
		
		conn.close();
		
		return isSuccess;
	}
	
	//-------------------- INSERT --------------------
	
	// 리스트 카운트
	public void insertCategory(Category ct) throws ClassNotFoundException, SQLException{
		int row = 0;	// 쿼리에 영향 받은 행의 개수
		
		// SQL 연결
		Connection conn = null;
		PreparedStatement stmt = null;
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook","root","java1234");
		
		// 삽입 쿼리
		String sql = "INSERT IGNORE INTO category(kind,title) VALUES(?,?)";
		
		// ? 할당
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, ct.getKind());
		stmt.setString(2, ct.getTitle());

		// 쿼리 디버깅
		System.out.println(stmt);
		
		// 쿼리 실행
		row = stmt.executeUpdate();
		
		if(row == 1) {	// 정상 삽입
			
		}
		else { // 비정상
			
		}
		
		conn.close();
	}
	
	//-------------------- DELETE --------------------
	
	public boolean deleteCategory(int num) throws ClassNotFoundException, SQLException{
		boolean isSuccess = false;	// 쿼리 성공 유무
		int row = 0;	// 영향 받은 행의 개수
		
		// SQL 연결
		Connection conn = null;
		PreparedStatement stmt = null;
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook","root","java1234");
		
		// 수정 쿼리
		String sql = "DELETE IGNORE FROM category"
				+ " WHERE category_no = ?";
		
		stmt = conn.prepareStatement(sql);
		
		// ? 할당
		stmt.setInt(1, num);
		
		// 쿼리 실행
		row = stmt.executeUpdate();
		
		// 쿼리 디버깅
		//System.out.println(stmt);

		if(row == 1) {
			isSuccess = true;
		}
		
		conn.close();
		
		return isSuccess;
	}
	
}
