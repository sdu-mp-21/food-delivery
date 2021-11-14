from django.db import models

from .restaurant import Restaurant


class Schedule(models.Model):
    class DayOfWeek(models.TextChoices):
        MONDAY = 'monday'
        TUESDAY = 'tuesday'
        WEDNESDAY = 'wednesday'
        THURSDAY = 'thursday'
        FRIDAY = 'friday'
        SATURDAY = 'saturday'
        SUNDAY = 'sunday'

    restaurant = models.ForeignKey(Restaurant, on_delete=models.CASCADE)
    start_weekday = models.CharField(max_length=100, choices=DayOfWeek.choices)
    started_at = models.TimeField()
    end_weekday = models.CharField(max_length=100, choices=DayOfWeek.choices)
    ended_at = models.TimeField()
