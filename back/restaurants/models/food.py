from restaurants.models import Restaurant

from django.db import models


class Food(models.Model):
    title = models.CharField(max_length=100)
    price = models.IntegerField()
    image = models.ImageField(upload_to='foods_image', null=True, blank=True)
    restaurant = models.ForeignKey(Restaurant, on_delete=models.CASCADE)
    text = models.TextField()
