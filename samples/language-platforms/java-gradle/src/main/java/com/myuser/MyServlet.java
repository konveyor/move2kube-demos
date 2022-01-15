package com.myuser;

import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.*;

public class MyServlet extends HttpServlet {
    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        res.setContentType("text/html");
        res.getOutputStream().println("<html><body><h1>This is a Java Gradle web app</h1></body></html>");
    }
}
