from restaurants.models import Restaurant
from .address import AddressSerializer
from .payment_methods import PaymentMethodsSerializer
from .schedule import ScheduleSerializer
from .food import FoodSerializer

from rest_framework import serializers


class RetrieveRestaurantSerializer(serializers.ModelSerializer):
    address = AddressSerializer()
    paymentmethods = PaymentMethodsSerializer()
    schedule_set = ScheduleSerializer(many=True)
    food_set = FoodSerializer(many=True)

    class Meta:
        model = Restaurant
        fields = (
            'id', 'title', 'image', 'rating', 'address', 'paymentmethods',
            'schedule_set', 'food_set',
        )
