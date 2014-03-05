package org;

import java.io.IOException;
import java.util.ArrayList;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.patchBuilder.jdbc.Data;

public class Runner {
    public static final String OUTPUT_FILE_PATH = "D:\\output\\result.sql";
    public static final String INPUT_FILE_PATH1 = "D:\\input\\result-c4-temp1.xml";
    public static final String INPUT_FILE_PATH2 = "D:\\input\\result-c4-temp2.xml";

    public static void main(String[] args) throws IOException {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("primary");
        EntityManager em = emf.createEntityManager();

        ArrayList<Data> list = new ArrayList<>();
        list = (ArrayList<Data>) em.createNamedQuery("First_Query").getResultList();

        for (Data temp : list) {
            System.out.println(temp);
        }
    }
}
