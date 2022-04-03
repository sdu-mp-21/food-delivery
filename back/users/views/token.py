from users.serializers import GetOrCreateTokenSerializer

from rest_framework import viewsets


class TokenViewSet(viewsets.ModelViewSet):
    create_serializer_class = GetOrCreateTokenSerializer
    http_method_names = ('post',)

    def get_serializer_class(self):
        return self.create_serializer_class
