package com.DFD.mainController;


import com.DFD.api.ApiClient;

public class UserController {
    private ApiClient apiClient = new ApiClient();

    public void fetchUserData() {
        String userData = apiClient.getUserData();
        System.out.println("사용자 데이터: " + userData);
        // 사용자 데이터를 처리하는 로직 추가
    }
}
