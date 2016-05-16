from django.conf import settings
from rest_framework import viewsets, permissions
from rest_framework.pagination import LimitOffsetPagination

from . import serializers, models


class AuthenticatedMixin(object):
    permission_classes = [permissions.IsAuthenticated]


class PaginatedMixin(object):
    class CustomPagination(LimitOffsetPagination):
        max_limit = settings.REST_FRAMEWORK['MAX_LIMIT']

    pagination_class = CustomPagination


class ProfileViewSet(AuthenticatedMixin, PaginatedMixin, viewsets.ModelViewSet):
    queryset = models.Profile.objects.all()
    serializer_class = serializers.ProfileSerializer
