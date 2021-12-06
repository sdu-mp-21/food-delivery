from rest_framework import serializers

from ..models import OrderFood


class OrderFoodSerializer(serializers.ModelSerializer):
    class Meta:
        model = OrderFood
        exclude = ('order',)
