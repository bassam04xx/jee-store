<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - J-Store</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap');
        body {
            font-family: 'Poppins', sans-serif;
        }
    </style>
</head>
<body class="bg-gradient-to-br from-purple-400 to-indigo-600 min-h-screen flex items-center justify-center p-4">
<div class="w-full max-w-md bg-white rounded-lg shadow-2xl p-8">
    <h2 class="text-3xl font-bold text-indigo-800 text-center mb-6">Welcome Back!</h2>

    <!-- Display error message if any -->
    <c:if test="${not empty error}">
        <div class="bg-red-100 text-red-700 border border-red-500 p-3 rounded mb-4">
            <i class="fas fa-exclamation-circle mr-2"></i>${error}
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/user?action=signin" method="post">
        <div class="mb-6">
            <label for="username" class="block text-gray-700 font-medium mb-2">Username</label>
            <div class="relative">
                    <span class="absolute inset-y-0 left-0 flex items-center pl-3">
                        <i class="fas fa-user text-gray-400"></i>
                    </span>
                <input type="text" id="username" name="username"
                       class="w-full pl-10 pr-3 py-2 border rounded-lg text-gray-700 focus:outline-none focus:border-indigo-500 focus:ring-1 focus:ring-indigo-500"
                       placeholder="Enter your username" required>
            </div>
        </div>
        <div class="mb-6">
            <label for="password" class="block text-gray-700 font-medium mb-2">Password</label>
            <div class="relative">
                    <span class="absolute inset-y-0 left-0 flex items-center pl-3">
                        <i class="fas fa-lock text-gray-400"></i>
                    </span>
                <input type="password" id="password" name="password"
                       class="w-full pl-10 pr-3 py-2 border rounded-lg text-gray-700 focus:outline-none focus:border-indigo-500 focus:ring-1 focus:ring-indigo-500"
                       placeholder="Enter your password" required>
            </div>
        </div>
        <button type="submit"
                class="w-full bg-gradient-to-r from-purple-500 to-indigo-600 text-white font-medium py-3 px-4 rounded-lg hover:from-purple-600 hover:to-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-opacity-50 transition duration-300">
            <i class="fas fa-sign-in-alt mr-2"></i>Login
        </button>
    </form>

    <p class="mt-6 text-gray-600 text-center">
        Don't have an account?
        <a href="signup.jsp" class="text-indigo-600 hover:text-indigo-800 font-medium">Sign up here</a>
    </p>
</div>
</body>
</html>