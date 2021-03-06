from rest_framework import serializers

from ..models import OrderFood


class CreateOrderFoodSerializer(serializers.ModelSerializer):
    class Meta:
        model = OrderFood
        exclude = ('order',)

