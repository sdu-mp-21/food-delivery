from rest_framework import serializers

from ..models import Order


class ListOrderSerializer(serializers.ModelSerializer):
    restaurant_title = serializers.CharField(source='restaurant.title')

    class Meta:
        model = Order
        fields = (
            'id', 'status', 'foods_price', 'delivery_price', 'created_at',
            'restaurant_title',
        )
