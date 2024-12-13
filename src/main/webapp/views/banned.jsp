<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>You've Been Banned</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    animation: {
                        'spin-slow': 'spin 3s linear infinite',
                        'pulse-fast': 'pulse 1s cubic-bezier(0.4, 0, 0.6, 1) infinite',
                    }
                }
            }
        }
    </script>
</head>
<body class="bg-black text-white min-h-screen flex flex-col items-center justify-center p-4 overflow-hidden">
<div class="absolute inset-0 bg-gradient-to-br from-red-900 to-black opacity-50 z-0"></div>
<div class="relative z-10 max-w-2xl w-full text-center">
    <h1 class="text-6xl font-extrabold text-transparent bg-clip-text bg-gradient-to-r from-red-500 to-yellow-500 mb-8 animate-pulse-fast">BANNED</h1>
    <p class="text-2xl font-bold mb-6">You've been exiled to the shadow realm of the internet.</p>
    <div class="bg-red-900 bg-opacity-50 p-6 rounded-lg shadow-lg mb-8">
        <p class="text-xl mb-4">Congratulations on achieving the impossible: being so utterly incompetent that you've managed to get banned from a website designed for literal toddlers.</p>
        <p class="text-lg mb-4">Your digital fingerprint is now more toxic than a radioactive dumpster fire.</p>
        <p class="text-lg">Future archaeologists will study your ban as a prime example of human idiocy in the digital age.</p>
    </div>
    <div class="flex justify-center space-x-4 mb-8">
        <div class="w-16 h-16 bg-red-500 rounded-full animate-spin-slow"></div>
        <div class="w-16 h-16 bg-yellow-500 rounded-full animate-ping"></div>
        <div class="w-16 h-16 bg-red-500 rounded-full animate-spin-slow"></div>
    </div>
    <button id="pleaButton" class="bg-red-600 hover:bg-red-700 text-white font-bold py-2 px-4 rounded transition duration-300 ease-in-out transform hover:scale-105">
        Beg for Forgiveness
    </button>
</div>
<div id="pleaModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden z-10">
    <div class="bg-white text-black p-8 rounded-lg max-w-md">
        <h2 class="text-2xl font-bold mb-4">Nice Try, Banned One</h2>
        <p class="mb-4">Your pathetic plea has been noted and promptly ignored. Did you really think that would work?</p>
        <button id="closeModal" class="bg-red-600 hover:bg-red-700 text-white font-bold py-2 px-4 rounded">
            Accept Your Fate
        </button>
    </div>
</div>
<script>
    const pleaButton = document.getElementById('pleaButton');
    const pleaModal = document.getElementById('pleaModal');
    const closeModal = document.getElementById('closeModal');

    pleaButton.addEventListener('click', () => {
        pleaModal.classList.remove('hidden');
    });

    closeModal.addEventListener('click', () => {
        pleaModal.classList.add('hidden');
    });
</script>
</body>
</html>

