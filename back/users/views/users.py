from rest_framework import viewsets
from rest_framework.authentication import (
    SessionAuthentication, TokenAuthentication
)
from rest_framework.permissions import IsAuthenticated
from rest_framework.decorators import (
    action, permission_classes, authentication_classes,
)
from rest_framework.response import Response

from django.contrib.auth.models import User

from users.serializers import UserSerializer, CreateUserSerializer


class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    create_serializer_class = CreateUserSerializer
    authentication_classes = [SessionAuthentication, TokenAuthentication]

    @action(detail=False, methods=['get'])
    def get_user(self, request):
        user = User.objects.get(username=request.user)
        serializer = self.get_serializer(user, data={})
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(serializer.data)

    def get_serializer_class(self):
        if self.action == 'create':
            return self.create_serializer_class
        else:
            return self.serializer_class
