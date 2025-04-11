package model;

import java.sql.*;
import java.util.*;

import dto.*;
import model.*;

public class ReceitDao {
	//---------------- SELECT ----------------
	
	// 영수증 하나 가져오기
	public Receit selectReceitOne(int cashNo) throws Exception{
		Receit re = new Receit();
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook","root","java1234");
		
		String sql = " SELECT "
				+ " filename AS fileName"
				+ " FROM receit "
				+ " WHERE cash_no = ?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cashNo);

		rs = stmt.executeQuery();
		
		if(rs.next()) {
			re.setFileName(rs.getString("fileName"));
		}
		
		conn.close();
		
		return re;
	}

	
	//---------------- INSERT ----------------
	
	// 영수증 이미지 첨부
	public void insertReceit(Receit re) throws ClassNotFoundException, SQLException{
		Connection conn = null;
		PreparedStatement stmt = null;

		Class.forName("com.mysql.cj.jdbc.Driver");
		
		String sql = "INSERT INTO "
				+ " receit(cash_no,filename) "
				+ " VALUES(?,?)";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook","root","java1234");
		
		stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1, re.getCashNo());
		stmt.setString(2, re.getFileName());
		
		stmt.executeUpdate();

		conn.close();
	}


	//---------------- DELETE ----------------
	// 영수증 삭제
	public boolean deleteReceit(int cashNo) throws ClassNotFoundException, SQLException{
		int row = 0;
		boolean isSuccess = false;
		Connection conn = null;
		PreparedStatement stmt = null;

		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook","root","java1234");
		
		String sql = "DELETE FROM receit "
				+ " WHERE cash_no = ?";
		stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1,cashNo);
		
		row = stmt.executeUpdate();
		
		// 디버깅
		//System.out.println(stmt);
		
		if(row == 1) {
			isSuccess = true;
		}
		else {
			isSuccess = false;
		}

		conn.close();
		
		return isSuccess;
	}
}
