package com.myuser;

import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.*;

public class MyServlet extends HttpServlet {
    public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        res.setContentType("text/html");
        PrintWriter pw = res.getWriter();
        pw.println("<html><body><h1>This is a Java Gradle webapp</h1></body></html>");
        pw.close();
    }
}
