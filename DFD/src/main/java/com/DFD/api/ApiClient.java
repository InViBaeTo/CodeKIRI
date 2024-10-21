package com.DFD.api;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class ApiClient {
    public String getUserData() {
        String response = "";
        try {
            String apiUrl = "http://192.168.219.115:5000/api/user-data"; // <flask_server_ip>를 실제 Flask 서버 IP로 변경
            URL url = new URL(apiUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            int responseCode = conn.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                String inputLine;
                StringBuilder responseBuilder = new StringBuilder();

                while ((inputLine = in.readLine()) != null) {
                    responseBuilder.append(inputLine);
                }
                in.close();
                response = responseBuilder.toString();  // 응답 저장
            } else {
                System.out.println("GET 요청 실패: " + responseCode);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return response;  // API 응답 반환
    }
}
