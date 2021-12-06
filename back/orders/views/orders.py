from rest_framework import viewsets

from ..models import Order
from ..serializers import (
    ListOrderSerializer, RetrieveOrderSerializer
)


class OrderViewSet(viewsets.ModelViewSet):
    list_serializer_class = ListOrderSerializer
    retrieve_serializer_class = RetrieveOrderSerializer

    def get_serializer_class(self):
        serializers = {
            'list': self.list_serializer_class,
            'retrieve': self.retrieve_serializer_class
        }
        return serializers[self.action]

    def get_queryset(self):
        if self.action == 'retrieve':
            return Order.objects.select_related().prefetch_related().all()
        else:
            return Order.objects.all()
