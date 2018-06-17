package com.model;

public class Ray {
    String Ray_Name ;
    int Price ;

    public Ray(String ray_Name, int price) {
        Ray_Name = ray_Name;
        Price = price;
    }

    public String getRay_Name() {
        return Ray_Name;
    }

    public void setRay_Name(String ray_Name) {
        Ray_Name = ray_Name;
    }

    public int getPrice() {
        return Price;
    }

    public void setPrice(int price) {
        Price = price;
    }
}
