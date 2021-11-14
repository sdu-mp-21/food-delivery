from restaurants.models import PaymentMethods

from rest_framework import serializers


class PaymentMethodsSerializer(serializers.ModelSerializer):
    class Meta:
        model = PaymentMethods
        exclude = ('restaurant',)
