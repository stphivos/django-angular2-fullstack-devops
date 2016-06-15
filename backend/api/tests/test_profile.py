from django_mock_queries.asserts import assert_serializer

from api.models import Profile
from api.serializers import ProfileSerializer
from infrastructure.test_cases import BaseUnitTestCase, BaseIntegrationTestCase


class UnitTestProfile(BaseUnitTestCase):
    def test_profiles_serializer_returns_expected_field_values(self):
        model = self.prepare_model(Profile)

        values = {
            'created': self.format_date(model.created),
            'modified': self.format_date(model.modified),
            'user': model.user_id
        }
        fields = values.keys()

        assert_serializer(ProfileSerializer) \
            .instance(model) \
            .returns(*fields) \
            .values(**values) \
            .run()


class IntegrationTestProfile(BaseIntegrationTestCase):
    base_endpoint = '/profiles/'

    def test_profiles_endpoint_forbids_anonymous_users(self):
        response = self.pub_api().get(self.base_endpoint)

        self.assert_response(response, 401)
