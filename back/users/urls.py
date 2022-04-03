from .views import UserViewSet, AddressViewSet, TokenViewSet

from rest_framework.authtoken import views
from rest_framework.routers import DefaultRouter
from django.urls import path

router = DefaultRouter()

router.register(
    prefix='users', viewset=UserViewSet, basename='users',
)
router.register(
    prefix='address', viewset=AddressViewSet, basename='address',
)
router.register(
    prefix='token', viewset=TokenViewSet, basename='token',
)

urlpatterns = router.urls
