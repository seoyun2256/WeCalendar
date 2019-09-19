package com.wecal.db;

public class PagingVO {

	// �� �������� �Խñ� ��
	private int pageSize = 5;
	
	// �� ���� ������ ��
	private int rangeSize = 10;
	
	// ���� ������
	private int currPage = 1;
	
	// ���� ��
	private int currRange = 1;
	
	// �� �Խñ� ��
	private int listCnt;
	
	// �� ������ ��
	private int pageCnt;
	
	// �� �� ��
	private int rangeCnt;
	
	// ����������
	private int startPage = 1;
	
	// �� ������
	private int endPage = 1;
	
	// ���� �ε���
	private int startIndex = 0;
	
	// �� �ε���
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
