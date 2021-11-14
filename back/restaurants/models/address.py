from .restaurant import Restaurant

from django.db import models


class Address(models.Model):
    restaurant = models.OneToOneField(Restaurant, on_delete=models.CASCADE)
    latitude = models.FloatField()
    longitude = models.FloatField()
    text_address = models.CharField(max_length=100)
    comment = models.CharField(max_length=100)
