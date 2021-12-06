from .views import OrderViewSet

from rest_framework.routers import DefaultRouter


router = DefaultRouter()

router.register(
    prefix='orders', viewset=OrderViewSet, basename='orders'
)

urlpatterns = router.urls
