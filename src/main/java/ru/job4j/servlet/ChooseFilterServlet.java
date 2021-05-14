package ru.job4j.servlet;


import org.json.JSONObject;
import ru.job4j.model.AdRepostiroty;
import ru.job4j.model.Car;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.text.ParseException;
import java.util.Collection;

public class ChooseFilterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setContentType("text/json");
        resp.setCharacterEncoding("UTF-8");
        StringBuffer sb = new StringBuffer();
        Collection<Car> cars = null;
        String line = null;
        String filter = null;
        BufferedReader reader = req.getReader();
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
        JSONObject jsonObject =  new JSONObject(sb.toString());
        filter = jsonObject.getString("filter");
        if (filter.equals("withPhoto")) {
            cars = AdRepostiroty.instOf().findByPhoto();
        } else if (filter.equals("current")) {
            try {
                cars = AdRepostiroty.instOf().findByCurrentDate();
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        getServletContext().setAttribute("filterCars", cars);
    }
}
