package bbs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import utility.DBClose;
import utility.DBOpen;

public class BbsDAO {

	// 지우려는 대상의 레코드가 부모의 글인지 확인하는 메서드
	// 부모글일 경우 true not 부모글이면 false
	// 부모글이면 삭제못한다
	public boolean chechRefno(int bbsno) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT count(refno) FROM bbs ");
		sql.append(" WHERE refno = ? ");
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				int cnt = rs.getInt(1);
				if (cnt > 0) {
					flag = true;
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}

		return flag;
	}

	public int total(String col, String word) {
		int total = 0;

		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();

		sql.append(" SELECT COUNT(*) ");
		sql.append(" FROM bbs ");
		if (word.trim().length() > 0)
			sql.append(" WHERE " + col + " like '%' ||?|| '%' ");

		try {
			pstmt = con.prepareStatement(sql.toString());
			if (word.trim().length() > 0)
				pstmt.setString(1, word);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				total = rs.getInt(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}

		return total;
	}

	public List<BbsDTO> list(Map map) {
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = null; // String 보다 처리 속도가 수만배 빠름.
		List<BbsDTO> list = null;
		String col = (String) map.get("col");
		String word = (String) map.get("word");
		int sno = (Integer) map.get("sno");
		int eno = (Integer) map.get("eno");

		sql = new StringBuffer();
		sql.append(" SELECT bbsno, wname, title, viewcnt, ");
		sql.append(" 		wdate, indent, filename, r ");
		sql.append(" FROM( ");
		sql.append(" 		SELECT bbsno, wname, title, viewcnt, ");
		sql.append(" 			   wdate, indent, filename, rownum r ");
		sql.append("		FROM (");
		sql.append("		 	   SELECT bbsno, wname, title, viewcnt, wdate, indent, filename");
		sql.append(" 	   		   FROM bbs");
		if (word.trim().length() > 0)
			sql.append("   WHERE " + col + " LIKE   '%'|| ? ||'%'  ");
		sql.append(" 	   ORDER BY grpno DESC, ansnum ASC )");
		sql.append(" ) ");
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
			list = new ArrayList<BbsDTO>();

			while (rs.next() == true) {
				int bbsno = rs.getInt("bbsno"); // 컬럼 -> 변수로 변환, DBMS -> JAVA
				String wname = rs.getString("wname");
				String title = rs.getString("title");
				int viewcnt = rs.getInt("viewcnt");
				String wdate = rs.getString("wdate");
				int indent = rs.getInt("indent");
				String filename = rs.getString("filename");

				BbsDTO dto = new BbsDTO(); // 하나의 레코드를 하나의 객체로 변환
				dto.setBbsno(bbsno);
				dto.setWname(wname);
				dto.setTitle(title);
				dto.setViewcnt(viewcnt);
				dto.setWdate(wdate);
				dto.setIndent(indent);
				dto.setFilename(filename);

				list.add(dto); // 저장소에 하나의 객체를 저장

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
			;
		}

		return list;

	}

	public boolean create(BbsDTO dto) {
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();

		boolean flag = false;
		int cnt = 0;

		sql.append(" INSERT INTO bbs(bbsno, wname, title, content, passwd, wdate, grpno,  ");
		sql.append(" filename, filesize) ");
		sql.append(" VALUES((SELECT NVL(MAX(bbsno), 0) + 1 as bbsno FROM bbs), ");
		sql.append(" ?, ?, ?, ?, sysdate, (SELECT NVL(MAX(grpno), 0) + 1 as grpno FROM bbs), ");
		sql.append(" ?, ? ) ");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getWname());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPasswd());
			pstmt.setString(5, dto.getFilename());
			pstmt.setInt(6, dto.getFilesize());

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

	public List<BbsDTO> list() {
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = null; // String 보다 처리 속도가 수만배 빠름.
		List<BbsDTO> list = null;

		sql = new StringBuffer();
		sql.append(" SELECT bbsno, wname, title, viewcnt, wdate, grpno, indent, ansnum, filename, filesize");
		sql.append(" FROM bbs");
		sql.append(" ORDER BY bbsno DESC");

		try {
			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			list = new ArrayList<BbsDTO>();

			while (rs.next() == true) {
				int bbsno = rs.getInt("bbsno"); // 컬럼 -> 변수로 변환, DBMS -> JAVA
				String wname = rs.getString("wname");
				String title = rs.getString("title");
				int viewcnt = rs.getInt("viewcnt");
				String wdate = rs.getString("wdate");
				int grpno = rs.getInt("grpno");
				int indent = rs.getInt("indent");
				int ansnum = rs.getInt("ansnum");

				BbsDTO dto = new BbsDTO(); // 하나의 레코드를 하나의 객체로 변환
				dto.setBbsno(bbsno);
				dto.setWname(wname);
				dto.setTitle(title);
				dto.setViewcnt(viewcnt);
				dto.setWdate(wdate);
				dto.setGrpno(grpno);
				dto.setIndent(indent);
				dto.setAnsnum(ansnum);
				dto.setFilename(rs.getString("filename"));
				dto.setFilesize(rs.getInt("filesize"));

				list.add(dto); // 저장소에 하나의 객체를 저장

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}

		return list;
	}

	public BbsDTO read(int bbsno) {
		BbsDTO dto = null;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();

		sql.append(" SELECT bbsno, wname, title, content, viewcnt, wdate, ");
		sql.append(" filename, filesize");
		sql.append(" FROM bbs");
		sql.append(" WHERE bbsno = ?");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);

			rs = pstmt.executeQuery();

			if (rs.next() == true) {
				String title = rs.getString("title");
				String content = rs.getString("content");
				String wname = rs.getString("wname");
				int viewcnt = rs.getInt("viewcnt");
				String wdate = rs.getString("wdate");

				dto = new BbsDTO(); // 하나의 레코드를 하나의 객체로 변환
				dto.setBbsno(bbsno);
				dto.setWname(wname);
				dto.setTitle(title);
				dto.setContent(content);
				dto.setViewcnt(viewcnt);
				dto.setWdate(wdate);
				dto.setFilename(rs.getString("filename"));
				dto.setFilesize(rs.getInt("filesize"));
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}

		return dto;
	}

	public void upViewcnt(int bbsno) {
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();

		sql.append(" UPDATE bbs");
		sql.append(" SET viewcnt = viewcnt + 1");
		sql.append(" WHERE bbsno = ?");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);

			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}
	}

	public int checkPasswd(int bbsno, String passwd) {
		// boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		int cnt = 0;

		sql.append(" SELECT COUNT(bbsno) as cnt");
		sql.append(" FROM bbs");
		sql.append(" WHERE bbsno=? AND passwd=?");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);
			pstmt.setString(2, passwd);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				cnt = rs.getInt("cnt");
				// flag = true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}

		return cnt;
	}

	public boolean passCheck(Map map) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();

		int bbsno = (Integer) map.get("bbsno");
		String passwd = (String) map.get("passwd");

		sql.append(" SELECT COUNT(bbsno) as cnt");
		sql.append(" FROM bbs");
		sql.append(" WHERE bbsno=? AND passwd=?");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);
			pstmt.setString(2, passwd);

			rs = pstmt.executeQuery();
			rs.next();

			int cnt = rs.getInt("cnt");

			if (cnt > 0)
				flag = true;

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}

		return flag;
	}

	public boolean update(BbsDTO dto) {
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" UPDATE bbs");
		sql.append(" SET wname=?, title=?, content=? ");

		if(dto.getFilesize()>0){
			sql.append("     ,filename=?, filesize=?");	
		}
		sql.append(" WHERE bbsno = ?");
		
		boolean flag = false;

		try {
			int i = 0;
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(++i, dto.getWname());
			pstmt.setString(++i, dto.getTitle());
			pstmt.setString(++i, dto.getContent());
			if(dto.getFilesize()>0){
				pstmt.setString(++i, dto.getFilename());
				pstmt.setInt(++i, dto.getFilesize());
			}
			pstmt.setInt(++i, dto.getBbsno());
			

			int cnt = pstmt.executeUpdate();

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

	public boolean delete(int bbsno) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();

		sql.append(" DELETE FROM bbs");
		sql.append(" WHERE bbsno = ?");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);

			int cnt = pstmt.executeUpdate();
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

	public BbsDTO readReply(int bbsno) {
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();

		BbsDTO dto = null;

		sql.append(" SELECT bbsno,title,grpno,indent,ansnum ");
		sql.append(" FROM bbs");
		sql.append(" WHERE bbsno = ?");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				String title = rs.getString("title");
				int grpno = rs.getInt("grpno");
				int indent = rs.getInt("indent");
				int ansnum = rs.getInt("ansnum");

				dto = new BbsDTO();
				dto.setBbsno(bbsno);
				dto.setTitle(title);
				dto.setGrpno(grpno);
				dto.setIndent(indent);
				dto.setAnsnum(ansnum);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(rs, pstmt, con);
		}

		return dto;

	}

	public boolean reply(BbsDTO dto) {
		boolean flag = false;

		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();

		sql.append(" INSERT INTO bbs(bbsno, wname, title, ");
		sql.append(" content, passwd, wdate, grpno, indent, ansnum, refno, filename, filesize) ");
		sql.append(" VALUES((SELECT NVL(MAX(bbsno), 0) + 1 as bbsno FROM bbs), ?, ?, ?, ?, sysdate,  ");
		sql.append(" ?, ?, ?, ?, ?, ?) ");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getWname());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPasswd());
			pstmt.setInt(5, dto.getGrpno());
			pstmt.setInt(6, dto.getIndent() + 1);
			pstmt.setInt(7, dto.getAnsnum() + 1);
			pstmt.setInt(8, dto.getBbsno());
			pstmt.setString(9, dto.getFilename());
			pstmt.setInt(10, dto.getFilesize());

			int cnt = pstmt.executeUpdate();
			if (cnt > 0)
				flag = true;

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}

		return flag;
	}

	public void addAnsnum(int grpno, int ansnum) {
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();

		sql.append(" UPDATE bbs");
		sql.append(" SET ansnum = ansnum + 1");
		sql.append(" WHERE grpno=? AND ansnum > ?");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, grpno);
			pstmt.setInt(2, ansnum);

			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(pstmt, con);
		}

	}

}
