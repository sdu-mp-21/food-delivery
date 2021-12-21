from django.contrib.auth.models import User
from rest_framework import serializers


class CreateUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = (
            'username', 'password', 'first_name', 'last_name',
        )

    def save(self, **kwargs):
        validated_data = {**self.validated_data, **kwargs}
        user = User.objects.create_user(**validated_data)
        return user
