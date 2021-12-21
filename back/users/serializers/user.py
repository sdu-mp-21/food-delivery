from rest_framework import serializers
from django.contrib.auth.models import User

from .address import UserAddressSerializer


class UserSerializer(serializers.ModelSerializer):
    id = serializers.IntegerField(required=False)
    username = serializers.CharField(required=False)
    first_name = serializers.CharField(required=False)
    last_name = serializers.CharField(required=False)
    address_set = UserAddressSerializer(many=True, required=False)

    class Meta:
        model = User
        fields = (
            'id', 'username', 'first_name', 'last_name', 'address_set',
        )
