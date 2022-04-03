from django.db import models


class Category(models.Model):
    title = models.CharField(max_length=100)
    image = models.ImageField(
        upload_to='category_image', null=True, blank=True
    )