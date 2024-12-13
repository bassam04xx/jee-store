package com.ecommerce.ecommerce.controllers;

import com.ecommerce.ecommerce.dao.CategoryDAO;
import com.ecommerce.ecommerce.dao.ProductDAO;
import com.ecommerce.ecommerce.models.Category;
import com.ecommerce.ecommerce.models.Product;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@WebServlet("/product")
public class ProductController extends HttpServlet {
    private ProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();  // Initialize the DAO object
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set the products as an attribute in the request
        String action = request.getParameter("action") == null ? "list" : request.getParameter("action");

        switch (action) {
            case "add":
                // Forward to the Add Product page
                CategoryDAO categoryDAO = new CategoryDAO();
                try {
                    List<Category> categories = categoryDAO.getAllCategories();
                    System.out.println("Categories: " + categories);
                    request.setAttribute("categories", categories);
                } catch (Exception e) {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to fetch categories");
                }

                request.getRequestDispatcher("/views/admin-views/products/add-product.jsp").forward(request, response);
                break;

            case "edit":
                // Fetch the product by ID and forward to the Edit Product page
                int editId = Integer.parseInt(request.getParameter("id"));
                System.out.println("Editing product with ID: " + editId);  // Debugging statement
                Product existingProduct = productDAO.getProductById(editId);
                if (existingProduct != null) {
                    request.setAttribute("product", existingProduct);
                    request.getRequestDispatcher("/views/admin-views/products/edit-product.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Product not found.");
                    request.getRequestDispatcher("/views/admin-views/index.jsp").forward(request, response);
                }
                break;

            case "delete":
                try {
                    int deleteId = Integer.parseInt(request.getParameter("id"));
                    System.out.println("Deleting product with ID: " + deleteId); // Debugging statement

                    // Call the delete method
                    boolean isDeleted = productDAO.deleteProduct(deleteId);

                    if (isDeleted) {
                        // If deletion is successful, redirect to the list view
                        List<Product> products = productDAO.getAllProducts();
                        request.getSession().setAttribute("products", products);
                        response.sendRedirect("product?action=list");
                    } else {
                        // If deletion failed, forward to the admin page with error message
                        request.setAttribute("error", "Failed to delete product.");
                        request.getRequestDispatcher("/views/admin-views/index.jsp").forward(request, response);
                    }
                } catch (NumberFormatException e) {
                    // Catch invalid ID format or missing ID
                    System.out.println("Invalid product ID format");
                    request.setAttribute("error", "Invalid product ID.");
                    request.getRequestDispatcher("/views/admin-views/index.jsp").forward(request, response);
                } catch (Exception e) {
                    // Catch any other exceptions
                    e.printStackTrace();
                    request.setAttribute("error", "An error occurred while deleting the product.");
                    request.getRequestDispatcher("/views/admin-views/index.jsp").forward(request, response);
                }
                break;
            case "details":
                // Handle product details action
                int productId = Integer.parseInt(request.getParameter("id"));
                Product product = productDAO.getProductById(productId);
                if (product != null) {
                    request.setAttribute("product", product);  // Pass product data to the JSP
                    request.getRequestDispatcher("/views/user-views/product-details.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Product not found.");
                    request.getRequestDispatcher("/views/user-views/index.jsp").forward(request, response);
                }
                break;
            case "listCategory":
                handleListByCategory(request, response);
                break;

            case "list":
            default:
                // Retrieve session object
                HttpSession session = request.getSession();

                // Check if products are already in the session
                List<Product> products = (List<Product>) session.getAttribute("products");
                if (products == null) {
                    // Fetch from DAO if not present
                    products = productDAO.getAllProducts();
                    session.setAttribute("products", products); // Save products in session
                }

                // Set data as request attribute for the current view
                request.setAttribute("products", products);

                // Debug log
                System.out.println("Products: " + products);

                // Determine user type and forward to the appropriate view
                if ("client".equals(request.getAttribute("Type"))) {
                    request.getRequestDispatcher("/views/user-views/index.jsp").forward(request, response);
                } else {
                    request.getRequestDispatcher("/views/admin-views/index.jsp").forward(request, response);
                }
                break;

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            // Handle file upload for image
            Part filePart = request.getPart("image"); // The name attribute from the form
            InputStream inputStream = filePart.getInputStream(); // Read the file as input stream

            // Convert input stream to byte array
            byte[] imageBytes = inputStream.readAllBytes();

            // Create and save the product
            Product product = new Product();
            product.setName(request.getParameter("name"));
            product.setDescription(request.getParameter("description"));

            // Handle price
            String priceParam = request.getParameter("price");
            if (priceParam != null && !priceParam.trim().isEmpty()) {
                try {
                    product.setPrice(Double.parseDouble(priceParam));
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Invalid price format.");
                    request.getRequestDispatcher("/views/admin-views/products/add-product.jsp").forward(request, response);
                    return;
                }
            } else {
                request.setAttribute("error", "Price is required.");
                request.getRequestDispatcher("/views/admin-views/products/add-product.jsp").forward(request, response);
                return;
            }

            product.setImage(imageBytes); // Set the image bytes
            product.setStock(Integer.parseInt(request.getParameter("stock"))); // Set the stock value
            product.setCategory_id(Integer.parseInt(request.getParameter("category"))); // Handle category

            // Add the product to the database
            productDAO.addProduct(product);
            List<Product> products = productDAO.getAllProducts();
            request.getSession().setAttribute("products", products);

            // Redirect to the product list page after adding
            response.sendRedirect("product?action=list");
        }

        // Handle Edit Product action
        if ("edit".equals(action)) {
            try {
                // Get the product ID to be updated
                int productId = Integer.parseInt(request.getParameter("id"));
                Product existingProduct = productDAO.getProductById(productId);

                if (existingProduct != null) {
                    // Update product details from form input
                    existingProduct.setName(request.getParameter("name"));
                    existingProduct.setDescription(request.getParameter("description"));

                    // Handle price update
                    String priceParam = request.getParameter("price");
                    if (priceParam != null && !priceParam.trim().isEmpty()) {
                        try {
                            existingProduct.setPrice(Double.parseDouble(priceParam));
                        } catch (NumberFormatException e) {
                            request.setAttribute("error", "Invalid price format.");
                            request.getRequestDispatcher("/views/admin-views/products/edit-product.jsp").forward(request, response);
                            return;
                        }
                    } else {
                        request.setAttribute("error", "Price is required.");
                        request.getRequestDispatcher("/views/admin-views/products/edit-product.jsp").forward(request, response);
                        return;
                    }

                    // If a new image is uploaded, handle the update
                    Part filePart = request.getPart("image"); // The name attribute from the form
                    if (filePart != null && filePart.getSize() > 0) {
                        byte[] imageBytes = filePart.getInputStream().readAllBytes(); // Read as byte array

                        // Update image blob in the product object
                        existingProduct.setImage(imageBytes); // For blob storage
                    }

                    // Update the product in the database
                    boolean isUpdated = productDAO.updateProduct(existingProduct);

                    if (isUpdated) {
                        List<Product> products = productDAO.getAllProducts();
                        request.getSession().setAttribute("products", products);
                        // Redirect to the product list page after editing
                        response.sendRedirect("product?action=list");
                    } else {
                        request.setAttribute("error", "Failed to update the product.");
                        request.getRequestDispatcher("/views/admin-views/products/edit-product.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("error", "Product not found.");
                    request.getRequestDispatcher("/views/admin-views/index.jsp").forward(request, response);
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "An unexpected error occurred: " + e.getMessage());
                request.getRequestDispatcher("/views/admin-views/products/edit-product.jsp").forward(request, response);
            }
        }


        // Handle Delete Product action

    }

    private void handleListByCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("listCategory".equals(action)) {
            int categoryId = Integer.parseInt(request.getParameter("id"));
            List<Product> products = productDAO.getProductsByCategoryId(categoryId);
            request.setAttribute("products", products);
            request.getRequestDispatcher("/views/user-views/index.jsp").forward(request, response);
        }
    }
}
