from django.contrib.auth.models import User
from django.contrib.auth import authenticate
from rest_framework import serializers
from rest_framework.authtoken.models import Token


class GetOrCreateTokenSerializer(serializers.ModelSerializer):
    username = serializers.CharField(write_only=True)
    password = serializers.CharField(write_only=True)
    first_name = serializers.CharField(required=False, write_only=True)
    last_name = serializers.CharField(required=False, write_only=True)
    token = serializers.CharField(source='key', read_only=True)

    class Meta:
        model = Token
        fields = (
            'username', 'password', 'first_name', 'last_name', 'token',
        )

    def save(self, **kwargs):
        validated_data = {**self.validated_data, **kwargs}
        user = authenticate(
            username=validated_data['username'],
            password=validated_data['password'],
        )
        token, created = Token.objects.get_or_create(user=user)
        return token
