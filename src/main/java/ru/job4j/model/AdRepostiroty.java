package ru.job4j.model;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.function.Function;
import java.util.logging.SimpleFormatter;

public class AdRepostiroty {
    private final StandardServiceRegistry registry = new StandardServiceRegistryBuilder()
            .configure().build();
    private final SessionFactory sf = new MetadataSources(registry)
            .buildMetadata().buildSessionFactory();

    private static final class Lazy {
        private static final AdRepostiroty CAR = new AdRepostiroty();
    }

    public static AdRepostiroty instOf() {
        return AdRepostiroty.Lazy.CAR;
    }

    public Collection<Car> findByPhoto() {
        return this.tx(session -> session.createQuery("from Car c where c.photo != null")
                .getResultList());
    }

    public Collection<Car> findByCurrentDate() throws ParseException {
        Date currentDate = new SimpleDateFormat("yyyy-MM-dd").parse(LocalDate.now().toString());
        return this.tx(session -> session.createQuery("from Car c where c.dateOfAdverb = :fCurrent")
                .setParameter("fCurrent", currentDate)
                .getResultList());
    }

    public Collection<Car> findByModel(String carModel) {
        return this.tx(session -> session.createQuery("from Car c where c.carModel = :fCar")
                .setParameter("fCar", carModel)
                .getResultList());
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
}
