from rest_framework import serializers

from users.models import Address


class CreateUserAddressSerializer(serializers.ModelSerializer):
    class Meta:
        model = Address
        fields = '__all__'
