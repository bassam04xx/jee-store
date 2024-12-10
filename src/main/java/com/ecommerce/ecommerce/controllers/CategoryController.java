package com.ecommerce.ecommerce.controllers;

import com.ecommerce.ecommerce.dao.CategoryDAO;
import com.ecommerce.ecommerce.models.Category;
import com.ecommerce.ecommerce.models.Product;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/category")
public class CategoryController extends HttpServlet {
    private CategoryDAO categoryDAO;

    @Override
    public void init() {
        categoryDAO = new CategoryDAO(); // Initialize the DAO
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action") == null ? "list" : request.getParameter("action");

        try {
            switch (action) {
                case "add":
                    // Forward to Add Category page
                    request.getRequestDispatcher("/views/admin-views/categories/add-category.jsp").forward(request, response);
                    break;

                case "edit":
                    // Fetch the category by ID and forward to Edit Category page
                    int editId = Integer.parseInt(request.getParameter("id"));
                    Category existingCategory = categoryDAO.getCategoryById(editId);
                    if (existingCategory != null) {
                        request.setAttribute("category", existingCategory);
                        request.getRequestDispatcher("/views/admin-views/categories/edit-category.jsp").forward(request, response);
                    } else {
                        request.setAttribute("error", "Category not found.");
                        request.getRequestDispatcher("/views/admin-views/index.jsp").forward(request, response);
                    }
                    break;

                case "delete":
                    // Delete the category by ID
                    int deleteId = Integer.parseInt(request.getParameter("id"));
                    boolean isDeleted = categoryDAO.deleteCategory(deleteId);
                    if (isDeleted) {
                        response.sendRedirect("category?action=list");
                    } else {
                        request.setAttribute("error", "Failed to delete category.");
                        request.getRequestDispatcher("/views/admin-views/index.jsp").forward(request, response);
                    }
                    break;

                case "list":
                default:
                    // List all categories
                    HttpSession session = request.getSession();
                    List<Category> categories = (List<Category>) session.getAttribute("categories");
                    if (categories != null) {
                        categories = categoryDAO.getAllCategories();
                        session.setAttribute("categories", categories);
                    }
                    request.setAttribute("categories", categories);
                    System.out.println("Categories: " + categories);
                    if ("client".equals(request.getAttribute("Type"))) {
                        request.getRequestDispatcher("/views/user-views/index.jsp").forward(request, response);
                    } else {
                        request.getRequestDispatcher("/views/admin-views/index.jsp").forward(request, response);
                    }
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred.");
            request.getRequestDispatcher("/views/admin-views/index.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                // Add a new category
                String name = request.getParameter("name");
                if (name == null || name.trim().isEmpty()) {
                    request.setAttribute("error", "Category name is required.");
                    request.getRequestDispatcher("/views/admin-views/categories/add-category.jsp").forward(request, response);
                    return;
                }

                Category newCategory = new Category(name);
                boolean isAdded = categoryDAO.addCategory(newCategory);

                if (isAdded) {
                    response.sendRedirect("category?action=list");
                } else {
                    request.setAttribute("error", "Failed to add category.");
                    request.getRequestDispatcher("/views/admin-views/categories/add-category.jsp").forward(request, response);
                }
            } else if ("edit".equals(action)) {
                // Update an existing category
                int id = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("name");

                if (name == null || name.trim().isEmpty()) {
                    request.setAttribute("error", "Category name is required.");
                    request.getRequestDispatcher("/views/admin-views/categories/edit-category.jsp").forward(request, response);
                    return;
                }

                Category category = new Category(id, name);
                boolean isUpdated = categoryDAO.updateCategory(category);

                if (isUpdated) {
                    response.sendRedirect("category?action=list");
                } else {
                    request.setAttribute("error", "Failed to update category.");
                    request.getRequestDispatcher("/views/admin-views/categories/edit-category.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred.");
            request.getRequestDispatcher("/views/admin-views/index.jsp").forward(request, response);
        }
    }
}
