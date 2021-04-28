package ru.job4j.model;

import javax.persistence.*;

@Entity
@Table(name = "body")
public class Body {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @Column(unique = true)
    private String type;

    public Body() {
    }

    public Body(String type) {
        this.type = type;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @Override
    public String toString() {
        return "Body{" +
                "id=" + id +
                ", type='" + type + '\'' +
                '}';
    }
}
