package com.DFD.entity;

import lombok.Data;

@Data
public class DFD_UPLOAD {

	private int file_idx;
	private String file_rname;
	private int file_size;
	private String file_ext;
	private String user_id;
	private String uploaded_at;
	
}
