package ru.job4j.servlet;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.json.JSONArray;
import ru.job4j.model.Advertiser;
import ru.job4j.model.Car;
import ru.job4j.model.CarStore;
import ru.job4j.model.HbmCar;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Locale;

public class AddCarServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/json");
        resp.setCharacterEncoding("UTF-8");
        Collection<Car> cars = HbmCar.instOf().findAllCar();
        resp.setHeader("Access-Control-Allow-Origin", "*");
        JSONArray jsonArray = new JSONArray(cars);
        PrintWriter writer = new PrintWriter(resp.getOutputStream());
        writer.println(jsonArray);
        writer.flush();

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletContext servletContext = this.getServletConfig().getServletContext();
        File repository = (File) servletContext.getAttribute("javax.servlet.context.tempdir");
        factory.setRepository(repository);
        ServletFileUpload upload = new ServletFileUpload(factory);
        String carModel = null;
        String colorCar = null;
        String bodyCar = null;
        String dateCar = null;
        String photoCar = null;
        String description = null;
        try {
            List<FileItem> items = upload.parseRequest(req);
            System.out.println(items);

            File folder = new File("c:\\CarsPhoto\\");
            if (!folder.exists()) {
                folder.mkdir();
            }
            for (FileItem item : items) {
                if (item.isFormField()) {
                    if ("carModel".equals(item.getFieldName())) {
                        carModel = item.getString("UTF-8");
                    } else if ("colorCar".equals(item.getFieldName())) {
                        colorCar = item.getString("UTF-8");
                    } else if ("bodyCar".equals(item.getFieldName())) {
                        bodyCar = item.getString("UTF-8");
                    } else if ("dateCar".equals(item.getFieldName())) {
                        dateCar = item.getString("UTF-8");
                    } else if ("description".equals(item.getFieldName())) {
                        description = item.getString("UTF-8");
                    }
                }
                if (!item.isFormField()) {
                    File file = new File(folder + File.separator + item.getName());
                    try (FileOutputStream out = new FileOutputStream(file)) {
                        out.write(item.getInputStream().readAllBytes());
                    }
                    photoCar = item.getName();
                }
            }
        } catch (FileUploadException e) {
            e.printStackTrace();
        }
        CarStore hbmCar = HbmCar.instOf();
        Advertiser advert = (Advertiser) getServletContext().getAttribute("authAdvert");
        try {
           hbmCar.save(carModel, colorCar, bodyCar, parseDate(dateCar),
                   photoCar, description, advert);
       } catch (ParseException e) {
           e.printStackTrace();
       }
        req.getRequestDispatcher("index.jsp").forward(req, resp);

    }

   private Date parseDate(String date) throws ParseException {
       SimpleDateFormat sdf = new  SimpleDateFormat("yyyy-MM-dd", Locale.forLanguageTag("en"));
       return (sdf).parse(date);
    }
}
