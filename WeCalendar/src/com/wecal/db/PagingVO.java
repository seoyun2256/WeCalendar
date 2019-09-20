package com.wecal.db;

public class PagingVO {

	// 한 페이지당 게시글 수
	private int pageSize = 5;
	
	// 한 블럭당 페이지 수
	private int rangeSize = 10;
	
	// 현제 페이지
	private int currPage = 1;
	
	// 현재 블럭
	private int currRange = 1;
	
	// 총 게시글 수
	private int listCnt;
	
	// 총 페이지 수
	private int pageCnt;
	
	// 총 블럭 수
	private int rangeCnt;
	
	// 시작페이지
	private int startPage = 1;
	
	// 끝 페이지
	private int endPage = 1;
	
	// 시작 인덱스
	private int startIndex = 0;
	
	// 끝 인덱스
	private int endIndex = 0;
	
	private int prevPage;
	
	private int nextPage;

	public int getEndIndex() {
		return endIndex;
	}

	public void setEndIndex(int endIndex) {
		this.endIndex = endIndex;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getRangeSize() {
		return rangeSize;
	}

	public void setRangeSize(int rangeSize) {
		this.rangeSize = rangeSize;
	}

	public int getCurrPage() {
		return currPage;
	}

	public void setCurrPage(int currPage) {
		this.currPage = currPage;
	}

	public int getCurrRange() {
		return currRange;
	}

	public void setCurrRange(int currRange) {
		this.currRange = currRange;
	}

	public int getListCnt() {
		return listCnt;
	}

	public void setListCnt(int listCnt) {
		this.listCnt = listCnt;
	}

	public int getPageCnt() {
		return pageCnt;
	}

	public void setPageCnt(int pageCnt) {
		this.pageCnt = pageCnt;
	}

	public int getRangeCnt() {
		return rangeCnt;
	}

	public void setRangeCnt(int rangeCnt) {
		this.rangeCnt = rangeCnt;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public int getStartIndex() {
		return startIndex;
	}

	public void setStartIndex(int startIndex) {
		this.startIndex = startIndex;
	}

	public int getPrevPage() {
		return prevPage;
	}

	public void setPrevPage(int prevPage) {
		this.prevPage = prevPage;
	}

	public int getNextPage() {
		return nextPage;
	}

	public void setNextPage(int nextPage) {
		this.nextPage = nextPage;
	}
	
}
