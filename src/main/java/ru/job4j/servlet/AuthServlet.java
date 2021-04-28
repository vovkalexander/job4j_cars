package ru.job4j.servlet;

import ru.job4j.model.Advertiser;
import ru.job4j.model.HbmCar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class AuthServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        Advertiser advert = HbmCar.instOf().findAdvertByDate(email, password);
        if (advert != null) {
            HttpSession sc = req.getSession();
            sc.setAttribute("advert", advert);
            getServletContext().setAttribute("authAdvert", advert);
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
        } else {
            req.setAttribute("error", "Не верный email или пароль");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }

    }
}
