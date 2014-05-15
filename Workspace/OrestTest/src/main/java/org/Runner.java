package org;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.patchBuilder.jdbc.Data;

public class Runner {

    public static void main(String[] args) throws IOException {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("primary");
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        System.out.println("1");
        List<Data> list = new ArrayList<>();
        list = em.createNamedQuery("First_Query", Data.class).getResultList();

        System.out.println("1" + list);
        for (Data temp : list) {
            System.out.println(temp);
        }

        System.out.println("1");
        em.getTransaction().commit();
    }
}
