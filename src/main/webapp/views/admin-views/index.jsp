<%@ page import="com.ecommerce.ecommerce.models.*" %>
<%@ page import="com.ecommerce.ecommerce.dao.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Dashboard</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <script>
    tailwind.config = {
      theme: {
        extend: {
          colors: {
            primary: '#3b82f6',
            secondary: '#10b981',
          }
        }
      }
    }
  </script>
</head>
<body class="bg-gray-50 text-gray-900 font-sans">
<%
  // Retrieve session object
  session = request.getSession();
  ProductDAO productDAO = new ProductDAO();
  List<Product> products = productDAO.getAllProducts();
  UserDAO userDAO = new UserDAO();
  List<User> users = userDAO.getAllUsers();
  List<Category> categories = (List<Category>) session.getAttribute("categories");
  CategoryDAO categoryDAO = new CategoryDAO();
  if (categories != null) {
    categories = categoryDAO.getAllCategories();
    session.setAttribute("categories", categories);
  }
  List<Order> orders = (List<Order>) session.getAttribute("orders");
  if (orders == null) {
    response.sendRedirect(request.getContextPath() + "/order?action=list");
    return;
  }
  // Calculate total revenue and number of orders
  double totalRevenue = 0;
  int totalOrders = orders.size();
  for (Order order : orders) {
    totalRevenue += order.getTotalPrice();
  }
  // Calculate orders per day for the chart
  Map<String, Integer> ordersPerDay = new HashMap<>();
  for (Order order : orders) {
    String date = order.getDate().toString().substring(0, 10); // Format date to YYYY-MM-DD
    ordersPerDay.put(date, ordersPerDay.getOrDefault(date, 0) + 1);
  }
  // Calculate products by category
  Map<String, Integer> categoryCounts = new HashMap<>();
  for (Product product : products) {
    int categoryId = product.getCategory_id();
    Category category = categoryDAO.getCategoryById(categoryId);
    String categoryName = category.getName();
    categoryCounts.put(categoryName, categoryCounts.getOrDefault(categoryName, 0) + 1);
  }
%>

<script>
  var totalRevenue = <%= totalRevenue %>;
  var totalOrders = <%= totalOrders %>;
  var ordersPerDay = <%= new Gson().toJson(ordersPerDay) %>;
  var categoryCounts = <%= new Gson().toJson(categoryCounts) %>;
</script>

<div class="flex min-h-screen">
  <!-- Sidebar -->
  <%@include file="static/admin-sidebar2.jsp"%>

  <!-- Main Content -->
  <main class="flex-1 p-8">
    <h1 class="text-3xl font-bold text-gray-800 mb-8">Admin Dashboard</h1>

    <!-- Dashboard Section -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
      <!-- Total Revenue -->
      <div class="bg-white rounded-xl shadow-md overflow-hidden">
        <div class="p-6">
          <div class="flex items-center">
            <div class="p-3 rounded-full bg-blue-500 bg-opacity-10">
              <svg class="h-8 w-8 text-blue-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
            </div>
            <div class="ml-4">
              <p class="text-sm font-medium text-gray-500">Total Revenue</p>
              <p class="text-2xl font-semibold text-gray-900">$<span id="totalRevenue"></span></p>
            </div>
          </div>
        </div>
      </div>

      <!-- Total Orders -->
      <div class="bg-white rounded-xl shadow-md overflow-hidden">
        <div class="p-6">
          <div class="flex items-center">
            <div class="p-3 rounded-full bg-green-500 bg-opacity-10">
              <svg class="h-8 w-8 text-green-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z" />
              </svg>
            </div>
            <div class="ml-4">
              <p class="text-sm font-medium text-gray-500">Total Orders</p>
              <p class="text-2xl font-semibold text-gray-900"><span id="totalOrders"></span></p>
            </div>
          </div>
        </div>
      </div>

      <!-- Average Order Value -->
      <div class="bg-white rounded-xl shadow-md overflow-hidden">
        <div class="p-6">
          <div class="flex items-center">
            <div class="p-3 rounded-full bg-purple-500 bg-opacity-10">
              <svg class="h-8 w-8 text-purple-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 7h6m0 10v-3m-3 3h.01M9 17h.01M9 14h.01M12 14h.01M15 11h.01M12 11h.01M9 11h.01M7 21h10a2 2 0 002-2V5a2 2 0 00-2-2H7a2 2 0 00-2 2v14a2 2 0 002 2z" />
              </svg>
            </div>
            <div class="ml-4">
              <p class="text-sm font-medium text-gray-500">Average Order Value</p>
              <p class="text-2xl font-semibold text-gray-900">$<span id="averageOrderValue"></span></p>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Charts Section -->
    <div class="mt-8 grid grid-cols-1 lg:grid-cols-2 gap-8">
      <!-- Orders by Date Chart -->
      <div class="bg-white p-6 rounded-xl shadow-md">
        <h2 class="text-xl font-bold text-gray-800 mb-4">Orders by Date</h2>
        <canvas id="ordersByDateChart" class="w-full h-64"></canvas>
      </div>

      <!-- Top Categories Chart -->
      <div class="bg-white p-6 rounded-xl shadow-md">
        <h2 class="text-xl font-bold text-gray-800 mb-4">Top Categories</h2>
        <canvas id="categoryChart" class="w-full h-64"></canvas>
      </div>
    </div>
  </main>
</div>

<script>
  // Set the dynamic data for Total Revenue and Orders
  document.getElementById("totalRevenue").innerText = totalRevenue.toFixed(2);
  document.getElementById("totalOrders").innerText = totalOrders;
  document.getElementById("averageOrderValue").innerText = (totalRevenue / totalOrders).toFixed(2);

  // Create the orders by date chart
  var ctx1 = document.getElementById('ordersByDateChart').getContext('2d');
  var dates = Object.keys(ordersPerDay);
  var counts = Object.values(ordersPerDay);

  var ordersByDateChart = new Chart(ctx1, {
    type: 'line',
    data: {
      labels: dates,
      datasets: [{
        label: 'Orders per Day',
        data: counts,
        borderColor: '#3b82f6',
        backgroundColor: 'rgba(59, 130, 246, 0.1)',
        fill: true,
        tension: 0.4
      }]
    },
    options: {
      responsive: true,
      plugins: {
        legend: {
          display: false
        }
      },
      scales: {
        x: {
          grid: {
            display: false
          }
        },
        y: {
          beginAtZero: true,
          ticks: {
            precision: 0
          }
        }
      }
    }
  });

  // Create the top categories chart
  var ctx2 = document.getElementById('categoryChart').getContext('2d');
  var categoryNames = Object.keys(categoryCounts);
  var categoryCountsValues = Object.values(categoryCounts);

  var categoryChart = new Chart(ctx2, {
    type: 'bar',
    data: {
      labels: categoryNames,
      datasets: [{
        label: 'Products per Category',
        data: categoryCountsValues,
        backgroundColor: '#10b981',
        borderColor: '#10b981',
        borderWidth: 1
      }]
    },
    options: {
      responsive: true,
      plugins: {
        legend: {
          display: false
        }
      },
      scales: {
        x: {
          grid: {
            display: false
          }
        },
        y: {
          beginAtZero: true,
          ticks: {
            precision: 0
          }
        }
      }
    }
  });
</script>
</body>
</html>