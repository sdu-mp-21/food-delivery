from django.db import models


class OrderFood(models.Model):
    order = models.ForeignKey(to='orders.Order', on_delete=models.CASCADE)
    title = models.CharField(max_length=100)
    dish_price = models.IntegerField()
    total_amount = models.IntegerField()
    count = models.IntegerField()
