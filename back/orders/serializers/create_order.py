from rest_framework import serializers

from orders.models import Order
from orders.serializers import CreateOrderFoodSerializer


class CreateOrderSerializer(serializers.ModelSerializer):
    orderfood_set = CreateOrderFoodSerializer(many=True)

    class Meta:
        model = Order
        fields = (
            'foods_price', 'delivery_price', 'persons_count', 'restaurant',
            'user', 'address', 'orderfood_set',
        )
