    document.addEventListener('DOMContentLoaded', () => {
    const cartItems = JSON.parse(localStorage.getItem('current-order')) || [];
    const cartContent = document.getElementById('cart-content');
    const cartFooter = document.getElementById('cart-footer');
    const totalPriceElement = document.getElementById('total-price');

    const renderCartItems = () => {
    cartContent.innerHTML = '';

    if (cartItems.length === 0) {
    cartContent.innerHTML = '<p class="text-gray-600 text-center">Your cart is empty.</p>';
    cartFooter.classList.add('hidden');
    return;
}

    const table = document.createElement('table');
    table.className = 'min-w-full leading-normal';

    table.innerHTML = `
            <thead>
                <tr>
                    <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Product</th>
                    <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Quantity</th>
                    <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Total</th>
                    <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Actions</th>
                </tr>
            </thead>
            <tbody>
                ${cartItems.map(item => `
                    <tr data-product-id="${item.id}">
                        <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm">
                            <div class="flex items-center">
                                <div class="flex-shrink-0 w-10 h-10">
                                    <img class="w-full h-full rounded-full" src="${item.image}" alt="${item.name}">
                                </div>
                                <div class="ml-3">
                                    <p class="text-gray-900 whitespace-no-wrap">${item.name}</p>
                                </div>
                            </div>
                        </td>
                        <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm">
                            <div class="flex items-center">
                                <button class="decrement-quantity bg-gray-200 px-2 py-1 rounded">-</button>
                                <input type="number" value="${item.quantity}" min="1" class="quantity-input w-16 text-center border mx-2">
                                <button class="increment-quantity bg-gray-200 px-2 py-1 rounded">+</button>
                            </div>
                        </td>
                        <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm">
                            <p class="text-gray-900 whitespace-no-wrap">$<span class="total-price">${(item.price * item.quantity).toFixed(2)}</span></p>
                        </td>
                        <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm">
                            <button class="remove-product text-red-600 hover:text-red-900">Remove</button>
                        </td>
                    </tr>`).join('')}
            </tbody>
        `;

    cartContent.appendChild(table);
    cartFooter.classList.remove('hidden');
    updateTotalPrice();
};

    const updateTotalPrice = () => {
    const totalPrice = cartItems.reduce((total, item) => total + (item.price * item.quantity), 0);
    totalPriceElement.textContent = totalPrice.toFixed(2);
};

    const updateCartItem = (productId, newQuantity) => {
    const cartIndex = cartItems.findIndex(item => item.id === productId);
    if (cartIndex !== -1) {
    cartItems[cartIndex].quantity = newQuantity;
    cartItems[cartIndex].total = cartItems[cartIndex].price * newQuantity;
    localStorage.setItem('current-order', JSON.stringify(cartItems));
    renderCartItems();
}
};

    const removeCartItem = (productId) => {
    const updatedCart = cartItems.filter(item => item.id !== productId);
    localStorage.setItem('current-order', JSON.stringify(updatedCart));
    location.reload();
};

    cartContent.addEventListener('click', (event) => {
    const row = event.target.closest('tr');
    if (!row) return;

    const productId = row.getAttribute('data-product-id');

    if (event.target.classList.contains('increment-quantity')) {
    const input = row.querySelector('.quantity-input');
    input.value = parseInt(input.value, 10) + 1;
    updateCartItem(productId, parseInt(input.value, 10));
} else if (event.target.classList.contains('decrement-quantity')) {
    const input = row.querySelector('.quantity-input');
    if (parseInt(input.value, 10) > 1) {
    input.value = parseInt(input.value, 10) - 1;
    updateCartItem(productId, parseInt(input.value, 10));
}
} else if (event.target.classList.contains('remove-product')) {
    removeCartItem(productId);
}
});

    document.getElementById('confirm-order').addEventListener('click', () => {
    fetch('/order', {
    method: 'POST',
    headers: {
    'Content-Type': 'application/json'
},
    body: JSON.stringify(cartItems)
})
    .then(response => {
    if (response.ok) {
    alert('Order confirmed!');
    localStorage.removeItem('current-order');
    location.reload();
} else {
    alert('Failed to confirm the order.');
}
})
    .catch(error => console.error('Error:', error));
});

    renderCartItems();
});
