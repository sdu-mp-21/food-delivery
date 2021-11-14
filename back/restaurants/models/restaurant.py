from django.db import models


class Restaurant(models.Model):
    title = models.CharField(max_length=100)
    rating = models.FloatField(default=0)
    image = models.ImageField(
        upload_to='restaurants_logo', null=True, blank=True
    )
