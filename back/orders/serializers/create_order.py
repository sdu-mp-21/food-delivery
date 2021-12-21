from rest_framework import serializers

from orders.models import Order, OrderFood
from orders.serializers import CreateOrderFoodSerializer


class CreateOrderSerializer(serializers.ModelSerializer):
    orderfood_set = CreateOrderFoodSerializer(many=True)

    class Meta:
        model = Order
        fields = (
            'id', 'foods_price', 'delivery_price', 'persons_count', 'restaurant',
            'user', 'address', 'orderfood_set',
        )

    def create(self, validated_data):
        order = Order.objects.create(
            foods_price=validated_data['foods_price'],
            delivery_price=validated_data['delivery_price'],
            persons_count=validated_data['persons_count'],
            restaurant=validated_data['restaurant'],
            user=validated_data['user'],
            address=validated_data['address'],
        )
        for i in validated_data['orderfood_set']:
            OrderFood.objects.create(order_id=order.id, **i)
        return order

