from rest_framework import serializers
from django.contrib.auth.models import User

from .address import UserAddressSerializer


class UserSerializer(serializers.ModelSerializer):
    address_set = UserAddressSerializer(many=True)

    class Meta:
        model = User
        fields = (
            'id', 'username', 'first_name', 'last_name', 'address_set',
        )
