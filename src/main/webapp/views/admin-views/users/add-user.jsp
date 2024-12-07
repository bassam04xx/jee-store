<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../static/admin-sidebar.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add User</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans leading-normal tracking-normal">
<div class="min-h-screen flex items-center justify-center w-full p-12">
    <div class="bg-white shadow-lg rounded-lg p-8 w-full m-12">
        <h2 class="text-2xl font-bold text-center mb-6">Add User</h2>
        <form action="${pageContext.request.contextPath}/user?action=add" method="post">
            <!-- Username -->
            <div class="mb-4">
                <label for="username" class="block text-sm font-medium text-gray-700 mb-2">Username</label>
                <input
                        type="text"
                        id="username"
                        name="username"
                        class="block w-full px-3 py-2 border rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 border-gray-300"
                        required>
            </div>
            <!-- Full Name -->
            <div class="mb-4">
                <label for="fullName" class="block text-sm font-medium text-gray-700 mb-2">Full Name</label>
                <input
                        type="text"
                        id="fullName"
                        name="fullName"
                        class="block w-full px-3 py-2 border rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 border-gray-300"
                        required>
            </div>
            <!-- Password -->
            <div class="mb-4">
                <label for="password" class="block text-sm font-medium text-gray-700 mb-2">Password</label>
                <input
                        type="password"
                        id="password"
                        name="password"
                        class="block w-full px-3 py-2 border rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 border-gray-300"
                        required>
            </div>
            <!-- User Type -->
            <div class="mb-4">
                <label for="type" class="block text-sm font-medium text-gray-700 mb-2">User Type</label>
                <select
                        id="type"
                        name="type"
                        class="block w-full px-3 py-2 border rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 border-gray-300"
                        required>
                    <option value="client">Client</option>
                    <option value="admin">Admin</option>
                </select>
            </div>
            <!-- Status (Only for clients) -->
            <div class="mb-4">
                <label for="status" class="block text-sm font-medium text-gray-700 mb-2">Status (For Clients)</label>
                <select
                        id="status"
                        name="status"
                        class="block w-full px-3 py-2 border rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 border-gray-300">
                    <option value="active">Active</option>
                    <option value="banned">Banned</option>
                </select>
            </div>
            <!-- Submit Button -->
            <div class="text-center">
                <button
                        type="submit"
                        class="bg-indigo-600 text-white px-4 py-2 rounded-md hover:bg-indigo-700 focus:ring-2 focus:ring-indigo-500 focus:outline-none">
                    Add User
                </button>
            </div>
        </form>
    </div>
</div>
<%@include file="../static/admin-footer.jsp"%>

</body>
</html>
