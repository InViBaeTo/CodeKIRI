package com.DFD.entity;

import lombok.Data;

@Data
public class DFD_ANALYSIS {

	private int result_idx;
	private int img_idx;
	private String analysis_result;
	private int pred_accuracy;
	private String created_at;
	private String analysis_model;
	
	
}
