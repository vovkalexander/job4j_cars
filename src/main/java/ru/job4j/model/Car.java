package ru.job4j.model;

import javax.persistence.*;
import java.util.Date;

@Entity
public class Car {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @Column(name = "car_model")
    private String carModel;
    @ManyToOne
    @JoinColumn(name = "body_id", foreignKey = @ForeignKey(name = "BODY_ID_FK"))
    private Body body;
    @ManyToOne 
    @JoinColumn(name = "color_id", foreignKey = @ForeignKey(name = "COLOR_ID_FK"))
    private Color color;
    @Column(columnDefinition = "boolean default false")
    private boolean sold;
    @Temporal(TemporalType.DATE)
    private Date created;
    private String photo;
    private String description;
    @ManyToOne
    @JoinColumn(name = "advert_id")
    private Advertiser advert;

    public Car() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCarModel() {
        return carModel;
    }

    public void setCarModel(String carModel) {
        this.carModel = carModel;
    }

    public Body getBody() {
        return body;
    }

    public void setBody(Body body) {
        this.body = body;
    }

    public Color getColor() {
        return color;
    }

    public void setColor(Color color) {
        this.color = color;
    }

    public boolean isSold() {
        return sold;
    }

    public void setSold(boolean sold) {
        this.sold = sold;
    }

    public Date getCreated() {
        return created;
    }

    public void setCreated(Date created) {
        this.created = created;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Advertiser getAdvert() {
        return advert;
    }

    public void setAdvert(Advertiser advert) {
        this.advert = advert;
    }

    @Override
    public String toString() {
        return "Car{" +
                "id=" + id +
                ", carModel='" + carModel + '\'' +
                ", body=" + body +
                ", color=" + color +
                ", sold=" + sold +
                ", created=" + created +
                ", photo='" + photo + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
}
