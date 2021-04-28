package ru.job4j.servlet;
import org.json.JSONArray;
import ru.job4j.model.Color;
import ru.job4j.model.HbmCar;
//import ru.job4j.dream.model.PsqlStore;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.util.Collection;

public class ColorServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setContentType("text/json");
        resp.setCharacterEncoding("UTF-8");
        Collection<Color> colors = HbmCar.instOf().findAllColors();
        resp.setHeader("Access-Control-Allow-Origin", "*");
        JSONArray jarray = new JSONArray(colors);
        PrintWriter writer = new PrintWriter(resp.getOutputStream());
        writer.println(jarray);
        writer.flush();

    }
}
