package ru.job4j.servlet;

import org.json.JSONArray;
import ru.job4j.model.Car;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collection;
import ru.job4j.model.HbmCar;

public class ShowListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setContentType("text/json");
        resp.setCharacterEncoding("UTF-8");
        Collection<Car> items = HbmCar.instOf().findAllCar();
        resp.setHeader("Access-Control-Allow-Origin", "*");
        JSONArray jsonArray = new JSONArray(items);
        PrintWriter writer = new PrintWriter(resp.getOutputStream());
        writer.println(jsonArray);
        writer.flush();
    }

}
