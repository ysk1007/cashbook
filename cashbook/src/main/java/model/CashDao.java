package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

import dto.*;

public class CashDao {
	//-------------------- SELECT --------------------
	// 카테고리 리스트
	public ArrayList<Cash> selectCashList(String date) throws ClassNotFoundException, SQLException{
		ArrayList<Cash> list = new ArrayList<>();
		
		// SQL 연결
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook","root","java1234");
		
		// 쿼리
		String sql = "SELECT"
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
			
			//cash.setCashNo(rs.getInt("cashNo"));
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
	public HashMap<String, ArrayList<Cash>> selectMonthList(int year, int month) throws ClassNotFoundException, SQLException {
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

	
	
	//-------------------- UPDATE --------------------
	
	//-------------------- DELETE --------------------
	
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
