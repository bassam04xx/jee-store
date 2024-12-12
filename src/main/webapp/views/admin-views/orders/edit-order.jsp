<%@ include file="../static/admin-sidebar.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Edit Order</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 text-gray-800">
<div class="container mx-auto mt-10">
  <!-- Page Header -->
  <div class="mb-8">
    <h1 class="text-3xl font-bold text-gray-700">Edit Order</h1>
    <p class="text-gray-600 mt-2">Update the status of the order below.</p>
  </div>

  <!-- Form -->
  <form action="${pageContext.request.contextPath}/order?action=edit" method="post" class="bg-white shadow-md rounded-lg p-8 space-y-6">
    <!-- Hidden Order ID -->
    <input type="hidden" name="id" value="${order.id}">

    <!-- Status -->
    <div>
      <label for="status" class="block text-gray-700 font-semibold mb-2">Order Status</label>
      <select id="status" name="status" class="w-full border border-gray-300 px-4 py-2 rounded-lg focus:ring-2 focus:ring-blue-500 focus:outline-none">
        <option value="PENDING" ${order.status == 'PENDING' ? 'selected' : ''}>Pending</option>
        <option value="SHIPPED" ${order.status == 'SHIPPED' ? 'selected' : ''}>Shipped</option>
        <option value="DELIVERED" ${order.status == 'DELIVERED' ? 'selected' : ''}>Delivered</option>
        <option value="CANCELLED" ${order.status == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
      </select>
    </div>

    <!-- Submit Button -->
    <div class="text-right">
      <button type="submit" class="bg-gradient-to-r from-blue-500 to-blue-700 text-white px-6 py-3 rounded-lg shadow-lg hover:shadow-xl transform hover:scale-105 transition duration-300">
        Update Status
      </button>
    </div>
  </form>
</div>
<%@ include file="../static/admin-footer.jsp" %>
</body>
</html>