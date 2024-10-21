package com.DFD.flaskController;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/run-python")
public class RunPythonController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String flaskApiUrl = "http://localhost:5000/api/user-data";  // Flask API URL

        try {
            URL url = new URL(flaskApiUrl);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            connection.setConnectTimeout(5000);
            connection.setReadTimeout(5000);

            int status = connection.getResponseCode();
            BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            String inputLine;
            StringBuilder content = new StringBuilder();
            while ((inputLine = in.readLine()) != null) {
                content.append(inputLine);
            }

            in.close();
            connection.disconnect();

            // Flask API 호출 결과를 JSP 페이지에 전달
            request.setAttribute("apiResult", content.toString());
            request.getRequestDispatcher("/WEB-INF/views/index.jsp").forward(request, response);

        } catch (IOException e) {
            e.printStackTrace();
            response.getWriter().write("Error calling Flask API: " + e.getMessage());
        }
    }
}
