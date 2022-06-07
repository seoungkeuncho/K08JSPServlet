package model2.mvcboard;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import utils.BoardPage;

//게시판 목록 요청 처리를 위한 서블릿 클래스
public class ListController extends HttpServlet {
	
	//목록의 경우 메뉴를 클릭한 후 이동하므로 get방식으로 요청하게된다.
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//커넥션풀을 이요한 DB연결을 위해 DAO객체 생성
		MVCBoardDAO dao = new MVCBoardDAO();
		
		//파라미터 및 View로 절단할 데이터를 저장하기 위해 Map컬렉션을 생성
		Map<String ,Object> map = new HashMap<String, Object>();
		
		//검색어 관련 파라미터 처리
		String searchField = req.getParameter("searchField");
		String searchWord = req.getParameter("searchWord");
		
		if(searchWord != null) {
			//검색어를 일력한 경우에만 Model로 전달하기 위해 저장함.
			 map.put("searchField",searchField);
			 map.put("searchField",searchWord);
			 
		}
		//게시물의 갯수를 카운트 함 . 검색어가 있는 경우 Map컬렉션을 통해 절단됨.
		int totalCount= dao.selectCount(map);
		

		/***********페이지 처리 start  **********/
		//서블릿에서 web.xml에 접근하기 위해 application내장객체를 얻어옴.
		ServletContext application = getServletContext();
		//컨텍스트 초기화 파라미터를 얻어옴.
		//한페이지당 출력할 게시물의 갯수
		
		int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
		//한 블럭당 출력할 페이지번호 갯수.
		int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));

		//전체페이지수를 계산한다. (전체게시물의 갯수 / 페이지당게시물갯수 = 결과의 올림처리)
		int totalPage = (int)Math.ceil((double)totalCount/ pageSize);

		/*
		목록에 첫 진입시에는 페이지 관련 파라미터가 없는 상태이므로 무조건 1page로 지정한다.
		특정 페이지로 진입한 경우에는 파라미터를 받아서 구간을 계산해서 얻어옴.
		*/
		int pageNum = 1;
		//파라미터로 넘오는 pageNum이 있다면 값을 얻어와서..
		String pageTemp = req.getParameter("pageNum");
		//정수로 변환한 후 현재 페이지번호로 지정한다.
		if(pageTemp != null && !pageTemp.equals(""))
			pageNum = Integer.parseInt(pageTemp);

		//게시물의 구간을 계산한다.
		//각 페이지에서의 시작번호(rownum)
		int start = (pageNum-1)  * pageSize +1;
		//각 페이지에서의 종료번호(rownum)
		int end = pageNum * pageSize;
		//계산된 값을 Model로 전달하기 위해  Map컬렉션에 저장한다.
		map.put("start",start);
		map.put("end",end);
		
		//현재 페이지에 출력할 게시물을 얻어옴.
		List<MVCBoardDTO> boardLists = dao.selectListPage(map);
		//커넥션풀에 자원반납.
		dao.close();
		
		//페이지 번호를 생성하기 위한 유틸리티 클래스의 메서드 호출
		//모델 1방식의 게시판에서 사용했던 메서드를 그대로 사용한다.
		String pagingImg = BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, "../mvcboard/list.do");
		
		//View로 전달한 데이터를 Map컬렉션에 저장함.
		//페이지번호
		map.put("pagingImg", pagingImg);
		//전체 게시물의 갯수
		map.put("totalCount", totalCount);
		//한페이지당 출력할 게시물의 갯수(설정값)
		map.put("pageSize", pageSize);
		//현재 페이지 번호
		map.put("pageNum", pageNum);
		
		
		//View로 전달할 객체들을 request영역에 저장한다.
		req.setAttribute("boardLists", boardLists);
		req.setAttribute("map", map);
		//View로 포워드를 걸어준다.
		req.getRequestDispatcher("/14MVCBoard/List.jsp").forward(req, resp);
		

	}
}
