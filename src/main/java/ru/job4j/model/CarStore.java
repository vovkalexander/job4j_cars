package ru.job4j.model;

import java.util.Collection;
import java.util.Date;

public interface CarStore {

    Car save(String model, String color, String body, Date date, String photo,
    String description, Advertiser advert);

    Collection<Car> findAllCar();

    Collection<Color> findAllColors();

    Collection<Body> findAllBodies();

    Color findColorById(int id);

    Body findBodyById(int id);

    Advertiser saveAdvert(String name, String phone, String email, String password);

    Advertiser findAdvertByDate(String email, String password);

    Car findCarById(int id);

    void updateStatus(int id, String filter);

    Collection<Car> findAdvertiserCars(int id);
}
