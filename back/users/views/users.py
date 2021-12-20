from rest_framework import viewsets

from django.contrib.auth.models import User

from users.serializers import UserSerializer, CreateUserSerializer


class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    create_serializer_class = CreateUserSerializer

    def get_serializer_class(self):
        if self.action == 'create':
            return self.create_serializer_class
        else:
            return self.serializer_class
