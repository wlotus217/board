package com.mystudy.boardSystem.paging;

import java.util.ArrayList;
import java.util.List;

public class PagingResponse<T> {

    private List<T> list = new ArrayList<>();
    private Pagination pagination;

    public List<T> getList() {
		return list;
	}

	public Pagination getPagination() {
		return pagination;
	}
	
	

	@Override
	public String toString() {
		return "PagingResponse [list=" + list + ", pagination=" + pagination + "]";
	}

	public PagingResponse(List<T> list, Pagination pagination) {
        this.list.addAll(list);
        this.pagination = pagination;
    }


}
