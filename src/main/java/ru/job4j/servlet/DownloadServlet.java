package ru.job4j.servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

public class DownloadServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("photoCar");
        resp.setContentType("photoCar=" + name);
        resp.setContentType("image/png");
        resp.setContentType("application/octet-stream");
        resp.setHeader("Content-Disposition", "attachment; filename=\"" + name + "\"");
        File downloadFile = new File("c:\\CarsPhoto\\" + File.separator + name);
        try (FileInputStream stream = new FileInputStream(downloadFile)){
            resp.getOutputStream().write(stream.readAllBytes());
        }
    }
}
