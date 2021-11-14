from .views import RestaurantModelViewSet

from rest_framework.routers import DefaultRouter


router = DefaultRouter()

router.register(
    prefix='restaurants', viewset=RestaurantModelViewSet, basename='restaurants'
)

urlpatterns = router.urls
