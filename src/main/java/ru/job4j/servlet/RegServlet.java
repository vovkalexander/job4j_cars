package ru.job4j.servlet;

import ru.job4j.model.HbmCar;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RegServlet extends HttpServlet {
    @Override
    public void  doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String phone = req.getParameter("tel");
        String password = req.getParameter("password");
        HbmCar.instOf().saveAdvert(name, phone, email, password);
        req.getRequestDispatcher("login.jsp").forward(req, resp);
    }
}
