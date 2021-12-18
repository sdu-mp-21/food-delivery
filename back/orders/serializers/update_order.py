from rest_framework import serializers

from orders.models import Order


class UpdateOrderSerializer(serializers.ModelSerializer):
    class Meta:
        model = Order
        fields = ('status',)

    def update(self, instance, validated_data):
        transitions = {
            Order.Status.WAITING_FOR_PAYMENT: instance.to_cooking,
            Order.Status.COOKING: instance.to_ready_to_delivery,
            Order.Status.READY_TO_DELIVERY: instance.to_on_delivery,
            Order.Status.ON_DELIVERY: instance.to_completed,
            Order.Status.CANCELED: instance.to_cancel,
        }
        transitions[validated_data['status']]()
