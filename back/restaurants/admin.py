from .models import Address, PaymentMethods, Restaurant, Schedule, Food

from django.contrib import admin

# Register your models here.


class AddressInline(admin.TabularInline):
    model = Address
    min_num = 1

    def has_delete_permission(self, *args, **kwargs):
        return False


class PaymentMethodsInline(admin.TabularInline):
    model = PaymentMethods

    def has_delete_permission(self, *args, **kwargs):
        return False


class ScheduleInline(admin.TabularInline):
    model = Schedule
    max_num = 7
    min_num = 7

    def has_delete_permission(self, *args, **kwargs):
        return False


class FoodInline(admin.TabularInline):
    model = Food


@admin.register(Restaurant)
class RestaurantAdmin(admin.ModelAdmin):
    inlines = [AddressInline, PaymentMethodsInline, ScheduleInline, FoodInline]
    exclude = ('rating',)
