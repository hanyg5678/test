package address;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import utility.DBClose;
import utility.DBOpen;;

public class AddressDAO {
	
	public int total(String col, String word){
	    int total = 0;
	    
	    Connection con = DBOpen.open();
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    StringBuffer sql = new StringBuffer();
	    
	    sql.append(" SELECT COUNT(*) ");
	    sql.append(" FROM address ");
	    if(word.trim().length() > 0)
	    sql.append(" WHERE "+col+ " like '%' ||?|| '%' ");
	    
	    try {
	      pstmt = con.prepareStatement(sql.toString());
	      if(word.trim().length()>0)
	        pstmt.setString(1, word);
	      rs=pstmt.executeQuery();
	      if(rs.next()){
	        total = rs.getInt(1);
	      }
	      
	    } catch (SQLException e) {
	      e.printStackTrace();
	    } finally{
	      DBClose.close(rs, pstmt, con);
	    }
	        
	    
	    return total;
	  }
	  

	public List<AddressDTO> list(Map map) {
		List<AddressDTO> list = new ArrayList<AddressDTO>();
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String col = (String)map.get("col");
		String word = (String)map.get("word");
		int sno = (Integer)map.get("sno");
		int eno = (Integer)map.get("eno");
		
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT no, name, phone, zipcode,to_char(wdate, 'yyyy-mm-dd') wdate, r ");
		sql.append(" FROM (SELECT no, name, phone, zipcode, wdate, rownum r");
		sql.append(" 	   FROM  (SELECT no, name, phone, zipcode, wdate ");
				sql.append("  	  FROM address ");
				if(word.trim().length() > 0)
					sql.append("  WHERE " + col + " LIKE '%'|| ? || '%' ");
				sql.append("      ORDER BY no DESC ");
		sql.append(" 		 	 ) ");
		sql.append(" 	  ) ");
		sql.append(" WHERE r >= ? and r <= ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			int i = 0;
			if(word.trim().length() > 0){
				pstmt.setString(++i, word);
			}
			pstmt.setInt(++i, sno);
			pstmt.setInt(++i, eno);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				AddressDTO dto = new AddressDTO();
				dto.setNo(rs.getInt("no"));
				dto.setName(rs.getString("name"));
				dto.setPhone(rs.getString("phone"));
				dto.setZipcode(rs.getString("zipcode"));
				dto.setWdate(rs.getString("wdate"));
				list.add(dto);
			}
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			DBClose.close(rs, pstmt, con);
		}
		
		return list;
	}
	public List<AddressDTO> list() {
		List<AddressDTO> list = new ArrayList<AddressDTO>();

		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT no, name, phone, zipcode, ");
		sql.append(" TO_CHAR(wdate,'yyyy-mm-dd') wdate FROM address ");
		sql.append(" ORDER BY no DESC ");

		try {
			pstmt = con.prepareStatement(sql.toString());

			rs = pstmt.executeQuery();
			while (rs.next()) {
				AddressDTO dto = new AddressDTO();
				dto.setNo(rs.getInt("no"));
				dto.setName(rs.getString("name"));
				dto.setPhone(rs.getString("phone"));
				dto.setZipcode(rs.getString("zipcode"));
				dto.setWdate(rs.getString("wdate"));
				list.add(dto);
			}
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			DBClose.close(rs, pstmt, con);
		}

		return list;
	}

	public AddressDTO read(int no) {
		AddressDTO dto = null;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();

		sql.append(" SELECT no, name, phone, zipcode, address1, address2, TO_CHAR(wdate,'yyyy-mm-dd') wdate ");
		sql.append(" FROM address ");
		sql.append(" WHERE no = ? ");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new AddressDTO();

				String name = rs.getString("name");
				String phone = rs.getString("phone");
				String zipcode = rs.getString("zipcode");
				String address1 = rs.getString("address1");
				String address2 = rs.getString("address2");
				String wdate = rs.getString("wdate");
		

				dto.setNo(no);
				dto.setName(name);
				dto.setPhone(phone);
				dto.setZipcode(zipcode);
				dto.setAddress1(address1);
				dto.setAddress2(address2);
				dto.setWdate(wdate);
			

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}

		return dto;

	}

	public boolean create(AddressDTO dto) {
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();

		boolean flag = false;
		int cnt = 0;

		sql.append(" INSERT INTO address");
		sql.append("(no, name, phone, zipcode, address1, address2, wdate) ");
		sql.append(" VALUES ((SELECT nvl(max(no),0)+1 FROM address), ");
		sql.append(" ?,?,?,?,?,sysdate )");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getPhone());
			pstmt.setString(3, dto.getZipcode());
			pstmt.setString(4, dto.getAddress1());
			pstmt.setString(5, dto.getAddress2());

			cnt = pstmt.executeUpdate();
			if (cnt > 0)
				flag = true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}

		return flag;
	}

	public boolean update(AddressDTO dto) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		int cnt = 0;

		sql.append(" UPDATE address SET ");
		sql.append(" phone = ?, ");
		sql.append(" zipcode = ?, ");
		sql.append(" address1 = ?, ");
		sql.append(" address2 = ? ");
		sql.append(" WHERE no = ? ");

		try {
			pstmt = con.prepareStatement(sql.toString());

			pstmt.setString(1, dto.getPhone());
			pstmt.setString(2, dto.getZipcode());
			pstmt.setString(3, dto.getAddress1());
			pstmt.setString(4, dto.getAddress2());
			pstmt.setInt(5, dto.getNo());

			cnt = pstmt.executeUpdate();
			if (cnt > 0)
				flag = true;

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}

		return flag;
	}

	public boolean delete(int no) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();

		int cnt = 0;

		sql.append(" DELETE FROM address");
		sql.append(" WHERE no = ?");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, no);
			cnt = pstmt.executeUpdate();

			if (cnt > 0)
				flag = true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}

		return flag;
	}
}

