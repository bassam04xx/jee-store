<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Signup</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-r from-blue-500 to-purple-600 min-h-screen flex items-center justify-center">
<div class="w-full max-w-md bg-white rounded-lg shadow-md p-6">
  <h2 class="text-2xl font-bold text-gray-800 text-center mb-6">Create an Account</h2>

  <!-- Display error message if any -->
  <c:if test="${not empty error}">
    <div class="bg-red-100 text-red-700 border border-red-500 p-3 rounded mb-4">
        ${error}
    </div>
  </c:if>

  <form action="${pageContext.request.contextPath}/user?action=signup" method="post">
    <div class="mb-4">
      <label for="username" class="block text-gray-700 font-medium mb-2">Username</label>
      <input type="text" id="username" name="username"
             class="w-full px-4 py-2 border rounded-lg text-gray-800 focus:outline-none focus:ring focus:ring-blue-300"
             placeholder="Enter your username" required>
    </div>
    <div class="mb-4">
      <label for="password" class="block text-gray-700 font-medium mb-2">Password</label>
      <input type="password" id="password" name="password"
             class="w-full px-4 py-2 border rounded-lg text-gray-800 focus:outline-none focus:ring focus:ring-blue-300"
             placeholder="Enter your password" required>
    </div>
    <div class="mb-4">
      <label for="fullName" class="block text-gray-700 font-medium mb-2">Full Name</label>
      <input type="text" id="fullName" name="fullName"
             class="w-full px-4 py-2 border rounded-lg text-gray-800 focus:outline-none focus:ring focus:ring-blue-300"
             placeholder="Enter your full name" required>
    </div>
    <button type="submit"
            class="w-full bg-blue-500 hover:bg-blue-600 text-white font-medium py-2 px-4 rounded-lg focus:outline-none focus:ring focus:ring-blue-300">
      Signup
    </button>
  </form>

  <p class="mt-4 text-gray-600 text-center">
    Already have an account?
    <a href="login.jsp" class="text-blue-500 hover:underline">Login here</a>.
  </p>
</div>
</body>
</html>
