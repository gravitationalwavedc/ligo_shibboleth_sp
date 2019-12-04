from django.urls import path

from ligo_auth.views import ligo_auth

urlpatterns = [
    path('ligo_auth/', ligo_auth, name="ligo_auth"),
]
