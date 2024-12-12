<%@include file="../static/admin-sidebar.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Edit Product</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 text-gray-800">
<div class="container mx-auto mt-10">
  <!-- Page Header -->
  <div class="mb-8">
    <h1 class="text-3xl font-bold text-gray-700">Edit Product</h1>
    <p class="text-gray-600 mt-2">Update the details of the product below.</p>
  </div>

  <!-- Form -->
  <form action="${pageContext.request.contextPath}/product?action=edit" method="post" enctype="multipart/form-data"
        class="bg-white shadow-md rounded-lg p-8 space-y-6">
    <!-- Hidden Product ID -->
    <input type="hidden" name="id" value="${product.id}">

    <!-- Name -->
    <div>
      <label for="name" class="block text-gray-700 font-semibold mb-2">Product Name</label>
      <input type="text" id="name" name="name" value="${product.name}" placeholder="Enter product name"
             class="w-full border border-gray-300 px-4 py-2 rounded-lg focus:ring-2 focus:ring-blue-500 focus:outline-none">
    </div>

    <!-- Description -->
    <div>
      <label for="description" class="block text-gray-700 font-semibold mb-2">Description</label>
      <textarea id="description" name="description" placeholder="Enter product description"
                class="w-full border border-gray-300 px-4 py-2 rounded-lg focus:ring-2 focus:ring-blue-500 focus:outline-none h-24">${product.description}</textarea>
    </div>

    <!-- Price -->
    <div>
      <label for="price" class="block text-gray-700 font-semibold mb-2">Price</label>
      <input type="text" id="price" name="price" value="${product.price}" placeholder="Enter product price"
             class="w-full border border-gray-300 px-4 py-2 rounded-lg focus:ring-2 focus:ring-blue-500 focus:outline-none">
    </div>

    <!-- Stock -->
    <div>
      <label for="stock" class="block text-gray-700 font-semibold mb-2">Stock</label>
      <input type="number" id="stock" name="stock" value="${product.stock}" placeholder="Enter product stock"
             class="w-full border border-gray-300 px-4 py-2 rounded-lg focus:ring-2 focus:ring-blue-500 focus:outline-none">
    </div>

    <!-- Image -->
    <div>
      <label for="image" class="block text-gray-700 font-semibold mb-2">Image</label>
      <input type="file" id="image" name="image" accept="image/*"
             class="w-full border border-gray-300 px-4 py-2 rounded-lg focus:ring-2 focus:ring-blue-500 focus:outline-none">
      <!-- Display existing image -->
      <div class="mt-2">
        <p class="text-gray-600 text-sm">Current Image:</p>
        <img src="data:${product.mimeType};base64,${product.imageBase64}" alt="${product.name}" class="w-32 h-32 object-cover rounded-md">


      </div>
    </div>

    <!-- Submit Button -->
    <div class="text-right">
      <button type="submit"
              class="bg-gradient-to-r from-green-500 to-green-700 text-white px-6 py-3 rounded-lg shadow-lg hover:shadow-xl transform hover:scale-105 transition duration-300">
        Update Product
      </button>
    </div>
  </form>
</div>
<%@include file="../static/admin-footer.jsp"%>
</body>
</html>
