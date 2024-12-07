<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-r from-gray-700 via-gray-900 to-black min-h-screen flex items-center justify-center">
<div class="w-full max-w-md bg-white rounded-lg shadow-md p-6">
    <h2 class="text-2xl font-bold text-gray-800 text-center mb-6">Login to Your Account</h2>

    <!-- Display error message if any -->
    <c:if test="${not empty error}">
        <div class="bg-red-100 text-red-700 border border-red-500 p-3 rounded mb-4">
                ${error}
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/user?action=signin" method="post">
        <div class="mb-4">
            <label for="username" class="block text-gray-700 font-medium mb-2">Username</label>
            <input type="text" id="username" name="username"
                   class="w-full px-4 py-2 border rounded-lg text-gray-800 focus:outline-none focus:ring focus:ring-indigo-300"
                   placeholder="Enter your username" required>
        </div>
        <div class="mb-6">
            <label for="password" class="block text-gray-700 font-medium mb-2">Password</label>
            <input type="password" id="password" name="password"
                   class="w-full px-4 py-2 border rounded-lg text-gray-800 focus:outline-none focus:ring focus:ring-indigo-300"
                   placeholder="Enter your password" required>
        </div>
        <button type="submit"
                class="w-full bg-indigo-500 hover:bg-indigo-600 text-white font-medium py-2 px-4 rounded-lg focus:outline-none focus:ring focus:ring-indigo-300">
            Login
        </button>
    </form>

    <p class="mt-4 text-gray-600 text-center">
        Don't have an account?
        <a href="signup.jsp" class="text-indigo-500 hover:underline">Sign up here</a>.
    </p>
</div>
</body>
</html>
