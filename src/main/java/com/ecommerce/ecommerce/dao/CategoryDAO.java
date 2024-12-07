package com.ecommerce.ecommerce.dao;

import com.ecommerce.ecommerce.models.Category;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.transaction.Transactional;

import java.util.List;

public class CategoryDAO {

    private static final String PERSISTENCE_UNIT_NAME = "ecommercePU";
    private EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);

    @Transactional
    public void createCategory(Category category) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            entityManager.getTransaction().begin();
            entityManager.persist(category);
            entityManager.getTransaction().commit();
        } finally {
            entityManager.close();
        }
    }

    public Category findCategoryById(Long id) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            return entityManager.find(Category.class, id);
        } finally {
            entityManager.close();
        }
    }

    public List<Category> getAllCategories() {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            return entityManager.createQuery("SELECT c FROM Category c", Category.class).getResultList();
        } finally {
            entityManager.close();
        }
    }

    @Transactional
    public void updateCategory(Category category) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            entityManager.getTransaction().begin();
            entityManager.merge(category);
            entityManager.getTransaction().commit();
        } finally {
            entityManager.close();
        }
    }

    @Transactional
    public void deleteCategory(Long id) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            entityManager.getTransaction().begin();
            Category category = entityManager.find(Category.class, id);
            if (category != null) {
                entityManager.remove(category);
            }
            entityManager.getTransaction().commit();
        } finally {
            entityManager.close();
        }
    }
}
