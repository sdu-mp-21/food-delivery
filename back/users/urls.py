from .views import UserViewSet, AddressViewSet

from rest_framework.authtoken import views
from rest_framework.routers import DefaultRouter
from django.urls import path


urlpatterns = [
    path('token-auth/', views.obtain_auth_token)
]

router = DefaultRouter()

router.register(
    prefix='users', viewset=UserViewSet, basename='users',
)
router.register(
    prefix='address', viewset=AddressViewSet, basename='address'
)

urlpatterns += router.urls
