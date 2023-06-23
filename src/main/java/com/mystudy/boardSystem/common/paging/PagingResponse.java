package com.mystudy.boardSystem.common.paging;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class PagingResponse<T> {

    private List<HashMap<String, Object>> list = new ArrayList<>();
    private Pagination pagination;

    public List<HashMap<String, Object>> getList() {
		return list;
	}

	public Pagination getPagination() {
		return pagination;
	}
	
	

	@Override
	public String toString() {
		return "PagingResponse [list=" + list + ", pagination=" + pagination + "]";
	}

	public PagingResponse(List<HashMap<String, Object>> list, Pagination pagination) {
        this.list.addAll(list);
        this.pagination = pagination;
    }


}
