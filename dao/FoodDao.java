package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import service.DBService;
import vo.FoodVo;

public class FoodDao {
	
	static FoodDao single = null;
	
	public static FoodDao getInstance() {
		
		if(single == null)
			single = new FoodDao();
		return single;
	}
	
	private FoodDao() {
		// TODO Auto-generated constructor stub
	}

	
	public int insert(FoodVo vo) {
		// TODO Auto-generated method stub
		
		int res = 0;

		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "insert into food_kcal(f_name, f_unit_g, f_unit_kcal, animal_plant) values(?,?,?,?)";

		
			try {
				//JDBC 본코드 작성
				//1. Connection 얻어오기
				conn = DBService.getInstance().getConnection();

				//2. 명령 처리객체 (PreparedStatement 얻어오기)
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, vo.getF_name());
				pstmt.setInt(2, vo.getF_unit_g());
				pstmt.setDouble(3, vo.getF_unit_kcal());
				pstmt.setString(4, vo.getAnimal_plant());
				
				res = pstmt.executeUpdate();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				try {
					if(pstmt != null)
						pstmt.close();
					if(conn != null)
						conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
		return res;
	}

	public List<FoodVo> selectList() {
		// TODO Auto-generated method stub
		
		List<FoodVo> list = new ArrayList<FoodVo>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from food_kcal";

		try {
			//JDBC본코드 작성
			//1.Connection얻어오기
			conn = DBService.getInstance().getConnection();

			//2.PreparedStatement 얻어온다
			pstmt = conn.prepareStatement(sql);
						
			//3.ResultSet 얻어온다
			rs = pstmt.executeQuery();

			while (rs.next()) {

				//rs의 값을 담을 객체생성
				FoodVo vObj = new FoodVo();

				//현재 rs위치의 레코드내의 필드(컬럼)값 얻어오기->포장
				//컬럼값 가져오기
				vObj.setF_idx(rs.getInt("f_idx"));
				vObj.setF_name(rs.getString("f_name"));
				vObj.setF_unit_g(rs.getInt("f_unit_g"));
				vObj.setF_unit_kcal(rs.getDouble("f_unit_kcal"));
				vObj.setAnimal_plant(rs.getString("animal_plant"));
							
				//생성된 vo ArrayList담는다
				list.add(vObj);
			}

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();

		} finally {

			//마무리 코드 작성
			try {
				//열린역순
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		return list;

	}

	public FoodVo selectOne(FoodVo vo) {
		// TODO Auto-generated method stub
		
		FoodVo vObj = null;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from food_kcal where f_name=? and f_unit_kcal=? and animal_plant=?";

		try {
			//JDBC본코드 작성
			//1.Connection얻어오기
			conn = DBService.getInstance().getConnection();

			//2.PreparedStatement 얻어온다
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getF_name());
			pstmt.setDouble(2, vo.getF_unit_kcal());
			pstmt.setString(3, vo.getAnimal_plant());
						
			//3.ResultSet 얻어온다
			rs = pstmt.executeQuery();

			while (rs.next()) {

				//rs의 값을 담을 객체생성
				vObj = new FoodVo();

				//현재 rs위치의 레코드내의 필드(컬럼)값 얻어오기->포장
				//컬럼값 가져오기
				vObj.setF_name(rs.getString("f_name"));
				vObj.setF_unit_g(rs.getInt("f_unit_g"));
				vObj.setF_unit_kcal(rs.getDouble("f_unit_kcal"));
				vObj.setAnimal_plant(rs.getString("animal_plant"));
							
			}

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();

		} finally {

			//마무리 코드 작성
			try {
				//열린역순
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		
		return vObj;
	}

	public int selectOne() {
		// TODO Auto-generated method stub
		int total_kcal = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select sum(f_unit_kcal) from food_kcal";
		try {
			//JDBC본코드 작성
			//1.Connection얻어오기
			conn = DBService.getInstance().getConnection();

			//2.PreparedStatement 얻어온다
			pstmt = conn.prepareStatement(sql);
						
			//3.ResultSet 얻어온다
			rs = pstmt.executeQuery();

			while (rs.next()) {

				total_kcal = rs.getInt(1);
			}

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();

		} finally {

			//마무리 코드 작성
			try {
				//열린역순
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return total_kcal;
	}

	public int delete(int f_idx) {
		// TODO Auto-generated method stub
		int res = 0;

		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "delete from food_kcal where f_idx=?";

		
			try {
				//JDBC 본코드 작성
				//1. Connection 얻어오기
				conn = DBService.getInstance().getConnection();

				//2. 명령 처리객체 (PreparedStatement 얻어오기)
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, f_idx);
				
				res = pstmt.executeUpdate();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				try {
					if(pstmt != null)
						pstmt.close();
					if(conn != null)
						conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
		return res;
	}

}
