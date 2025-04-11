package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

import dto.*;

public class CashDao {
	//-------------------- SELECT --------------------
	// 카테고리 리스트
	public ArrayList<Cash> selectCashList(String date) throws Exception{
		ArrayList<Cash> list = new ArrayList<>();
		
		// SQL 연결
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook","root","java1234");
		
		// 쿼리
		String sql = "SELECT"
				+ " c.cash_no AS cashNo,"
				+ "	ct.kind AS kind,"
				+ "	ct.title AS title, "
				+ "	c.cash_date AS cashDate, "
				+ "	c.amount AS amount,"
				+ "	c.color AS color,"
				+ "	DATE_FORMAT(c.createdate,'%r') AS createDate"
				+ " FROM cash c"
				+ " INNER JOIN category ct ON ct.category_no = c.category_no"
				+ " WHERE c.cash_date = ?";
		
		// ? 할당
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, date);
		//stmt.setString(2, "%"+title+"%");
		
		// 페이징
		//stmt.setInt(3, p.getStartRow());
		//stmt.setInt(4, p.getRowPerPage());
		
		// 쿼리 실행
		rs = stmt.executeQuery();
		
		// 쿼리 디버깅
		//System.out.println(stmt);
		
		// rs가 다음으로 움직이면서 데이터가 없을때 까지 실행
		while(rs.next()) {
			Cash cash = new Cash();
			
			cash.setCashNo(rs.getInt("cashNo"));
			//cash.setCategoryNo(rs.getInt("categoryNo"));
			cash.setKind(rs.getString("kind"));
			cash.setTitle(rs.getString("title"));
			cash.setCashDate(rs.getString("cashDate"));
			cash.setAmount(rs.getInt("amount"));
			//cash.setMemo(rs.getString("memo"));
			cash.setColor(rs.getString("color"));
			cash.setCreateDate(rs.getString("createDate"));
			//cash.setUpdateDate(rs.getString("updateDate"));
			
			
			list.add(cash);
		}
		
		conn.close();
		
		return list;
	}
	
	// 월 가계부 리스트
	public HashMap<String, ArrayList<Cash>> selectMonthList(int year, int month) throws Exception {
	    HashMap<String, ArrayList<Cash>> map = new HashMap<>();
	    
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
	    
	    String sql = "SELECT"
	               + " ct.kind AS kind,"
	               + " ct.title AS title,"
	               + " c.memo AS memo,"
	               + " c.cash_date AS cashDate,"
	               + " c.amount,"
	               + " c.color"
	               + " FROM cash c"
	               + " INNER JOIN category ct ON ct.category_no = c.category_no"
	               + " WHERE YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ?"
	               + " ORDER BY c.cash_date";
	    
	    stmt = conn.prepareStatement(sql);
	    stmt.setInt(1, year);
	    stmt.setInt(2, month);
	    
	    rs = stmt.executeQuery();
	    
	    while (rs.next()) {
	        Cash cash = new Cash();
	        cash.setKind(rs.getString("kind"));
	        cash.setTitle(rs.getString("title"));
	        cash.setMemo(rs.getString("memo"));
	        cash.setCashDate(rs.getString("cashDate"));
	        cash.setAmount(rs.getInt("amount"));
	        cash.setColor(rs.getString("color"));

	        String dateKey = rs.getString("cashDate"); // yyyy-MM-dd 형식

	        if (!map.containsKey(dateKey)) {
	            map.put(dateKey, new ArrayList<>());
	        }
	        map.get(dateKey).add(cash);
	    }

	    rs.close();
	    stmt.close();
	    conn.close();
	    
	    return map;
	}

	// 수입/지출 내역 가져오기 -> cashUpdateForm 에서 사용할거임
	public HashMap<String, Object> selectCashOne(int cashNo) throws Exception {
		HashMap<String, Object> map = new HashMap<>();
	    
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
	    
	    String sql = "SELECT"
	    		   + " ct.category_no AS categoryNo,"
	               + " ct.kind AS kind,"
	               + " ct.title AS title,"
	               + " c.memo AS memo,"
	               + " c.cash_date AS cashDate,"
	               + " c.amount,"
	               + " c.color"
	               + " FROM cash c"
	               + " INNER JOIN category ct ON ct.category_no = c.category_no"
	               + " WHERE c.cash_no = ?";
	    
	    stmt = conn.prepareStatement(sql);
	    stmt.setInt(1, cashNo);
	    
	    rs = stmt.executeQuery();
	    
	    if(rs.next()) {
	    	map.put("categoryNo", rs.getString("categoryNo"));
	    	map.put("kind", rs.getString("kind"));
	    	map.put("title", rs.getString("title"));
	    	map.put("memo", rs.getString("memo"));
	    	map.put("cashDate", rs.getString("cashDate"));
	    	map.put("amount", rs.getString("amount"));
	    	map.put("color", rs.getString("color"));
	    	map.put("cashDate", rs.getString("cashDate"));
	    }

	    rs.close();
	    stmt.close();
	    conn.close();
	    
	    return map;
	}

	
	// 특정년도, 특정월의 월별 수입/지출 총액 가져오기
	public ArrayList<HashMap<String, Object>> selectMonthAmount(int year,int month) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
	    
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
	    
	    String sql = "SELECT"
			    		+ "	2025 as year, "
			    		+ " month(cash_date) AS month, "
			    		+ " kind, "
			    		+ " COUNT(*) AS count, "
			    		+ " SUM(amount) AS totalAmount"
		    		+ " FROM category ct"
		    		+ " INNER JOIN cash cs ON ct.category_no = cs.category_no"
		    		+ " WHERE YEAR(cash_date) = ? AND MONTH(cash_date) = ?"
		    		+ " GROUP BY month(cash_date), ct.kind";
		    
	    stmt = conn.prepareStatement(sql);
	    stmt.setInt(1, year);
	    stmt.setInt(2, month);
	    
	    rs = stmt.executeQuery();
	    
	    while(rs.next()) {
	    	HashMap<String,Object> map = new HashMap<>();
	    	
	    	map.put("year", rs.getInt("year"));
	    	map.put("month", rs.getInt("month"));
	    	map.put("kind", rs.getString("kind"));
	    	map.put("count", rs.getString("count"));
	    	map.put("totalAmount", rs.getString("totalAmount"));
	    	
	    	list.add(map);
	    }

	    rs.close();
	    stmt.close();
	    conn.close();
	    
	    return list;
	}
	
	// 전체 수입/지출 총액
	public ArrayList<HashMap<String, Object>> selectAllAmount() throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
	    
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
	    
	    String sql = "SELECT "
	    		+ " kind,"
	    		+ " COUNT(*) as count,"
	    		+ " SUM(amount) as amount"
	    		+ " FROM category ct"
	    		+ " INNER JOIN cash cs ON ct.category_no = cs.category_no"
	    		+ " GROUP BY ct.kind";
		    
	    stmt = conn.prepareStatement(sql);
	    
	    rs = stmt.executeQuery();
	    
	    while(rs.next()) {
	    	HashMap<String,Object> map = new HashMap<>();
	    	
	    	map.put("kind", rs.getString("kind"));
	    	map.put("count", rs.getInt("count"));
	    	map.put("amount", rs.getInt("amount"));
	    	
	    	list.add(map);
	    }

	    rs.close();
	    stmt.close();
	    conn.close();
	    
	    return list;
	}
	
	// 년도별 수입/지출 총액
	public ArrayList<HashMap<String, Object>> selectYearAmount(int year) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
	    
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
	    
	    String sql = "SELECT "
	    		+ " YEAR(cash_date) AS year, "
	    		+ " kind, "
	    		+ " COUNT(*) AS count, "
	    		+ " SUM(amount) AS amount"
	    		+ " FROM category ct"
	    		+ " INNER JOIN cash cs ON ct.category_no = cs.category_no"
	    		+ " WHERE YEAR(cash_date) = ?"
	    		+ " GROUP BY YEAR(cash_date), ct.kind"
	    		+ " ORDER BY YEAR(cash_date);";
		    
	    stmt = conn.prepareStatement(sql);
	    stmt.setInt(1, year);
	    
	    rs = stmt.executeQuery();
	    
	    while(rs.next()) {
	    	HashMap<String,Object> map = new HashMap<>();
	    	
	    	map.put("year", rs.getInt("year"));
	    	map.put("kind", rs.getString("kind"));
	    	map.put("count", rs.getInt("count"));
	    	map.put("amount", rs.getInt("amount"));
	    	
	    	list.add(map);
	    }

	    rs.close();
	    stmt.close();
	    conn.close();
	    
	    return list;
	}
	
	// 특정년도의 월별 수입/지출 총액
	public ArrayList<HashMap<String, Object>> selectMonthAmount(int year) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
	    
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
	    
	    String sql = "SELECT "
	    		+ " month(cash_date) AS month, "
	    		+ " kind, "
	    		+ " COUNT(*) AS count, "
	    		+ " SUM(amount) AS amount"
	    		+ " FROM category ct"
	    		+ " INNER JOIN cash cs ON ct.category_no = cs.category_no"
	    		+ " WHERE YEAR(cash_date) = ?"
	    		+ " GROUP BY month(cash_date), ct.kind"
	    		+ " ORDER BY month(cash_date);";
		    
	    stmt = conn.prepareStatement(sql);
	    stmt.setInt(1, year);
	    
	    rs = stmt.executeQuery();
	    
	    while(rs.next()) {
	    	HashMap<String,Object> map = new HashMap<>();
	    	
	    	map.put("month", rs.getInt("month"));
	    	map.put("kind", rs.getString("kind"));
	    	map.put("count", rs.getInt("count"));
	    	map.put("amount", rs.getInt("amount"));
	    	
	    	list.add(map);
	    }

	    rs.close();
	    stmt.close();
	    conn.close();
	    
	    return list;
	}
	
	// 카테고리별 수입/지출 총액
	public ArrayList<HashMap<String, Object>> selectCategoryAmount(int year) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
	    
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
	    
	    String sql = "SELECT "
	    		+ " ct.kind AS kind, "
	    		+ " ct.title AS title, "
	    		+ " IFNULL(SUM(cs.amount),0) AS amount"
	    		+ " FROM category ct"
	    		+ " LEFT JOIN cash cs ON ct.category_no = cs.category_no"
	    		+ "    AND YEAR(cs.cash_date) = ?"
	    		+ " GROUP BY ct.kind, ct.title"
	    		+ " ORDER BY ct.kind, ct.title";
		    
	    stmt = conn.prepareStatement(sql);
	    stmt.setInt(1, year);
	    
	    rs = stmt.executeQuery();
	    
	    while(rs.next()) {
	    	HashMap<String,Object> map = new HashMap<>();
	    	
	    	map.put("kind", rs.getString("kind"));
	    	map.put("title", rs.getString("title"));
	    	map.put("amount", rs.getInt("amount"));
	    	
	    	list.add(map);
	    }

	    rs.close();
	    stmt.close();
	    conn.close();
	    
	    return list;
	}
	
	//-------------------- UPDATE --------------------
	
	// CashOne 업데이트
	public boolean updateCash(Cash cs) throws ClassNotFoundException, SQLException{
		boolean isSuccess = false;	// 쿼리 성공 유무
		int row = 0;	// 영향 받은 행의 개수
		
		// SQL 연결
		Connection conn = null;
		PreparedStatement stmt = null;
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook","root","java1234");
		
		// 수정 쿼리
		String sql = "UPDATE cash SET "
				+ " category_no = ?,"
				+ " cash_date = ?,"
				+ " amount = ?,"
				+ " memo = ?,"
				+ " color = ?,"
				+ " updatedate = now()"
				+ " WHERE cash_no = ?";
		
		stmt = conn.prepareStatement(sql);
		
		// ? 할당
		stmt.setInt(1, cs.getCategoryNo());
		stmt.setString(2, cs.getCashDate());
		stmt.setInt(3, cs.getAmount());
		stmt.setString(4, cs.getMemo());
		stmt.setString(5, cs.getColor());
		stmt.setInt(6, cs.getCashNo());
		
		
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
	
	//-------------------- DELETE --------------------
	
	public boolean deleteCash(int cashNo) throws ClassNotFoundException, SQLException{
		boolean isSuccess = false;	// 쿼리 성공 유무
		int row = 0;	// 영향 받은 행의 개수
		
		// SQL 연결
		Connection conn = null;
		PreparedStatement stmt = null;
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook","root","java1234");
		
		// 수정 쿼리
		String sql = "DELETE IGNORE FROM cash"
				+ " WHERE cash_no = ?";
		
		stmt = conn.prepareStatement(sql);
		
		// ? 할당
		stmt.setInt(1, cashNo);
		
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
	
	//-------------------- INSERT --------------------
	
	// 리스트 카운트
	public void insertCash(Cash cs) throws ClassNotFoundException, SQLException{
		int row = 0;	// 쿼리에 영향 받은 행의 개수
		
		// SQL 연결
		Connection conn = null;
		PreparedStatement stmt = null;
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook","root","java1234");
		
		// 삽입 쿼리
		String sql = "INSERT INTO cash(category_no,cash_date,amount,memo,color) VALUES(?,?,?,?,?);";
		
		// ? 할당
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cs.getCategoryNo());
		stmt.setString(2, cs.getCashDate());
		stmt.setInt(3, cs.getAmount());
		stmt.setString(4, cs.getMemo());
		stmt.setString(5, cs.getColor());

		// 쿼리 디버깅
		//System.out.println(stmt);
		
		// 쿼리 실행
		row = stmt.executeUpdate();
		
		if(row == 1) {	// 정상 삽입
			
		}
		else { // 비정상
			
		}
		
		conn.close();
	}
}
