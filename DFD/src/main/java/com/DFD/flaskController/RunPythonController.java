package com.DFD.flaskController;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/run-python")
public class RunPythonController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String apiResponse = callFlaskApi(); // Flask API 호출
        
        request.setAttribute("apiResponse", apiResponse); // 응답 결과를 request에 저장
        
        String url = "WEB-INF/views/index.jsp"; // index.jsp의 경로
        RequestDispatcher rd = request.getRequestDispatcher(url);
        rd.forward(request, response); // 결과를 index.jsp로 전달
    }

    private String callFlaskApi() {
        String response = "";
        try {
            String apiUrl = "http://192.168.219.115:5000/api/user-data"; // Flask 서버의 IP 주소로 변경
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
                response = responseBuilder.toString();
            } else {
                response = "Flask API 요청 실패: " + responseCode;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response = "Flask API 호출 중 오류 발생: " + e.getMessage();
        }
        return response;
    }
}