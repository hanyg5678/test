package team;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import utility.DBClose;
import utility.DBOpen;

public class TeamDAO {
	public boolean updateFile(Map map){
		boolean flag = false;
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		
		String filename = (String) map.get("filename");
		int no = (Integer) map.get("no");
		
		sql.append(" UPDATE team ");
		sql.append(" SET filename = ? ");
		sql.append(" WHERE no = ? ");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, filename);
			pstmt.setInt(2, no);
			
			int cnt = pstmt.executeUpdate();
			
			if(cnt > 0)
				flag =true;
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DBClose.close(pstmt, con);
		}
		
		return flag;
	}
	
	
	public int total(String col, String word){
	    int total = 0;
	    
	    Connection con = DBOpen.open();
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    StringBuffer sql = new StringBuffer();
	    
	    sql.append(" SELECT COUNT(*) ");
	    sql.append(" FROM team ");
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
	  
	
	public List<TeamDTO> list(Map map) {
		List<TeamDTO> list = new ArrayList<TeamDTO>();
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String col = (String) map.get("col");
		String word = (String) map.get("word");
		int sno = (Integer) map.get("sno");
		int eno = (Integer) map.get("eno");

		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT no, name, phone, skill, filename, r ");
		sql.append(" FROM (  SELECT no, name, phone, skill, filename, rownum r");
		sql.append(" 		 FROM (  SELECT no, name, phone, skill, filename ");
				sql.append(" 		 From team ");
				if (word.trim().length() > 0)
					sql.append(" WHERE " + col + " LIKE   '%'|| ? ||'%'  ");
				sql.append(" ORDER BY no DESC ");
		sql.append(" 		      ) ");
		sql.append(" 	  ) ");
		sql.append(" WHERE r >= ? and r <= ? ");

		try {
			pstmt = con.prepareStatement(sql.toString());
			int i =0;
			if (word.trim().length() > 0) {
				pstmt.setString(++i, word);
			}
			pstmt.setInt(++i, sno);
			pstmt.setInt(++i, eno);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				TeamDTO dto = new TeamDTO();
				dto.setNo(rs.getInt("no"));
				dto.setName(rs.getString("name"));
				dto.setPhone(rs.getString("phone"));
				dto.setSkillstr(rs.getString("skill"));
				dto.setFilename(rs.getString("filename"));
				list.add(dto);
			}
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			DBClose.close(rs, pstmt, con);
		}

		return list;
	}

	public List<TeamDTO> list() {
		List<TeamDTO> list = new ArrayList<TeamDTO>();
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT no, name, phone, skill, filename ");
		sql.append(" From team ");
		sql.append(" ORDER BY no DESC ");

		try {
			pstmt = con.prepareStatement(sql.toString());

			rs = pstmt.executeQuery();
			while (rs.next()) {
				TeamDTO dto = new TeamDTO();
				dto.setNo(rs.getInt("no"));
				dto.setName(rs.getString("name"));
				dto.setPhone(rs.getString("phone"));
				dto.setSkillstr(rs.getString("skill"));
				dto.setFilename(rs.getString("filename"));
				list.add(dto);
			}
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			DBClose.close(rs, pstmt, con);
		}

		return list;
	}

	public boolean create(TeamDTO dto) {
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();

		boolean flag = false;
		int cnt = 0;

		sql.append(" INSERT INTO team ");
		sql.append(" (no, name, gender, phone, zipcode, address1, address2, skill, hobby, filename) ");
		sql.append(" VALUES((SELECT nvl(max(no),0)+1 FROM team), ?, ?, ?, ?, ?, ");
		sql.append(" ?, ?, ?, ? )");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getGender());
			pstmt.setString(3, dto.getPhone());
			pstmt.setString(4, dto.getZipcode());
			pstmt.setString(5, dto.getAddress1());
			pstmt.setString(6, dto.getAddress2());
			pstmt.setString(7, dto.getSkillstr());
			pstmt.setString(8, dto.getHobby());
			pstmt.setString(9, dto.getFilename());

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

	public TeamDTO read(int no) {
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();

		TeamDTO dto = null;

		sql.append(" SELECT * ");
		sql.append(" FROM team ");
		sql.append(" WHERE no = ? ");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new TeamDTO();

				String name = rs.getString("name");
				String gender = rs.getString("gender");
				String phone = rs.getString("phone");
				String zipcode = rs.getString("zipcode");
				String address1 = rs.getString("address1");
				String address2 = rs.getString("address2");
				String skillstr = rs.getString("skill");
				String hobby = rs.getString("hobby");
				String filename = rs.getString("filename");

				dto.setNo(no);
				dto.setName(name);
				dto.setGender(gender);
				dto.setPhone(phone);
				dto.setZipcode(zipcode);
				dto.setAddress1(address1);
				dto.setAddress2(address2);
				dto.setSkillstr(skillstr);
				dto.setHobby(hobby);
				dto.setFilename(filename);

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}

		return dto;

	}

	public boolean update(TeamDTO dto) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		int cnt = 0;

		sql.append(" UPDATE team SET ");
		sql.append(" phone = ?, zipcode = ?, address1 = ?, address2 = ?, ");
		sql.append(" skill = ?, hobby = ? ");
		sql.append(" WHERE no=?");

		try {
			pstmt = con.prepareStatement(sql.toString());

			pstmt.setString(1, dto.getPhone());
			pstmt.setString(2, dto.getZipcode());
			pstmt.setString(3, dto.getAddress1());
			pstmt.setString(4, dto.getAddress2());
			pstmt.setString(5, dto.getSkillstr());
			pstmt.setString(6, dto.getHobby());
			pstmt.setInt(7, dto.getNo());

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

		sql.append(" DELETE FROM team ");
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
