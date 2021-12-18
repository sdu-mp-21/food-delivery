from rest_framework import viewsets

from users.models import Address
from users.serializers import UserAddressSerializer, CreateUserAddressSerializer


class AddressViewSet(viewsets.ModelViewSet):
    queryset = Address.objects.all()
    serializer_class = UserAddressSerializer
    create_serializer_class = CreateUserAddressSerializer

    def get_serializer_class(self):
        if self.action == 'create':
            return self.create_serializer_class
        else:
            return self.serializer_class
