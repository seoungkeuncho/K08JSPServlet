package homework;

import javax.servlet.ServletContext;

import common.JDBConnect;
import membership.MemberDTO;
import model1.board.BoardDTO;

public class MembershipDAO extends JDBConnect{
	public MembershipDAO (String drv,String url ,String id, String pw ) {
		super(drv,url,id,pw);
	}
	
	public MembershipDAO(ServletContext application) {
		super(application);
	}
	
	public MembershipDTO getMembershipDTO(String uid, String upass) {
		
		MembershipDTO dto = new MembershipDTO();
		String query = "SELECT * FROM membership WHERE id=? AND pass=?";
		try {
			//쿼리문 실행을 위한 prepared객체 생성 및 인파라미터 설정.
			psmt = con.prepareStatement(query);
			psmt.setString(1, uid);
			psmt.setString(2, upass);
			rs =psmt.executeQuery();
			
			//반환된 ResultSet객체를 통해 회원정보가 있는지 확인
			if(rs.next()) {
				//정보가 있다면 DTO객체에 회원정보를 저장한다.

				dto.setNum(rs.getString(1));
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString(4));
				dto.setGender(rs.getString(5));
				dto.setBirthday(rs.getString(6));
				dto.setAddress(rs.getString(7));
				dto.setEmailnum(rs.getString(8));
				dto.setMobilenum(rs.getString(9));
				dto.setTelnum(rs.getString(10));
				dto.setRegidate(rs.getString(11));
				
				
			}
		} catch (Exception e) {
			System.out.println("회원 로그인 확인중 오류발생");
			e.printStackTrace();
		}
		
		return dto;
	}
	public int insertMembershipDTO(MembershipDTO dto) {
		int result = 0;
		
		try {

			String query = "INSERT INTO membership ( "
					+ " num, id, pass, name, gender, birthday, address, emailnum, mobilenum, telnum, regidate)  "
					+ "VALUES (seq_membership_num.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ? , sysdate)";
			psmt =con.prepareStatement(query);
			
		
			psmt.setString(1,dto.getId());
			psmt.setString(2,dto.getPass());
			psmt.setString(3,dto.getName());
			psmt.setString(4,dto.getGender());
			psmt.setString(5,dto.getBirthday());
			psmt.setString(6,dto.getAddress());
			psmt.setString(7,dto.getEmailnum());
			psmt.setString(8,dto.getMobilenum());
			psmt.setString(9,dto.getTelnum());
		
			
			result =psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("회원가입 입력중 예외 발생 ");
			e.printStackTrace();
		}
		return result;
	}
	
	
}