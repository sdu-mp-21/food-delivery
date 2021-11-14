from restaurants.models import Restaurant
from restaurants.serializers import (
    RetrieveRestaurantSerializer, ListRestaurantSerializer
)

from rest_framework import viewsets


class RestaurantModelViewSet(viewsets.ModelViewSet):
    list_serializer_class = ListRestaurantSerializer
    retrieve_serializer_class = RetrieveRestaurantSerializer
    http_method_names = ['get']

    def get_serializer_class(self):
        serializers = {
            'list': self.list_serializer_class,
            'retrieve': self.retrieve_serializer_class,
        }
        return serializers[self.action]

    def get_queryset(self):
        if self.action == 'list':
            return Restaurant.objects.prefetch_related(
                'schedule_set'
            ).select_related('address', 'paymentmethods').all()
        elif self.action == 'retrieve':
            return Restaurant.objects.select_related().prefetch_related().all()
