package com.myweb.www.handler;

import java.util.List;

import com.myweb.www.domain.CommentVO;
import com.myweb.www.domain.PagingVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PagingHandler {

	private int startPage; //하단 페이지네이션의 시작 번호 1,11,21,31...
	private int endPage; //하단 페이지네이션의 끝 번호 10,20,30,40...
	private boolean prev, next;
	
	private int totalCount; // 총 게시글 수(매개변수로 전달)
	private PagingVO pgvo; //매개변수로 전달
	
	private List<CommentVO> cmtList;
	
	
	//생성자에서 모든 값들이 설정되어야 함.
	public PagingHandler(PagingVO pgvo, int totalCount) {
		this.pgvo = pgvo;
		this.totalCount = totalCount;
		
		// 1~10 / 11~20 / 21~30
		// 1부터 10까지 endPage는 변함없이 10이어야 함.
		// 1 2 3 4 ... 10 / 10 나머지를 올려(ceil) 1로 만듬 *10
		this.endPage = (int)Math.ceil(pgvo.getPageNo()/(double)pgvo.getQty())*10;
		
		this.startPage = endPage-9;
		
		// 실제 마지막 페이지
		// 전체 글 수(totalCount) / 현제 페이지에 표시되는 게시글 수(qty) => 올림
		int realEndPage = (int)Math.ceil(totalCount / (double)pgvo.getQty());
		
		if(realEndPage < endPage) {
			this.endPage = realEndPage;
		}
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEndPage;
		
	}
	
	public PagingHandler(PagingVO pgvo, int totalCount, List<CommentVO> cmtList) {
		this(pgvo, totalCount);
		this.cmtList = cmtList;
	}
}
