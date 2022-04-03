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

from users.serializers import UserSerializer, GetOrCreateTokenSerializer


class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    authentication_classes = [SessionAuthentication, TokenAuthentication]
    http_method_names = ['get', 'patch']

    @action(detail=False, methods=['get'])
    def get_user(self, request):
        user = User.objects.get(username=request.user)
        serializer = self.get_serializer(user, data={})
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(serializer.data)
