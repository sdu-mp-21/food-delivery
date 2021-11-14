from .restaurant import Restaurant

from django.db import models


class PaymentMethods(models.Model):
    restaurant = models.OneToOneField(Restaurant, on_delete=models.CASCADE)
    cash = models.BooleanField()
    card = models.BooleanField()
