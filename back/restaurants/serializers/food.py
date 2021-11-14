from restaurants.models import Food

from rest_framework import serializers


class FoodSerializer(serializers.ModelSerializer):
    class Meta:
        model = Food
        exclude = ('restaurant',)
