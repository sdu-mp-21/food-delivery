from users.models import Address

from rest_framework import serializers


class UserAddressSerializer(serializers.ModelSerializer):
    class Meta:
        model = Address
        exclude = ('user',)
