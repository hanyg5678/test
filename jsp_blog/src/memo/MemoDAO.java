package memo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import utility.DBClose;
import utility.DBOpen;

public class MemoDAO {
	
	public int total(String col, String word){
		int total = 0;
		 Connection con = DBOpen.open();
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;
		    StringBuffer sql = new StringBuffer();
		    
		    sql.append(" SELECT COUNT(*) ");
		    sql.append(" FROM memo ");
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

	public List<MemoDTO> list(Map map) {
		List<MemoDTO> list = new ArrayList<MemoDTO>();
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String col = (String) map.get("col");
		String word = (String) map.get("word");
		int sno = (Integer) map.get("sno");
		int eno = (Integer) map.get("eno");

		StringBuffer sql = new StringBuffer();
		sql.append(" 	SELECT memono, title, to_char(wdate, 'yyyy-mm-dd') wdate, viewcnt, r	 ");
		sql.append(" 	FROM(SELECT memono, title, wdate, viewcnt, rownum r");
		sql.append(" 		 FROM (SELECT memono, title, wdate, viewcnt ");
				sql.append(" 	   FROM memo ");
				if (word.trim().length() > 0)
					sql.append("   WHERE " + col + " LIKE   '%'|| ? ||'%'  ");
				sql.append(" 	   ORDER BY wdate DESC ");
		sql.append(" 		 )");
		sql.append(" 	)     ");
		sql.append(" WHERE r >= ? and r <= ? ");

		try {
			pstmt = con.prepareStatement(sql.toString());
			int i = 0;
			if (word.trim().length() > 0) {
				pstmt.setString(++i, word);
			}
			pstmt.setInt(++i, sno);
			pstmt.setInt(++i, eno);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				MemoDTO dto = new MemoDTO();
				dto.setMemono(rs.getInt("memono"));
				dto.setTitle(rs.getString("title"));
				dto.setWdate(rs.getString("wdate"));
				dto.setViewcnt(rs.getInt("viewcnt"));
				list.add(dto);
			}
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			DBClose.close(rs, pstmt, con);
		}

		return list;
	}

	public List<MemoDTO> list() {
		List<MemoDTO> list = new ArrayList<MemoDTO>();
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT memono, title, TO_CHAR(wdate, 'yyyy-mm-dd') wdate,");
		sql.append(" viewcnt From memo ");
		sql.append(" ORDER BY memono DESC ");

		try {
			pstmt = con.prepareStatement(sql.toString());

			rs = pstmt.executeQuery();
			while (rs.next()) {
				MemoDTO dto = new MemoDTO();
				dto.setMemono(rs.getInt("memono"));
				dto.setTitle(rs.getString("title"));
				dto.setWdate(rs.getString("wdate"));
				dto.setViewcnt(rs.getInt("viewcnt"));
				list.add(dto);
			}
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			DBClose.close(rs, pstmt, con);
		}

		return list;
	}

	public boolean create(MemoDTO dto) {
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();

		boolean flag = false;
		int cnt = 0;

		sql.append(" INSERT INTO memo(memono, title, content, wdate)  ");
		sql.append(" VALUES(memo_seq.nextval, ?, ?, sysdate)");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());

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

	public MemoDTO read(int memono) {
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();

		MemoDTO dto = null;

		sql.append(" SELECT memono, title, content, TO_CHAR(wdate,'yyyy-mm-dd')wdate, viewcnt ");
		sql.append(" FROM memo ");
		sql.append(" WHERE memono = ? ");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, memono);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new MemoDTO();

				String title = rs.getString("title");
				String content = rs.getString("content");
				String wdate = rs.getString("wdate");
				int viewcnt = rs.getInt("viewcnt");

				dto.setMemono(memono);
				dto.setTitle(title);
				dto.setContent(content);
				dto.setWdate(wdate);
				dto.setViewcnt(viewcnt);

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}

		return dto;

	}

	public void increaseViewcnt(int memono) {
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();

		sql.append(" UPDATE memo SET ");
		sql.append(" viewcnt = viewcnt +1 ");
		sql.append(" WHERE memono = ? ");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, memono);

			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}

	}

	public boolean update(MemoDTO dto) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		int cnt = 0;

		sql.append(" UPDATE memo SET ");
		sql.append(" title =?, content =? ");
		sql.append(" WHERE memono = ? ");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setInt(3, dto.getMemono());

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

	public boolean delete(int memono) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();

		int cnt = 0;

		sql.append(" DELETE FROM memo ");
		sql.append(" WHERE memono = ?");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, memono);
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
