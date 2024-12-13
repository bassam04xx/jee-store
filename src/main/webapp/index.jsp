<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>J-Store - Welcome</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');
        body {
            font-family: 'Poppins', sans-serif;
        }
    </style>
</head>
<body class="bg-gradient-to-br from-purple-50 to-indigo-100">

<!-- Navbar -->
<nav class="bg-gradient-to-r from-purple-600 to-indigo-600 p-4 shadow-lg">
    <div class="container mx-auto flex justify-between items-center">
        <div class="text-white text-3xl font-bold tracking-wider flex items-center">
            <i class="fas fa-store mr-2"></i>J-Store
        </div>
        <div class="flex items-center space-x-4">
            <a href="<c:url value='/views/signup.jsp' />" class="text-white hover:text-yellow-300 transition duration-300 flex items-center">
                <i class="fas fa-user-plus mr-2"></i>Sign Up
            </a>
            <a href="<c:url value='/views/login.jsp' />" class="bg-white text-indigo-600 px-4 py-2 rounded-lg hover:bg-yellow-300 hover:text-indigo-700 transition duration-300 flex items-center">
                <i class="fas fa-sign-in-alt mr-2"></i>Sign In
            </a>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="relative py-20 overflow-hidden">
    <div class="absolute inset-0 bg-gradient-to-r from-purple-500/10 to-indigo-500/10 transform -skew-y-6"></div>
    <div class="container mx-auto px-4 relative">
        <div class="text-center max-w-3xl mx-auto">
            <h1 class="text-5xl md:text-6xl font-bold text-indigo-900 mb-6">Welcome to J-Store</h1>
            <p class="text-xl text-gray-600 mb-8">Your portal to a futuristic shopping experience</p>
            <a href="<c:url value='/views/signup.jsp' />" class="inline-block bg-gradient-to-r from-purple-600 to-indigo-600 text-white font-semibold px-8 py-4 rounded-lg hover:from-purple-700 hover:to-indigo-700 transform hover:scale-105 transition duration-300 shadow-lg">
                Start Shopping Now
            </a>
        </div>
    </div>
</section>

<!-- Features Section -->
<section class="py-20">
    <div class="container mx-auto px-4">
        <h2 class="text-3xl font-bold text-center text-indigo-900 mb-12">Why Shop with Us?</h2>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <div class="bg-white rounded-xl p-6 shadow-xl transform hover:-translate-y-2 transition duration-300">
                <div class="w-16 h-16 bg-gradient-to-br from-purple-500 to-indigo-500 rounded-lg flex items-center justify-center mb-6 mx-auto">
                    <i class="fas fa-gem text-white text-2xl"></i>
                </div>
                <h3 class="text-xl font-semibold text-indigo-900 text-center mb-4">Exclusive Products</h3>
                <p class="text-gray-600 text-center">Discover unique items curated just for you, with exceptional quality and style.</p>
            </div>
            <div class="bg-white rounded-xl p-6 shadow-xl transform hover:-translate-y-2 transition duration-300">
                <div class="w-16 h-16 bg-gradient-to-br from-purple-500 to-indigo-500 rounded-lg flex items-center justify-center mb-6 mx-auto">
                    <i class="fas fa-shipping-fast text-white text-2xl"></i>
                </div>
                <h3 class="text-xl font-semibold text-indigo-900 text-center mb-4">Fast Delivery</h3>
                <p class="text-gray-600 text-center">Lightning-fast shipping with real-time tracking and secure handling.</p>
            </div>
            <div class="bg-white rounded-xl p-6 shadow-xl transform hover:-translate-y-2 transition duration-300">
                <div class="w-16 h-16 bg-gradient-to-br from-purple-500 to-indigo-500 rounded-lg flex items-center justify-center mb-6 mx-auto">
                    <i class="fas fa-headset text-white text-2xl"></i>
                </div>
                <h3 class="text-xl font-semibold text-indigo-900 text-center mb-4">24/7 Support</h3>
                <p class="text-gray-600 text-center">Round-the-clock customer service to assist you with any queries.</p>
            </div>
        </div>
    </div>
</section>



<!-- Testimonials Section -->
<section class="bg-white py-20">
    <div class="container mx-auto px-4">
        <h2 class="text-3xl font-bold text-center text-indigo-900 mb-12">What Our Customers Say</h2>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <div class="bg-white rounded-xl p-8 shadow-xl relative">
                <div class="absolute -top-4 left-1/2 transform -translate-x-1/2">
                    <div class="w-8 h-8 bg-gradient-to-br from-purple-500 to-indigo-500 rounded-full flex items-center justify-center">
                        <i class="fas fa-quote-right text-white text-sm"></i>
                    </div>
                </div>
                <p class="text-gray-600 italic mb-6">"The best shopping experience I've ever had. Fast delivery and excellent product quality!"</p>
                <div class="flex items-center">
                    <div class="flex-shrink-0">
                        <div class="w-12 h-12 bg-gradient-to-br from-purple-500 to-indigo-500 rounded-full flex items-center justify-center">
                            <span class="text-white font-semibold">JD</span>
                        </div>
                    </div>
                    <div class="ml-4">
                        <p class="text-indigo-900 font-semibold">John Doe</p>
                        <p class="text-gray-500 text-sm">Verified Buyer</p>
                    </div>
                </div>
            </div>
            <div class="bg-white rounded-xl p-8 shadow-xl relative">
                <div class="absolute -top-4 left-1/2 transform -translate-x-1/2">
                    <div class="w-8 h-8 bg-gradient-to-br from-purple-500 to-indigo-500 rounded-full flex items-center justify-center">
                        <i class="fas fa-quote-right text-white text-sm"></i>
                    </div>
                </div>
                <p class="text-gray-600 italic mb-6">"Amazing customer service! They went above and beyond to help me with my purchase."</p>
                <div class="flex items-center">
                    <div class="flex-shrink-0">
                        <div class="w-12 h-12 bg-gradient-to-br from-purple-500 to-indigo-500 rounded-full flex items-center justify-center">
                            <span class="text-white font-semibold">JS</span>
                        </div>
                    </div>
                    <div class="ml-4">
                        <p class="text-indigo-900 font-semibold">Jane Smith</p>
                        <p class="text-gray-500 text-sm">Verified Buyer</p>
                    </div>
                </div>
            </div>
            <div class="bg-white rounded-xl p-8 shadow-xl relative">
                <div class="absolute -top-4 left-1/2 transform -translate-x-1/2">
                    <div class="w-8 h-8 bg-gradient-to-br from-purple-500 to-indigo-500 rounded-full flex items-center justify-center">
                        <i class="fas fa-quote-right text-white text-sm"></i>
                    </div>
                </div>
                <p class="text-gray-600 italic mb-6">"The product quality exceeded my expectations. Will definitely shop here again!"</p>
                <div class="flex items-center">
                    <div class="flex-shrink-0">
                        <div class="w-12 h-12 bg-gradient-to-br from-purple-500 to-indigo-500 rounded-full flex items-center justify-center">
                            <span class="text-white font-semibold">RJ</span>
                        </div>
                    </div>
                    <div class="ml-4">
                        <p class="text-indigo-900 font-semibold">Robert Johnson</p>
                        <p class="text-gray-500 text-sm">Verified Buyer</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Call to Action Section -->
<section class="py-20 bg-gradient-to-r from-purple-600 to-indigo-600">
    <div class="container mx-auto px-4 text-center">
        <h2 class="text-4xl font-bold text-white mb-6">Ready to Start Shopping?</h2>
        <p class="text-white text-xl mb-8">Join thousands of satisfied customers and experience the future of shopping.</p>
        <div class="flex justify-center space-x-4">
            <a href="<c:url value='/views/signup.jsp' />" class="bg-white text-indigo-600 font-semibold px-8 py-4 rounded-lg hover:bg-yellow-300 transform hover:scale-105 transition duration-300 shadow-lg">
                Create Account
            </a>
            <a href="<c:url value='/views/login.jsp' />" class="bg-transparent border-2 border-white text-white font-semibold px-8 py-4 rounded-lg hover:bg-white hover:text-indigo-600 transform hover:scale-105 transition duration-300">
                Sign In
            </a>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="bg-gradient-to-r from-gray-900 to-indigo-900 text-white py-12">
    <div class="container mx-auto px-4">
        <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
            <div>
                <h3 class="text-2xl font-bold mb-4 flex items-center">
                    <i class="fas fa-store mr-2"></i>J-Store
                </h3>
                <p class="text-gray-400">Your trusted destination for quality products and exceptional service.</p>
            </div>
            <div>
                <h4 class="text-lg font-semibold mb-4">Quick Links</h4>
                <ul class="space-y-2">
                    <li><a href="#" class="text-gray-400 hover:text-white transition duration-300">About Us</a></li>
                    <li><a href="#" class="text-gray-400 hover:text-white transition duration-300">Contact</a></li>
                    <li><a href="#" class="text-gray-400 hover:text-white transition duration-300">FAQs</a></li>
                </ul>
            </div>
            <div>
                <h4 class="text-lg font-semibold mb-4">Follow Us</h4>
                <div class="flex space-x-4">
                    <a href="#" class="text-gray-400 hover:text-white transition duration-300">
                        <i class="fab fa-facebook-f"></i>
                    </a>
                    <a href="#" class="text-gray-400 hover:text-white transition duration-300">
                        <i class="fab fa-twitter"></i>
                    </a>
                    <a href="#" class="text-gray-400 hover:text-white transition duration-300">
                        <i class="fab fa-instagram"></i>
                    </a>
                </div>
            </div>
            <div>
                <h4 class="text-lg font-semibold mb-4">Newsletter</h4>
                <form class="flex">
                    <input type="email" placeholder="Your email" class="bg-gray-800 text-white px-4 py-2 rounded-l-lg focus:outline-none focus:ring-2 focus:ring-purple-500">
                    <button type="submit" class="bg-purple-600 text-white px-4 py-2 rounded-r-lg hover:bg-purple-700 transition duration-300">
                        <i class="fas fa-paper-plane"></i>
                    </button>
                </form>
            </div>
        </div>
        <div class="border-t border-gray-800 mt-8 pt-8 text-center">
            <p class="text-gray-400">&copy; 2024 J-Store. All Rights Reserved.</p>
        </div>
    </div>
</footer>

</body>
</html>