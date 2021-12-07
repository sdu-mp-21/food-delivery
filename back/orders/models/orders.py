from django_fsm import FSMField, transition
from django.db import models
from django.conf import settings


class Order(models.Model):
    class Status(models.TextChoices):
        WAITING_FOR_PAYMENT = 'waiting_for_payment', 'Ожидает оплаты'
        COOKING = 'cooking', 'Готовится'
        READY_TO_DELIVERY = 'ready_to_delivery', 'Готова к доставке'
        ON_DELIVERY = 'on_delivery', 'Доставляется'
        COMPLETED = 'completed', 'Завершен'
        CANCELED = 'canceled', 'Отменен'

    status = FSMField(default=Status.WAITING_FOR_PAYMENT)
    foods_price = models.IntegerField()
    delivery_price = models.IntegerField()
    created_at = models.DateTimeField(auto_now_add=True)
    cooking_at = models.DateTimeField(null=True)
    ready_to_delivery_at = models.DateTimeField(null=True)
    on_delivery_at = models.DateTimeField(null=True)
    completed_at = models.DateTimeField(null=True)
    canceled_at = models.DateTimeField(null=True)
    persons_count = models.IntegerField()
    restaurant = models.ForeignKey(
        to='restaurants.Restaurant', on_delete=models.DO_NOTHING
    )
    user = models.ForeignKey(
        to=settings.AUTH_USER_MODEL, on_delete=models.DO_NOTHING
    )
    address = models.ForeignKey(
        to='users.Address', on_delete=models.DO_NOTHING
    )

    @transition(
        field=status, source=Status.WAITING_FOR_PAYMENT,
        target=Status.COOKING
    )
    def to_cooking(self):
        pass

    @transition(
        field=status, source=Status.COOKING,
        target=Status.READY_TO_DELIVERY
    )
    def to_ready_to_delivery(self):
        pass

    @transition(
        field=status, source=Status.READY_TO_DELIVERY,
        target=Status.ON_DELIVERY
    )
    def to_on_delivery(self):
        pass

    @transition(
        field=status, source=Status.ON_DELIVERY,
        target=Status.COMPLETED
    )
    def to_completed(self):
        pass

    @transition(
        field=status, source=[
            Status.WAITING_FOR_PAYMENT, Status.COOKING, Status.ON_DELIVERY,
            Status.READY_TO_DELIVERY,
        ], target=Status.CANCELED
    )
    def to_cancel(self):
        pass