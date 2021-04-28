package ru.job4j.model;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import java.util.Collection;
import java.util.Date;
import java.util.function.Function;

public class HbmCar implements AutoCloseable, CarStore {
    private final StandardServiceRegistry registry = new StandardServiceRegistryBuilder()
            .configure().build();
    private final SessionFactory sf = new MetadataSources(registry)
            .buildMetadata().buildSessionFactory();

    private static final class Lazy {
        private static final CarStore CAR = new HbmCar();
    }

    public static CarStore instOf() {
        return Lazy.CAR;
    }

    @Override
    public Collection<Color> findAllColors() {
        return this.tx(session -> session.createQuery(" from ru.job4j.model.Color").list());
    }

    @Override
    public Collection<Body> findAllBodies() {
        return this.tx(session -> session.createQuery(" from ru.job4j.model.Body").list());
    }

    @Override
    public Color findColorById(int id) {
        return  this.tx(session -> session.byId(Color.class).load(id));
    }

    @Override
    public Body findBodyById(int id) {
        return  this.tx(session -> session.byId(Body.class).load(id));
    }

    @Override
    public Collection<Car> findAllCar() {
        return this.tx(session -> session.createQuery("from ru.job4j.model.Car").list());
    }

    @Override
    public Advertiser saveAdvert(String name, String phone, String email, String password) {
        return (Advertiser) this.tx(session -> {
            Advertiser advert = new Advertiser();
            advert.setName(name);
            advert.setPhone(phone);
            advert.setEmail(email);
            advert.setPassword(password);
            session.save(advert);
            return advert;
        });
    }

    @Override
    public Collection<Car> findAdvertiserCars(int id) {
        return this.tx(session -> session.createQuery("from ru.job4j.model.Car where advert.id = :id")
        .setParameter("id", id).getResultList());
    }

    @Override
    public Advertiser findAdvertByDate(String email, String password) {
        return (Advertiser) this.tx(session -> session.
                createQuery(" from ru.job4j.model.Advertiser where email like :email and password like :password").
                setParameter("email", email).setParameter("password", password).getSingleResult());
    }

    @Override
    public Car save(String model, String name, String type, Date date, String photo,
                    String description, Advertiser advert) {
        Color color = this.findColorById(Integer.parseInt(name));
        Body body = this.findBodyById(Integer.parseInt(type));
        return this.tx(session -> {
            Car car = new Car();
            car.setCarModel(model);
            car.setColor(color);
            car.setBody(body);
            car.setCreated(date);
            car.setPhoto(photo);
            car.setDescription(description);
            car.setAdvert(advert);
            session.save(car);
            return car;
        });
    }

    @Override
    public Car findCarById(int id) {
        return this.tx(session -> session.byId(Car.class).load(id));
    }

    @Override
    public void updateStatus(int id, String filter) {
        Car car = this.findCarById(id);
        if (filter.equals("Yes")) {
            car.setSold(true);
        } else if (filter.equals("No")) {
            car.setSold(false);

        }
        this.tx(session -> {
            session.update(car);
            return null;
        });
    }

    private <T> T tx(final Function<Session, T> command) {
        final Session session = sf.openSession();
        final Transaction tx = session.beginTransaction();
        try {
            T rsl = command.apply(session);
            tx.commit();
            return rsl;
        } catch (final Exception e) {
            session.getTransaction().rollback();
            throw e;
        } finally {
            session.close();
        }
    }

    @Override
    public void close() {
        StandardServiceRegistryBuilder.destroy(registry);
    }


}
