package ru.job4j.servlet;

import ru.job4j.model.HbmCar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class UpdateCarServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {
        resp.setHeader("Access-Control-Allow-Origin", "*");
       int id = Integer.parseInt(req.getParameter("id"));
        String rst = req.getParameter("rst");
        HbmCar.instOf().updateStatus(id, rst);
    }
}
