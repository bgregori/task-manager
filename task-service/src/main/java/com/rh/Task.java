package com.rh;

import javax.persistence.Entity;

import io.quarkus.hibernate.orm.panache.PanacheEntity;

@Entity
public class Task extends PanacheEntity {

    public String title;
    public String task_text;
    public Boolean completed;

}
