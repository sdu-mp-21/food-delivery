from .views import RestaurantViewSet, CategoryViewSet

from rest_framework.routers import DefaultRouter


router = DefaultRouter()

router.register(
    prefix='restaurants', viewset=RestaurantViewSet, basename='restaurants',
)
router.register(
    prefix='categories', viewset=CategoryViewSet, basename='categories',
)

urlpatterns = router.urls
