package com.ecommerce.ecommerce.dao;

import com.ecommerce.ecommerce.models.OrderItem;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.transaction.Transactional;

import java.util.List;

public class OrderItemDAO {

    private static final String PERSISTENCE_UNIT_NAME = "ecommercePU";
    private EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);

    @Transactional
    public void createOrderItem(OrderItem orderItem) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            entityManager.getTransaction().begin();
            entityManager.persist(orderItem);
            entityManager.getTransaction().commit();
        } finally {
            entityManager.close();
        }
    }

    public OrderItem findOrderItemById(Long id) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            return entityManager.find(OrderItem.class, id);
        } finally {
            entityManager.close();
        }
    }

    public List<OrderItem> getAllOrderItems() {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            return entityManager.createQuery("SELECT oi FROM OrderItem oi", OrderItem.class).getResultList();
        } finally {
            entityManager.close();
        }
    }

    @Transactional
    public void updateOrderItem(OrderItem orderItem) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            entityManager.getTransaction().begin();
            entityManager.merge(orderItem);
            entityManager.getTransaction().commit();
        } finally {
            entityManager.close();
        }
    }

    @Transactional
    public void deleteOrderItem(Long id) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            entityManager.getTransaction().begin();
            OrderItem orderItem = entityManager.find(OrderItem.class, id);
            if (orderItem != null) {
                entityManager.remove(orderItem);
            }
            entityManager.getTransaction().commit();
        } finally {
            entityManager.close();
        }
    }
}
