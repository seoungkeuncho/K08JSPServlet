package model1.board;



import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;

import common.JDBConnect;

public class BoardDAO extends JDBConnect{
	//DAO클래스의 생성자 .부모 클래스의 생정자 호출을 통해 DB에 연결한다.
	public BoardDAO(ServletContext application) {
		super(application);
	}
	/*
	 board 테이블에 저장된 게시물의 갯수를 카운트 하기 위한 메서드
	 카운트 한 결과값을 통해 목록 출력시 게시물의 순번을 출력한다.
	 만약 검색어가 있는 경우를 대비해서 Map컬렉션을 매개변수로 선언한다.
	 */
	public int selectCount(Map<String , Object> map) {
		//카운트 변수
		int totalCount = 0;
		//쿼리문 작성
		String query = "SELECT COUNT(*) FROM board";
		//검색어가 있는 경오 where절을 조건부로 추가한다.
		if(map.get("searchWord") !=null) {
			/*
			 만약 제목에 '노트북'dlfkrh rjatorgoTekaus...
			 =>where title like '%노트북%'
			 과 같이 쿼리문이 추가될것이다.
			 */
			query += "WHERE " + map.get("searchField") + " "
				+ " LIKE '%" + map.get("searchWord") + "%' ";
		}
		
		try {
			//?가 없는 정적쿼리문으로 Statement객체를 통해 실행한다.
			stmt = con.createStatement();
			rs =stmt.executeQuery(query);
			//count(*)를 통한 쿼리문은 항상 0혹은 정수의 결과가 있으므로 if문이 필요없다
			//next() 메서드를 통해 결과를 한행 읽어온다.
			rs.next();
			//결과값을 변수에 저장한다.
			totalCount = rs.getInt(1);
			
		} catch (Exception e) {
			System.out.println("게시물 수를 구하는 중 예외발생");
			e.printStackTrace();
		}
		//결과값을 반환한다.
		return totalCount;
		
	}
	/*
	 목록에 출력할 게시물을 오라클로부터 추출하기 위한 쿼리문을 실행한다.
	 */
	public List<BoardDTO> selectList(Map<String ,Object>map){
		/*
		 select한 게시물의 목록은 다수의 레코드가 포함되므로 이를 저장하기 위해
		 순서를 보장하는 List계열의 컬렉션이 필요하다.Set 컬렉션은 순서를 보장하지
		 못하므로 게시판 목록을 출력하는 용도로는 사용할 수없다 .
		 */
		//List<BoardDTO> bbs = new Vector<BoardDTO>();
		List<BoardDTO> bbs = new ArrayList<BoardDTO>();
		
		/*
		 목록에 출력할 게시물을 추출하기 위한 쿼리문으로 항상 일련번호(작성순)의
		 역순(내림차순)으로 정렬해야한다. 게시판의 목록은 최근 게시물이 제일
		 위쪽에 노출되기 때문이다.
		 */
		String query = "SELECT * FROM board ";
		if(map.get("searchWord") !=null) {
			query += "WHERE " + map.get("searchField") + " "
				+ " LIKE '%" + map.get("searchWord") + "%' ";
		}
		query += " ORDER BY num DESC ";
		
		try {
			stmt = con.createStatement();
			rs =stmt.executeQuery(query);
			
			//추출된 결과에 따라 갯수만큼 반복한다.
			while(rs.next()) {
				//하나의 레코드를 읽어서 추출한 후 DTO객체에 저장한다.
				//DTO객체를 생성한 후 ..
				BoardDTO dto = new BoardDTO();
				//각 멤버변수에 해당하는 컬럼을 매칭하여 데이터를 저장한다.
				dto.setNum(rs.getString("num"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getString("visitcount"));
				
				//하나의 레코드를 DTO저장한 후 List컬렉션에 추가한다.
				bbs.add(dto);
				
			}
		} catch (Exception e) {
			System.out.println("게시물 조회중 예외발생");
			e.printStackTrace();
		}
		//List.jsp로 컬렉션을 반환한다.
		return bbs;
	}
	//사용자가 입력한 내용을 board테이블에 입력(insert)처리한다.
	public int insertWrite(BoardDTO dto) {
		//입력결과 확인용 변수
		int result = 0;
		
		try {
			//인파라미터가 있는 동적 쿼리문 작성(사용자의 입력에 따라 달라짐)
			String query = "INSERT INTO BOARD("
					+ "num,title,content,id,visitcount)"
					+ "values("
					+ "seq_board_num.nextval, ?, ?, ?, 0)";
			//동적쿼리문 실행을 위한 prepared객체 생성
			psmt= con.prepareStatement(query);
			//인파라미터 설정
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getId());
			//쿼리문 실행 :행에 영향을 미치는 쿼리이므로 executeUpdate()메서드 사용함.
			//입력에 성공하면 1, 실패하면 0을 반환한다.
			result = psmt.executeUpdate();
					
		} catch (Exception e) {
			System.out.println("게시물 입력 중 예외발생");
			e.printStackTrace();
		}
		return result;
	}
	//상세보기를 위해 매개변수로 전달된 일련번호에 해당하는 게시물을 인출한다.
	public BoardDTO selectView(String num) {
		
		BoardDTO dto = new BoardDTO();
		//join을 이용해서 member테이블의 name컬럼까지 가져온다. 
		String query = "select B.*, M.name "
				+ " from member M inner join board B "
				+ " on M.id = B.id "
				+ " where num=?";    
		
		try {
			psmt= con.prepareStatement(query);
			psmt.setString(1, num);
			rs=psmt.executeQuery();
			
			//일련 번호는 중복되지 않으므로 if문으로 처리한다.
			//게시판 목록처럼 여러개의 레코드를 가져온다면 while문을 사용하면된다.
			if(rs.next()) {
				//DTO에 레코드의 내용을 추가한다.
				dto.setNum(rs.getString(1));
				dto.setTitle(rs.getString(2));//인덱스를 통해 값 인출
				dto.setContent(rs.getString("content"));//컬럼명을 통해 값 인출
				dto.setPostdate(rs.getDate("postdate"));//날짜 타입이므로 getDate()로 인출
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getString(6));
				dto.setName(rs.getString("name"));
				
				}
			}
			catch (Exception e) {
				System.out.println("게시물 상세보기 중 예외발생");
				e.printStackTrace();
			}
			return dto;
		}
	//게시물의 조회수를 1증가 시킨다.
	public void updateVisitCount(String num) {
		//게시물의 일련번호를 매개변수로 받은후 visitcount를 1증가 시킨다.
		String query = "update board set "
				+ "visitcount=visitcount+1 "
				+ "where num=?";
		
		try {
			psmt= con.prepareStatement(query);
			psmt.setString(1, num);
			rs=psmt.executeQuery();
			
		} catch (Exception e) {
			System.out.println("게시물 조회수 증가 중  예외발생");
			e.printStackTrace();
		}
	}
	public int updateEdit(BoardDTO dto) {
		//입력결과 확인용 변수
		int result = 0;
		
		try {
			//인파라미터가 있는 동적 쿼리문 작성(사용자의 입력에 따라 달라짐)
			// 특정일련번호에 해당하는 게시물을 수정한다.
			String query = "update board set "
					+ "    title=?, content =? "
					+ "    where num=?";
			//동적쿼리문 실행을 위한 prepared객체 생성
			psmt= con.prepareStatement(query);
			//인파라미터 설정
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getNum());
			//쿼리문 실행 :행에 영향을 미치는 쿼리이므로 executeUpdate()메서드 사용함.
			//입력에 성공하면 1, 실패하면 0을 반환한다.
			
			//적용된(수정된)행의 갯수를 반환한다.
			result = psmt.executeUpdate();
					
		} catch (Exception e) {
			System.out.println("게시물 수정 중 예외발생");
			e.printStackTrace();
		}
		return result;
	}
	//게시물 삭제를 위해 delete쿼리문을 실행한다.
	public int deletePost(BoardDTO dto) {
		//입력결과 확인용 변수
		int result = 0;
		
		try {
			//인파라미터가 있는 동적 쿼리문 작성(사용자의 입력에 따라 달라짐)
			// ? 
			String query = "delete  from  board where num=?";
			
			//동적쿼리문 실행을 위한 prepared객체 생성
			psmt= con.prepareStatement(query);
			//인파라미터 설정
			psmt.setString(1, dto.getNum());
			
			
			//쿼리문 실행 :행에 영향을 미치는 쿼리이므로 executeUpdate()메서드 사용함.
			//입력에 성공하면 1, 실패하면 0을 반환한다.
			// 적용된(삭제된)행의 갯수를 반환한다.
			result = psmt.executeUpdate();
					
		} catch (Exception e) {
			System.out.println("게시물 삭제 중 예외발생");
			e.printStackTrace();
		}
		return result;
	}
	public List<BoardDTO> selectListPage(Map<String ,Object>map){
		List<BoardDTO> bbs = new ArrayList<BoardDTO>();
		
		/*
		 3개의 서브쿼리문을 통해 각 페이지에 출력할 게시판 목록을
		 인출 할 수있는 쿼리문을 작성한다.
		 */
		String query = "select * from ( "
				+ "    select tb.*, rownum rNum from ( "
				+ "        select * from board ";
		//검색조건추가.검색어가 있는 경우에에만 where 절이 추가된다.
		if(map.get("searchWord") !=null) {
			query += "WHERE " + map.get("searchField") +" "
				+ " LIKE '%" + map.get("searchWord") + "%' ";
		}
		query += " ORDER BY num DESC "
				+ " ) Tb " 
				+ " ) "
				+ " WHERE rNum BETWEEN ? AND ?";
		/*
		 betwwen절 대신 비교연산자를 사용하면 다음과 같이 수정할 수 있다.
		 =>where rNum>= ? and rNum<=?		
		 */
				
		
		try {
			psmt = con.prepareStatement(query);
			/*
			 인파라미터 설정 : Jsp에서 해당 페이지에 출력할 게시물의 구간을
			 	계산한 후 Map컬렉션에 저장하고 DAO로 전달하면 해당 값으로
			 	쿼리문을 완성한다.
			 */
			psmt.setString(1, map.get("start").toString());
			psmt.setString(2, map.get("end").toString());
			//쿼리문 실행
			rs =psmt.executeQuery();
			
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setNum(rs.getString("num"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getString("visitcount"));
				
				//반환할 결과 목록을 List컬렉션에 추가한다.
				bbs.add(dto);
				
			}
		} catch (Exception e) {
			System.out.println("게시물 조회중 예외발생");
			e.printStackTrace();
		}
		return bbs;
	}
}
