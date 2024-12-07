package com.ecommerce.ecommerce.dao;

import com.ecommerce.ecommerce.models.Order;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.transaction.Transactional;

import java.util.List;

public class OrderDAO {

    private static final String PERSISTENCE_UNIT_NAME = "ecommercePU";
    private EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);

    @Transactional
    public void createOrder(Order order) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            entityManager.getTransaction().begin();
            entityManager.persist(order);
            entityManager.getTransaction().commit();
        } finally {
            entityManager.close();
        }
    }

    public Order findOrderById(Long id) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            return entityManager.find(Order.class, id);
        } finally {
            entityManager.close();
        }
    }

    public List<Order> getAllOrders() {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            return entityManager.createQuery("SELECT o FROM Order o", Order.class).getResultList();
        } finally {
            entityManager.close();
        }
    }

    @Transactional
    public void updateOrder(Order order) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            entityManager.getTransaction().begin();
            entityManager.merge(order);
            entityManager.getTransaction().commit();
        } finally {
            entityManager.close();
        }
    }

    @Transactional
    public void deleteOrder(Long id) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            entityManager.getTransaction().begin();
            Order order = entityManager.find(Order.class, id);
            if (order != null) {
                entityManager.remove(order);
            }
            entityManager.getTransaction().commit();
        } finally {
            entityManager.close();
        }
    }
}
