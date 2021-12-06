from django.db import models
from django.conf import settings


class Address(models.Model):
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL, on_delete=models.CASCADE
    )
    latitude = models.FloatField()
    longitude = models.FloatField()
    text_address = models.CharField(max_length=100)
    comment = models.CharField(max_length=100)
