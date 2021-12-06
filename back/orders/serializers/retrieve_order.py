from rest_framework import serializers

from ..models import Order
from .order_food import OrderFoodSerializer

class RetrieveOrderSerializer(serializers.ModelSerializer):
    orderfood_set = OrderFoodSerializer(many=True)

    class Meta:
        model = Order
        fields = (
            'id', 'status', 'foods_price', 'delivery_price', 'created_at',
            'cooking_at', 'ready_to_delivery_at', 'on_delivery_at',
            'completed_at', 'canceled_at', 'persons_count', 'restaurant',
            'user', 'address', 'orderfood_set',
        )
